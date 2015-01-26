class HTML::Entity;

sub lazy-load-entities {
    require HTML::Entities;
    %HTML::Entities::entities
}

#| Facilitate, e.g., HTML::Entity<&zdot;>
method at_key ($k) { lazy-load-entities{$k.substr(0,3)}{$k} }

#| Convert HTML entities in a string to the characters they represent
our sub decode ($str is copy) is export(:ALL) {
    my $to = 0;
    while $str ~~ m:c($to){\&<alpha><alpha>} {
        $to = $/.to - 3;
        my $v;
        for lazy-load-entities{~$/}.sort(-*.key.chars) -> (:$key, :$value) {
            last if $str ~~ s:p($to)[$key] = $v = $value.map(&chr).join
        }
        $to += $v ?? $v.chars !! 1;
    }
    $str ~~ s:g['&#'(<[0..9]>+)';'] = $0.chr;
    $str
}
our &decode-entities is export = &decode;

our sub encode ($str) is export(:ALL) {
    $str.trans: /\&/ => '&amp;', /\xA0/ => '&nbsp;', /\</ => '&lt;', /\>/ => '&gt;';
}
our &encode-entities is export = &encode;
