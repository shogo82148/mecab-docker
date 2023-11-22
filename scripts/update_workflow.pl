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

my $distributions = decode_json(slurp("$FindBin::Bin/distributions.json"));
my $dictinaries = decode_json(slurp("$FindBin::Bin/dictinaries.json"));

my $template = slurp("$FindBin::Bin/template.yml");

for my $dic(@$dictinaries) {
    for my $dist(@$distributions) {
        my $workflow = $template;
        $workflow =~ s/__DICTIONARY__/$dic/g;
        $workflow =~ s/__DISTRIBUTION__/$dist/g;

        open my $fh, ">:utf8", "$FindBin::Bin/../.github/workflows/$dic-$dist.yml" or die "Can't open $dic-$dist.yml: $!";
        print $fh $workflow;
        close $fh;
    }
}
