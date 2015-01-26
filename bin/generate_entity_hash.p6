#!/usr/bin/env perl6
use JSON::Tiny;
my @ent = qx{curl -s https://raw.githubusercontent.com/w3c/html/master/entities.json}\
    .&from-json.list.map: {; .key => .value<codepoints> }
for @ent.classify(*.key.substr(0,3)) {
    say qq«  '{.key}' => \{»;
    for .value.classify(*.value).values {
        say '    ', .map({
            qq«'{.key}'=>[{.value.join: ','}],»
        }).join
    }
    say qq«  \},»;
}
