#!/usr/bin/env perl

use 5.38.0;
use warnings;
use utf8;
use FindBin;
use Carp qw/croak/;
use JSON;
use Actions::Core;

sub slurp($file) {
    local $/;
    open my $fh, "<", $file or die "Can't open $file: $!";
    my $content = <$fh>;
    close $fh;
    return $content;
}

sub spew($file, $content) {
    open my $fh, ">", "$file.tmp$$" or die "failed to open $file: $!";
    print $fh $content;
    close $fh or die "failed to close $file: $!";
    rename "$file.tmp$$", $file or die "failed to rename $file.tmp$$ to $file: $!";
}

my $release = decode_json(`gh release view --repo shogo82148/mecab --json assets`);
my $assets = $release->{assets};
my ($mecab_version, $ipadic_version, $jumandic_version);
for my $asset(@$assets) {
    my $name = $asset->{name};
    if ($name =~ /^mecab-([0-9.]+).tar.gz$/) {
        $mecab_version = $1;
    } elsif ($name =~ /^mecab-ipadic-([-0-9.]+).tar.gz$/) {
        $ipadic_version = $1;
    } elsif ($name =~ /^mecab-jumandic-([-0-9.]+).tar.gz$/) {
        $jumandic_version = $1;
    }
}
say STDERR "mecab: $mecab_version";
say STDERR "ipadic: $ipadic_version";
say STDERR "jumandic: $jumandic_version";
set_output('latest-version', $mecab_version);

my $distributions = decode_json(slurp("$FindBin::Bin/distributions.json"));
my $dictinaries = decode_json(slurp("$FindBin::Bin/dictinaries.json"));

for my $dic(@$dictinaries) {
    for my $dist(@$distributions) {
        say STDERR "update $dic/$dist";
        my $file = "$FindBin::Bin/../$dic/$dist/Dockerfile";
        my $dockerfile = slurp($file);
        say $dockerfile;
        $dockerfile =~ s/^ENV MECAB_VERSION\s+.+$/ENV MECAB_VERSION $mecab_version/m;
        $dockerfile =~ s/^ENV IPADIC_VERSION\s+.+$/ENV IPADIC_VERSION $ipadic_version/m;
        $dockerfile =~ s/^ENV JUMANDIC_VERSION\s+.+$/ENV JUMANDIC_VERSION $jumandic_version/m;
        spew($file, $dockerfile);
    }
}
