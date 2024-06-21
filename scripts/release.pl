#!/usr/bin/env perl

use v5.40;
use warnings;
use utf8;
use FindBin;
use Carp qw/croak/;
use JSON;
use Time::Piece;

sub slurp($file) {
    local $/;
    open my $fh, "<", $file or die "Can't open $file: $!";
    my $content = <$fh>;
    close $fh;
    return $content;
}

sub new_tag($dic, $dist) {
    my $utc_time = Time::Piece->new()->gmtime();
    my $tag = sprintf("%s-%s/%s", $dic, $dist, $utc_time->ymd);
    say "New tag: $tag";
    system("git", "tag", $tag);
    system("git", "push", "origin", $tag);
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
        my $exit_code = system("git", "diff", "--exit-code", "--quiet", $tag, "HEAD", "--", "$dic/$dist");
        if ($exit_code != 0) {
            new_tag($dic, $dist);
            next;
        }
    }
}
