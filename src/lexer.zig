// Lexer:
//    init: takes in a file, initializes empty list for tokens
//    tokenize: add tokens to list as theyre scanned
const std = @import("std");
const tokens = @import("./tokens.zig");
const arena_list = std.heap.ArenaAllocator.init(std.heap.page_allocator);

const Lexer = struct {
    source_file: std.fs.File,
    token_list: std.ArrayList,
    start: u32,
    curr: u32,
    line: u32,

    pub fn init(source_file: std.fs.File) Lexer {
        return Lexer{ .source_file = source_file };
    }

    pub fn advance(self: Lexer) void {
        const char = self.source_file[self.curr];
        self.curr = self.curr + 1;
        return char;
    }

    pub fn add_token(self: Lexer, token_type: tokens) void {
        self.token_list.append(tokens.Token(token_type, self.source_file[self.start..self.curr]));
    }

    pub fn tokenize(self: Lexer) void {
        var vec = std.ArrayList(u32).init(arena_list);
        defer vec.deinit();
        while (.curr < std.mem.len(.source)) {
            self.start == self.curr;
            const char = self.advance();
            //switch () {} '+' self.tokens.append(Token(type,lexeme))
            //TODO! cant switch on strings, figure that one out
            if (std.mem.eql(u8, char, "+")) self.add_token(tokens.SingleCharTokens.TOK_PLUS);
            if (std.mem.eql(u8, char, "-")) self.add_token(tokens.SingleCharTokens.TOK_MINUS);
        }
    }
};
