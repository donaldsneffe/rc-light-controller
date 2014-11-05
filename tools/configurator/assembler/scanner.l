/*

Jison lexer file for light programs

Light programs are simple programs that are interpreted by the
LANE Boys RC light controller (TLC5940/LPC812 version)


reserved keywords:
  goto, var, led, leds, sleep, skip, if, is, any, all, none, not, fade, stepsize,
  run, when, or, master, slave, global, random, steering, throttle, gear, abs

  clicks: Pre-defined global variable; increments when 6-clicks on CH3

*/





%options flex

%%
"0"[xX][\da-fA-F]+ {
  line_is_empty = false;
  yy.logger.log(MODULE, "DEBUG", "Hex-number: " + yytext);
  yytext = parseInt(yytext, 16);
  return "NUMBER";
}

("-"?)[\d]+ {
  line_is_empty = false;
  yy.logger.log(MODULE, "DEBUG", "Number: " + yytext);
  yytext = parseInt(yytext, 10);
  return "NUMBER";
}

"run" {
  line_is_empty = false;
  parse_state = "EXPECTING_RUN_CONDITION";
  yy.logger.log(MODULE, "DEBUG", "Reserved word: " + yytext);
  return yytext.toUpperCase();
}

"is"|"any"|"all"|"none"|"not" {
  line_is_empty = false;
  parse_state = "EXPECTING_CAR_STATE";
  yy.logger.log(MODULE, "DEBUG", "Reserved word: " + yytext);
  return yytext.toUpperCase();
}

"goto"|"var"|"leds"|"led"|"sleep"|"skip"|"if"|"fade"|"stepsize"|"when"|"or"|"master"|"slave"|"global"|"random"|"steering"|"throttle"|"abs"|"end" {
  line_is_empty = false;
  yy.logger.log(MODULE, "DEBUG", "Reserved word: " + yytext);
  return yytext.toUpperCase();
}

[a-zA-Z][a-zA-Z0-9_\-]* {
  line_is_empty = false;
  var symbol = yy.symbols.get_symbol(yytext, parse_state);
  yy.logger.log(MODULE, "DEBUG", "Identifier: " + yytext + " (" + symbol.token + "=0x" + symbol.opcode.toString(16) + ") parse_state=" + parse_state);
  return symbol.token;
}

"="|"+="|"-="|"*="|"/="|"&="|"|="|"^=" {
  line_is_empty = false;
  var symbol = yy.symbols.get_reserved_word(yytext);
  yy.logger.log(MODULE, "DEBUG", "Assignment " + yytext + " (" + symbol.token + "=0x" + symbol.opcode.toString(16) + ")");
  return symbol.token;
}

"=="|"!="|">="|"<="|">"|"<" {
  line_is_empty = false;
  var symbol = yy.symbols.get_reserved_word(yytext);
  yy.logger.log(MODULE, "DEBUG", "Comparison " + yytext + " (" + symbol.token + "=0x" + symbol.opcode.toString(16) + ")");
  return symbol.token;
}

"["|"]"|","|":"|"%" {
  line_is_empty = false;
  yy.logger.log(MODULE, "DEBUG", "'" + yytext + "'");
  return yytext;
}

"//"[^\n]*  /* eat up one-line comments */
";"[^\n]*   /* eat up one-line comments */
[ \t]+      /* eat up whitespace */

\\[ \t]*(("//"|;)[^\n]*)*\n {
  /* eat up continuation characters '\', and the following \n */
  /* Comments can appear in after the '\' character */
  yy.logger.log(MODULE, "DEBUG", "emtpy line");
}

\n %{        /* Only ever give back a single in sequence \n */
  parse_state = "UNKNOWN_PARSE_STATE";

  if (!line_is_empty) {
    line_is_empty = true;
    yy.logger.log(MODULE, "DEBUG", "NEWLINE");
    return "NEWLINE";
  }
%}

. {
  yy.logger.log(MODULE, "DEBUG", "Unrecognized character " + yytext);
  return yytext;
}

/* <<EOF>>               return 'EOF'; */


