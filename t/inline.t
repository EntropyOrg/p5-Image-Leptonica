use Test::More;

use Alien::Leptonica;
my $l = Alien::Leptonica->new;

use Inline C => Config =>
                LIBS => $l->libs,
                INC => $l->cflags,
                PREFIX => 'XXX_',
                WARNINGS => 0,
