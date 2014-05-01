package inc::LeptonicaMakeMaker;
use Moose;

extends qw( Inline::MakeMaker Dist::Zilla::Plugin::MakeMaker::Awesome);

override _build_WriteMakefile_args => sub { +{
    %{ super() },
} };

override _build_WriteMakefile_dump => sub {
	my $str = super();
	$str .= <<'END';
$WriteMakefileArgs{CONFIGURE} = sub {
	require Alien::Leptonica;
	my $l = Alien::Leptonica->new;
	+{ CCFLAGS => $l->cflags, LIBS => $l->libs };
};
END
	$str;
};

__PACKAGE__->meta->make_immutable;
