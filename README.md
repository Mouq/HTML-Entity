# HTML::Entity

Generated from the official list of valid HTML entities and can decode
entity-laden text via `&decode-entities` (or `&decode` if `use … :ALL` is given)

Can also encode basic entities via `&encode-entities`/`&encode`.

## Synopsis

    use HTML::Entity;
    
    say decode-entities "4.99 &approx; 5"; # 4.99 ≈ 5
    say HTML::Entity<&nesim>.chrs;         # ≂̸

    use HTML::Entity :ALL;
    
    say decode "fj&aumlril"; # fjäril
    say encode "A & B < C";  # A &amp; B &lt; C
