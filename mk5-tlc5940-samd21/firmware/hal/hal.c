#include <stdint.h>
#include <stdio.h>

#include <hal.h>
#include <uart.h>


volatile uint32_t milliseconds;


// These are all defined by the linker via the samd21e15.ld linker script.
extern unsigned int _ram;
extern unsigned int _stacktop;


void SysTick_handler(void);
void HardFault_handler(void);
void SERCOM0_irq_handler(void);


DECLARE_GPIO(UART_TXD, GPIO_PORTA, 4)
DECLARE_GPIO(UART_RXD, GPIO_PORTA, 5)

DECLARE_GPIO(SIN, GPIO_PORTA, 22)       // SERCOM3/PAD0
DECLARE_GPIO(SCLK, GPIO_PORTA, 23)      // SERCOM3/PAD1
DECLARE_GPIO(XLAT, GPIO_PORTA, 28)

#define UART_SERCOM SERCOM0
#define UART_SERCOM_GCLK_ID SERCOM0_GCLK_ID_CORE
#define UART_SERCOM_APBCMASK PM_APBCMASK_SERCOM0
#define UART_TXD_PMUX PORT_PMUX_PMUXE_D_Val
#define UART_RXD_PMUX PORT_PMUX_PMUXE_D_Val

#define SPI_SERCOM  SERCOM3
#define SPI_SERCOM_GCLK_ID SERCOM3_GCLK_ID_CORE
#define SPI_SERCOM_APBCMASK PM_APBCMASK_SERCOM3
#define SPI_SCLK_PMUX PORT_PMUX_PMUXE_C_Val
#define SPI_SIN_PMUX PORT_PMUX_PMUXE_C_Val



/*
    Macro-magic to extract the calibration values from the bit-fields stored
    in the NVM of the SAMD21.

    We first retrieve a uint32_t pointer to the word where the calibration
    value resides, based on the lowest bit number of the bit field (i.e.
    NVM_USB_TRANSN_START).

    Then we shift the bits down so that the lowest bit ends up at bit 0 of
    the value. We have to do this modulo 32 bits. Then we create a mask
    based on the number of bits (END-START+1) and AND it to the value. Now
    the resulting number is the desired calibration value.

    Reference: Datasheet chapter "NVM Software Calibration Area Mapping"
*/
#define NVM_USB_TRANSN_START 45
#define NVM_USB_TRANSN_END 49

#define NVM_USB_TRANSP_START 50
#define NVM_USB_TRANSP_END 54

#define NVM_USB_TRIM_START 55
#define NVM_USB_TRIM_END 57

#define NVM_DFLL48M_COARSE_CAL_START 58
#define NVM_DFLL48M_COARSE_CAL_END 63

