package inc::LeptonicaMakeMaker;
use Moose;

extends qw( Dist::Zilla::Plugin::MakeMaker::Awesome );


override _build_WriteMakefile_args => sub { +{
    %{ super() },
} };

override _build_WriteMakefile_dump => sub {
	my $str = super();
	$str .= <<'END';
use Inline::MakeMaker;
use ExtUtils::Depends;
$WriteMakefileArgs{CONFIGURE} = sub {
	require Alien::Leptonica;
	my $l = Alien::Leptonica->new;
	my $pkg = ExtUtils::Depends->new('Image::Leptonica',);
	$pkg->set_inc( $l->cflags );
	$pkg->set_libs( $l->libs );
	$pkg->add_typemaps( 'typemap' );
	dir( qw( lib Image Leptonica ) )->mkpath;
	$pkg->save_config('Image/Leptonica/IFiles.pm');
	+{ $pkg->get_makefile_vars()  };
};
END
	$str;
};

__PACKAGE__->meta->make_immutable;
