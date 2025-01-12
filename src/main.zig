const std = @import("std");
const token = @import("./tokens.zig");
const lexer = @import("./lexer.zig");
const debug = std.debug;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        std.log.err("Usage: {s} <filename>", .{args[0]});
        std.process.exit(1);
    }

    const filename = args[1];

    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    const source = try file.readToEndAlloc(allocator, std.math.maxInt(u32));
    defer allocator.free(source);

    debug.print("File content: {s}\n", .{source});

    //const lex = lexer.Lexer.init(undefined, source, undefined, undefined, undefined);

    //debug.print("Lexer:\n", lex);

    //const tokens = lex.tokenize();
    //for (tokens) |item| {
    //    debug.print("{s}\n", .{item});
    //}
}

// literals
// identifiers
// keywords
// operators
// expressions
// statements
// blocks
//
// Tokenizer == Lexer == Scanner
//  - Finds list of tokens
//      - e.g. (TOK_IDENTIFIER, 'int')
//
// Abstract Syntax Tree (AST)
//
