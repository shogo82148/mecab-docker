#!/usr/bin/env perl

use 5.38.0;
use warnings;
use utf8;
use FindBin;
use Carp qw/croak/;

sub docker {
    my @args = @_;
    say STDERR "docker @args";
    if (system('docker', @args) == 0) {
        return;
    }
    say STDERR "failed to build, try...";
    sleep(5);
    if (system('docker', @args) == 0) {
        return;
    }
    say STDERR "failed to build, try...";
    sleep(10);
    if (system('docker', @args) == 0) {
        return;
    }
    croak 'gave up, failed to run docker';
}

my $dic = $ARGV[0];
my $dist = $ARGV[1];

chdir "$FindBin::Bin/..";

docker(
    "build",
    "--platform", "arm64",
    "-t", "mecab-$dic-$dist-arm64",
    "$dic/$dist",
);

docker(
    "build",
    "--platform", "amd64",
    "-t", "mecab-$dic-$dist-amd64",
    "$dic/$dist",
);
