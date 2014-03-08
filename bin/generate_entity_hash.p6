#!/usr/bin/env perl6
use JSON::Tiny;
my @ent = qx{curl -s https://raw.github.com/w3c/html/master/entities.json}\
    .&from-json.list.map: {; .key => .value<codepoints> }
for @ent.categorize(*.value).values {
    say .map({
        qq«'{.key}'=>[{.value.join}],»
    }).join.indent(4)
}
