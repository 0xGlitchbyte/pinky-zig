// Lexer:
//    init: takes in a file, initializes empty list for tokens
//    tokenize: add tokens to list as theyre scanned
const std = @import("std");

const Lexer = struct {
    tokens: []u32,

    pub fn init(source: std.io.File) Lexer {
        return Lexer{ .tokens = source };
    }

    //pub fn tokenize()
};
