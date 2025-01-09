// Token
//    init: takes in token_type, lexeme
//    repr: print token

const std = @import("std");
const token = @import("./tokens.zig");

const SingleCharTokens = enum {
    TOK_LPAREN,
    TOK_RPAREN,
    TOK_LCURLY,
    TOK_RCURLY,
    TOK_LSQUAR,
    TOK_RSQUAR,
    TOK_COMMA,
    TOK_DOT,
    TOK_PLUS,
    TOK_MINUS,
    TOK_STAR,
    TOK_SLASH,
    TOK_CARET,
    TOK_MOD,
    TOK_COLON,
    TOK_SEMICOLON, //  ;
    TOK_QUESTION, //  ?
    TOK_NOT, //  ~
    TOK_GT, //  >
    TOK_LT, //  <
};

const TwoCharToken = enum {
    TOK_GE, //  >=
    TOK_LE, //  <=
    TOK_NE, //  ~=
    TOK_EQ, //  ==
    TOK_ASSIGN, //  :=
    TOK_GTGT, //  >>
    TOK_LTLT, //  <<
};

const Literals = enum {
    TOK_IDENTIFIER,
    TOK_STRING,
    TOK_INTEGER,
    TOK_FLOAT,
};

const Keywords = enum {
    TOK_IF,
    TOK_THEN,
    TOK_ELSE,
    TOK_TRUE,
    TOK_FALSE,
    TOK_AND,
    TOK_OR,
    TOK_WHILE,
    TOK_DO,
    TOK_FOR,
    TOK_FUNC,
    TOK_NULL,
    TOK_END,
    TOK_PRINT,
    TOK_PRINTLN,
    TOK_RET,
};

const Token = struct {
    token_type: []const u8,
    lexeme: []const u8,

    pub fn init(token_type: []const u8, lexeme: []const u8) Token {
        return Token{
            .token_type = token_type,
            .lexeme = lexeme,
        };
    }

    pub fn repr(self: Token) self {
        return std.debug.print("{s}, {s}\n", .{ .token_type, .lexeme });
    }
};
