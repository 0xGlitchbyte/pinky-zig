// Lexer:
//    init: takes in a file, initializes empty list for tokens
//    tokenize: add tokens to list as theyre scanned
const std = @import("std");
const tokens = @import("./tokens.zig");
const arena_list = std.heap.ArenaAllocator.init(std.heap.page_allocator);

const mem = std.mem;
const sch = tokens.SingleCharTokens;
const tct = tokens.TwoCharToken;
const lit = tokens.Literals;
const kwd = tokens.Keywords;

pub const Lexer = struct {
    source_file: []u8,
    token_list: std.ArrayList(u32),
    start: u32 = 0,
    curr: u32 = 0,
    line: u32 = 1,

    pub fn init(allocator: std.mem.Allocator, source_file: []u8) Lexer {
        return .{ .source_file = source_file, .token_list = std.ArrayList(u32).init(allocator), .start = 0, .curr = 0, .line = 1 };
    }

    pub fn deinit(self: *Lexer) void {
        self.token_list.deinit();
    }

    pub fn format(self: Lexer, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("Lexer: {{.token_list = {[]s} }}", self);
    }

    pub fn advance(self: Lexer) u8 {
        const char = self.source_file[self.curr];
        self.curr = self.curr + 1;
        return char;
    }

    pub fn add_token(self: Lexer, token_type: tokens) void {
        self.token_list.append(tokens.Token(token_type, self.source_file[self.start..self.curr]));
    }

    pub fn tokenize(self: Lexer) std.ArrayList(u32) {
        while (.curr < mem.len(.source)) {
            self.start == self.curr;
            const char = self.advance();
            //switch (std.mem.eql(u8, char)) {}
            if (mem.eql(u8, char, "+")) {
                self.add_token(sch.TOK_PLUS);
            } else if (mem.eql(u8, char, "-")) {
                self.add_token(sch.TOK_MINUS);
            } else if (mem.eql(u8, char, "*")) {
                self.add_token(sch.TOK_STAR);
            } else if (mem.eql(u8, char, "(")) {
                self.add_token(sch.TOK_LPAREN);
            } else if (mem.eql(u8, char, ")")) {
                self.add_token(sch.TOK_RPAREN);
            } else if (mem.eql(u8, char, "{")) {
                self.add_token(sch.TOK_LCURLY);
            } else if (mem.eql(u8, char, "}")) {
                self.add_token(sch.TOK_RCURLY);
            } else if (mem.eql(u8, char, "[")) {
                self.add_token(sch.TOK_LSQUAR);
            } else if (mem.eql(u8, char, "]")) {
                self.add_token(sch.TOK_RSQUAR);
            } else if (mem.eql(u8, char, ",")) {
                self.add_token(sch.TOK_COMMA);
            } else if (mem.eql(u8, char, ".")) {
                self.add_token(sch.TOK_DOT);
            } else if (mem.eql(u8, char, "/")) {
                self.add_token(sch.TOK_SLASH);
            } else if (mem.eql(u8, char, "^")) {
                self.add_token(sch.TOK_CARET);
            } else if (mem.eql(u8, char, "%")) {
                self.add_token(sch.TOK_MOD);
            } else if (mem.eql(u8, char, ":")) {
                self.add_token(sch.TOK_COLON);
            } else if (mem.eql(u8, char, ";")) {
                self.add_token(sch.TOK_SEMICOLON);
            } else if (mem.eql(u8, char, "?")) {
                self.add_token(sch.TOK_QUESTION);
            } else if (mem.eql(u8, char, "!")) {
                self.add_token(sch.TOK_NOT);
            } else if (mem.eql(u8, char, ">")) {
                self.add_token(sch.TOK_GT);
            } else if (mem.eql(u8, char, "<")) {
                self.add_token(sch.TOK_LT);
            } else if (mem.eql(u8, char, ">=")) {
                self.add_token(tct.TOK_GE);
            } else if (mem.eql(u8, char, "<=")) {
                self.add_token(tct.TOK_LE);
            } else if (mem.eql(u8, char, "!=")) {
                self.add_token(tct.TOK_NE);
            } else if (mem.eql(u8, char, "==")) {
                self.add_token(tct.TOK_EQ);
            } else if (mem.eql(u8, char, ":=")) {
                self.add_token(tct.TOK_ASSIGN);
            } else if (mem.eql(u8, char, ">>")) {
                self.add_token(tct.TOK_GTGT);
            } else if (mem.eql(u8, char, "<<")) {
                self.add_token(tct.TOK_LTLT);
            }
        }
        return self.token_list;
    }
};
