// Token
//    init: takes in token_type, lexeme
//    repr: print token

const Token = struct {
    token_type: u32,
    lexeme: u32,

    pub fn init(token_type: u32, lexeme: u32) Token {
        return Token{
            .token_type = token_type,
            .lexeme = lexeme,
        };
    }

    // pub repr()
};
