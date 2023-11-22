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
my $registry = $ARGV[2];

my $ref = $ENV{GITHUB_REF} || '';
if ($ref !~ m(^refs/tags/[^/]+/(.*))) {
    say STDERR "skip, '$ref' is not a tag";
    exit 0;
}
my $tag = $1;

chdir "$FindBin::Bin/..";
my @archs = qw/arm64 amd64/;

for my $arch(@archs) {
    docker(
        "tag",
        "mecab:$dic-$dist-$arch",
        "$registry/mecab:$dic-$dist-$arch",
    );
    docker(
        "push",
        "$registry/mecab:$dic-$dist-$arch",
    );

    docker(
        "tag",
        "mecab:$dic-$dist-$arch",
        "$registry/mecab:$dic-$dist-$arch-$tag",
    );
    docker(
        "push",
        "$registry/mecab:$dic-$dist-$arch-$tag",
    );
}

# create and push manifest
docker(
    "manifest", "create",
    "$registry/mecab:$dic-$dist",
    map { "$registry/mecab:$dic-$dist-$_" } @archs,
);
docker(
    "manifest", "push",
    "$registry/mecab:$dic-$dist",
);

docker(
    "manifest", "create",
    "$registry/mecab:$dic-$dist-$tag",
    map { "$registry/mecab:$dic-$dist-$_-$tag" } @archs,
);
docker(
    "manifest", "push",
    "$registry/mecab:$dic-$dist-$tag",
);
