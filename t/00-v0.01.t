use Test::More tests => 8;

BEGIN { use_ok('Tie::Hash::Vivify') }

my $defaulter = 0;
my $vivi = Tie::Hash::Vivify->new(sub { "default" . $defaulter++ });

is(ref $vivi, 'HASH', "It looks like a regular hashref...");
is($vivi->{foo}, 'default0', 'but it defaults!');
$vivi->{bar} = "my data";
is($vivi->{bar}, 'my data', 'I can put my stuff in it...');
is($vivi->{baz}, 'default1', "and the defaulter doesn't get called!");
is($vivi->{foo}, 'default0', 'Defaults stick around.');
ok(exists $vivi->{foo}, 'Things that exist exist...');
ok(!exists $vivi->{nopers}, "and things that don't don't.");

# vim: ft=perl :
