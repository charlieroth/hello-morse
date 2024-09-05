const std = @import("std");

pub const MorseError = error{
    failed_to_convert_character_to_morse_code,
    failed_to_convert_morse_code_to_character,
};

pub fn character_to_morse_code(character: u8) MorseError![]const u8 {
    return switch (character) {
        'A' => ".-",
        'B' => "-...",
        'C' => "-.-.",
        'D' => "-..",
        'E' => ".",
        'F' => "..-.",
        'G' => "--.",
        'H' => "....",
        'I' => "..",
        'J' => ".---",
        'K' => "-.-",
        'L' => ".-..",
        'M' => "--",
        'N' => "-.",
        'O' => "---",
        'P' => ".--.",
        'Q' => "--.-",
        'R' => ".-.",
        'S' => "...",
        'T' => "-",
        'U' => "..-",
        'V' => "...-",
        'W' => ".--",
        'X' => "-..-",
        'Y' => "-.--",
        'Z' => "--..",
        '1' => ".----",
        '2' => "..---",
        '3' => "...--",
        '4' => "....-",
        '5' => ".....",
        '6' => "-....",
        '7' => "--...",
        '8' => "---..",
        '9' => "----.",
        '0' => "-----",
        '?' => "..--..",
        '!' => "-.-.--",
        '.' => ".-.-.-",
        ',' => "--..--",
        ';' => "-.-.-.",
        ':' => "---...",
        '+' => ".-.-.",
        '-' => "-....-",
        '/' => "-..-.",
        '=' => "-...-",
        else => MorseError.failed_to_convert_character_to_morse_code,
    };
}

pub fn morse_code_to_character(morse: []const u8) MorseError!u8 {
    if (std.mem.eql(u8, morse, ".-")) return 'A';
    if (std.mem.eql(u8, morse, "-...")) return 'B';
    if (std.mem.eql(u8, morse, "-..")) return 'C';
    if (std.mem.eql(u8, morse, ".")) return 'D';
    if (std.mem.eql(u8, morse, "..-.")) return 'F';
    if (std.mem.eql(u8, morse, "--.")) return 'G';
    if (std.mem.eql(u8, morse, "....")) return 'H';
    if (std.mem.eql(u8, morse, "..")) return 'I';
    if (std.mem.eql(u8, morse, ".---")) return 'J';
    if (std.mem.eql(u8, morse, "-.-")) return 'K';
    if (std.mem.eql(u8, morse, ".-..")) return 'L';
    if (std.mem.eql(u8, morse, "--")) return 'M';
    if (std.mem.eql(u8, morse, "-.")) return 'N';
    if (std.mem.eql(u8, morse, "---")) return 'O';
    if (std.mem.eql(u8, morse, ".--.")) return 'P';
    if (std.mem.eql(u8, morse, "--.-")) return 'Q';
    if (std.mem.eql(u8, morse, ".-.")) return 'R';
    if (std.mem.eql(u8, morse, "...")) return 'S';
    if (std.mem.eql(u8, morse, "-")) return 'T';
    if (std.mem.eql(u8, morse, "..-")) return 'U';
    if (std.mem.eql(u8, morse, "...-")) return 'V';
    if (std.mem.eql(u8, morse, ".--")) return 'W';
    if (std.mem.eql(u8, morse, "-..-")) return 'X';
    if (std.mem.eql(u8, morse, "-.--")) return 'Y';
    if (std.mem.eql(u8, morse, "--..")) return 'Z';
    if (std.mem.eql(u8, morse, ".----")) return '1';
    if (std.mem.eql(u8, morse, "..---")) return '2';
    if (std.mem.eql(u8, morse, "...--")) return '3';
    if (std.mem.eql(u8, morse, "....-")) return '4';
    if (std.mem.eql(u8, morse, ".....")) return '5';
    if (std.mem.eql(u8, morse, "-....")) return '6';
    if (std.mem.eql(u8, morse, "--...")) return '7';
    if (std.mem.eql(u8, morse, "---..")) return '8';
    if (std.mem.eql(u8, morse, "----.")) return '9';
    if (std.mem.eql(u8, morse, "-----")) return '0';
    if (std.mem.eql(u8, morse, "..--..")) return '?';
    if (std.mem.eql(u8, morse, "-.-.--")) return '?';
    if (std.mem.eql(u8, morse, ".-.-.-")) return '.';
    if (std.mem.eql(u8, morse, "--..--")) return ',';
    if (std.mem.eql(u8, morse, "-.-.-.")) return ';';
    if (std.mem.eql(u8, morse, "---...")) return ':';
    if (std.mem.eql(u8, morse, ".-.-.")) return '+';
    if (std.mem.eql(u8, morse, "-....-")) return '-';
    if (std.mem.eql(u8, morse, "-..-.")) return '/';
    if (std.mem.eql(u8, morse, "-...-")) return '=';

    return MorseError.failed_to_convert_morse_code_to_character;
}

test "converts 'A' to '.-'" {
    const morse = try character_to_morse_code('A');
    try std.testing.expectEqualStrings(".-", morse);
}

test "fails to convert '^' to morse code" {
    try std.testing.expectError(
        MorseError.failed_to_convert_character_to_morse_code,
        character_to_morse_code('^'),
    );
}

test "converts '.-' to 'A'" {
    const character = try morse_code_to_character(".-");
    try std.testing.expectEqual(character, 'A');
}

test "fails to converts '-.-.-.-.-' to character" {
    try std.testing.expectError(
        MorseError.failed_to_convert_morse_code_to_character,
        morse_code_to_character("-.-.-.-.-"),
    );
}