#define NVM_GET_CALIBRATION_VALUE(name) \
    ((*((uint32_t *)NVMCTRL_OTP4 + NVM_##name##_START / 32)) >> (NVM_##name##_START % 32)) & ((1 << (NVM_##name##_END - NVM_##name##_START + 1)) - 1)



#define RECEIVE_BUFFER_SIZE (16)        // Must be modulo 2 for speed
#define RECEIVE_BUFFER_INDEX_MASK (RECEIVE_BUFFER_SIZE - 1)
static uint8_t receive_buffer[RECEIVE_BUFFER_SIZE];
static volatile uint16_t read_index = 0;
static volatile uint16_t write_index = 0;


// ****************************************************************************
void SysTick_handler(void)
{
    ++milliseconds;
}


// ****************************************************************************
void HardFault_handler(void)
{
    uart0_send_cstring("HARD\n");
    while (1);
}

//-----------------------------------------------------------------------------
void SERCOM0_irq_handler(void)
{
    if (UART_SERCOM->USART.INTFLAG.reg & SERCOM_USART_INTFLAG_RXC) {
        receive_buffer[write_index++] = (uint8_t)UART_SERCOM->USART.DATA.reg;

        // Wrap around the write pointer. This works because the buffer size is
        // a modulo of 2.
        write_index &= RECEIVE_BUFFER_INDEX_MASK;

        // If we are bumping into the read pointer we are dealing with a buffer
        // overflow. Back off and rather destroy the last value.
        if (write_index == read_index) {
            write_index = (write_index - 1) & RECEIVE_BUFFER_INDEX_MASK;
        }
    }
}

// ****************************************************************************
void hal_hardware_init(bool is_servo_reader, bool has_servo_output)
{
    uint32_t coarse;

    (void) is_servo_reader;
    (void) has_servo_output;

    NVMCTRL->CTRLB.reg = NVMCTRL_CTRLB_RWS(2);

    SYSCTRL->INTFLAG.reg =
            SYSCTRL_INTFLAG_BOD33RDY |
            SYSCTRL_INTFLAG_BOD33DET |
            SYSCTRL_INTFLAG_DFLLRDY;

    SYSCTRL->DFLLCTRL.reg = 0;
    while (!(SYSCTRL->PCLKSR.reg & SYSCTRL_PCLKSR_DFLLRDY));

    SYSCTRL->DFLLMUL.reg = SYSCTRL_DFLLMUL_MUL(48000);

    coarse = NVM_GET_CALIBRATION_VALUE(DFLL48M_COARSE_CAL);
    SYSCTRL->DFLLVAL.reg = SYSCTRL_DFLLVAL_COARSE(coarse) | SYSCTRL_DFLLVAL_FINE(512);

    SYSCTRL->DFLLCTRL.reg =
            SYSCTRL_DFLLCTRL_ENABLE |
            SYSCTRL_DFLLCTRL_USBCRM |
            SYSCTRL_DFLLCTRL_BPLCKC |
            SYSCTRL_DFLLCTRL_STABLE |
            SYSCTRL_DFLLCTRL_CCDIS;

    while (!(SYSCTRL->PCLKSR.reg & SYSCTRL_PCLKSR_DFLLRDY));

    GCLK->GENCTRL.reg =
            GCLK_GENCTRL_ID(0) |
            GCLK_GENCTRL_SRC(GCLK_SOURCE_DFLL48M) |
            GCLK_GENCTRL_RUNSTDBY |
            GCLK_GENCTRL_GENEN;

    while (GCLK->STATUS.reg & GCLK_STATUS_SYNCBUSY);


    hal_gpio_switched_light_output_out();


    SysTick_Config((__SYSTEM_CLOCK / 1000) - 1);

    __enable_irq();
}


// ****************************************************************************
void hal_hardware_init_final(void)
{

}


// ****************************************************************************
uint32_t *hal_stack_check(void)
{
    #define CANARY 0xcafebabe

    /*
    There is an issue if we initialize the last_found static variable with
    _stacktop at compile time. For some reason it does not contain the proper
    value.
    We therefore initialize it with 0 and check for that. If we enounter 0 we
    load the _stacktop address and everything works well.

    Worst case the program hangs when last_found is not aligned to 4 bytes, as
    a hard fault is raised.
    */

    static uint32_t *last_found;
    uint32_t *now;

    if (last_found == NULL) {
        last_found = (uint32_t *)&_stacktop;
    }

    now = last_found;

    // for (int i = 0; i < 60; i++) {
    //     uart0_send_uint32_hex(*now--);
    //     uart0_send_linefeed();
    // }
    // uart0_send_linefeed();

    while (*now != CANARY  &&  now > (uint32_t *)&_ram) {
        --now;
    }

    if (now < last_found) {
        last_found = now;
        return now;
    }
    return NULL;
}

// ****************************************************************************
void hal_uart_init(uint32_t baudrate)
{
    uint64_t brr = (uint64_t)65536 * (__SYSTEM_CLOCK - 16 * baudrate) / __SYSTEM_CLOCK;

    hal_gpio_UART_TXD_out();
    hal_gpio_UART_TXD_pmuxen(UART_TXD_PMUX);

    hal_gpio_UART_RXD_in();
    hal_gpio_UART_RXD_pmuxen(UART_RXD_PMUX);

    hal_gpio_XLAT_out();
    hal_gpio_XLAT_clear();


    PM->APBCMASK.reg |= UART_SERCOM_APBCMASK;

    GCLK->CLKCTRL.reg =
        GCLK_CLKCTRL_ID(UART_SERCOM_GCLK_ID) |
        GCLK_CLKCTRL_CLKEN |
        GCLK_CLKCTRL_GEN(0);

    UART_SERCOM->USART.CTRLA.reg =
        SERCOM_USART_CTRLA_DORD |
        SERCOM_USART_CTRLA_MODE(SERCOM_USART_CTRLA_MODE_USART_INT_CLK_Val) |
        SERCOM_USART_CTRLA_RXPO(1/*PAD1*/) |
        SERCOM_USART_CTRLA_TXPO(0/*PAD0*/);

    UART_SERCOM->USART.CTRLB.reg =
        SERCOM_USART_CTRLB_RXEN |
        SERCOM_USART_CTRLB_TXEN |
        SERCOM_USART_CTRLB_CHSIZE(0/*8 bits*/);
    while (UART_SERCOM->USART.SYNCBUSY.reg);

    UART_SERCOM->USART.BAUD.reg = (uint16_t)brr;
    while (UART_SERCOM->USART.SYNCBUSY.reg);

    UART_SERCOM->USART.CTRLA.reg |= SERCOM_USART_CTRLA_ENABLE;
    while (UART_SERCOM->USART.SYNCBUSY.reg);

    UART_SERCOM->USART.INTENSET.reg = SERCOM_USART_INTENSET_RXC;
    NVIC_EnableIRQ(SERCOM0_IRQn);
}


// ****************************************************************************
bool hal_uart_read_is_byte_pending(void)
{
    return (read_index != write_index);
}


// ****************************************************************************
uint8_t hal_uart_read_byte(void)
{
    uint8_t data;

    while (!hal_uart_read_is_byte_pending());

    data = receive_buffer[read_index++];

    // Wrap around the read pointer.
    read_index &= RECEIVE_BUFFER_INDEX_MASK;

    return data;
}


// ****************************************************************************
bool hal_uart_send_is_ready(void)
{
    return (UART_SERCOM->USART.INTFLAG.reg & SERCOM_USART_INTFLAG_DRE);
}


// ****************************************************************************
void hal_uart_send_char(const char c)
{
    while (!(UART_SERCOM->USART.INTFLAG.reg & SERCOM_USART_INTFLAG_DRE));
    UART_SERCOM->USART.DATA.reg = c;
}


// ****************************************************************************
void hal_uart_send_uint8(const uint8_t c)
{
    hal_uart_send_char(c);
}


// ****************************************************************************
void hal_spi_init(void)
{
    int baud = 1;   // 12 MHz SPI clock @ 48 MHz

    hal_gpio_SIN_out();
    hal_gpio_SIN_pmuxen(SPI_SIN_PMUX);

    hal_gpio_SCLK_out();
    hal_gpio_SCLK_pmuxen(SPI_SCLK_PMUX);

    hal_gpio_XLAT_out();
    hal_gpio_XLAT_set();

    PM->APBCMASK.reg |= SPI_SERCOM_APBCMASK;

    GCLK->CLKCTRL.reg =
        GCLK_CLKCTRL_ID(SPI_SERCOM_GCLK_ID) |
        GCLK_CLKCTRL_CLKEN |
        GCLK_CLKCTRL_GEN(0);

    SPI_SERCOM->SPI.CTRLA.reg = SERCOM_SPI_CTRLA_SWRST;

    while (SPI_SERCOM->SPI.CTRLA.reg & SERCOM_SPI_CTRLA_SWRST);

    SPI_SERCOM->SPI.BAUD.reg = baud;

    SPI_SERCOM->SPI.CTRLA.reg =
        SERCOM_SPI_CTRLA_MODE_SPI_MASTER |
        SERCOM_SPI_CTRLA_DOPO(0) |
        SERCOM_SPI_CTRLA_ENABLE ;
}


// ****************************************************************************
void hal_spi_transaction(uint8_t *data, uint8_t count)
{
    hal_gpio_XLAT_clear();

    for (uint8_t i = 0; i < count; i++) {
        SPI_SERCOM->SPI.DATA.reg = data[i];
        while (!SPI_SERCOM->SPI.INTFLAG.bit.DRE);
    }

    while (!SPI_SERCOM->SPI.INTFLAG.bit.TXC);
    hal_gpio_XLAT_set();
}


// ****************************************************************************
volatile const uint32_t *hal_persistent_storage_read(void)
{
    return 0;
}


// ****************************************************************************
const char *hal_persistent_storage_write(const uint32_t *new_data)
{
    (void) new_data;
    return 0;
}


// ****************************************************************************
void hal_servo_output_init(void)
{

}


// ****************************************************************************
void hal_servo_output_set_pulse(uint16_t servo_pulse)
{
    (void) servo_pulse;
}


// ****************************************************************************
void hal_servo_output_enable(void)
{

}


// ****************************************************************************
void hal_servo_output_disable(void)
{

}


// ****************************************************************************
void hal_servo_reader_init(bool CPPM, uint32_t max_pulse)
{
    (void) CPPM;
    (void) max_pulse;
}


// ****************************************************************************
bool hal_servo_reader_get_new_channels(uint32_t *raw_data)
{
    (void) raw_data;
    return false;
}