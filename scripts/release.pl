#!/usr/bin/env perl

use 5.38.0;
use warnings;
use utf8;
use FindBin;
use Carp qw/croak/;
use JSON;

sub slurp($file) {
    local $/;
    open my $fh, "<", $file or die "Can't open $file: $!";
    my $content = <$fh>;
    close $fh;
    return $content;
}

sub new_tag($dic, $dist) {
    say STDERR "new tag: $dic-$dist";
}

my $distributions = decode_json(slurp("$FindBin::Bin/distributions.json"));
my $dictinaries = decode_json(slurp("$FindBin::Bin/dictinaries.json"));

for my $dic(@$dictinaries) {
    for my $dist(@$distributions) {
        my $tag = `git tag --sort -v:refname --list '$dic-$dist/*' | head -n 1`;
        chomp $tag;
        unless ($tag) {
            new_tag($dic, $dist);
            next;
        }
    }
}
