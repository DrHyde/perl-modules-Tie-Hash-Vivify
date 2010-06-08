use strict;
use warnings;

use Test::More tests => 13;

use Tie::Hash::Vivify;


my $defaulter = 0;
my $vivi = Tie::Hash::Vivify->new(
  sub { "default" . $defaulter++ },
);

$vivi->{bar} = {};
is_deeply($vivi->{bar}, {}, 'can put a hashref in');
is($vivi->{bar}->{wibble}, undef, "children aren't infected by default");
is($vivi->{foo}, 'default0', 'normal vivification works');

$vivi = Tie::Hash::Vivify->new(
  sub { "default" . $defaulter++ },
  infect_children => 1
);

is($vivi->{foo}, 'default1', 'normal vivification works with infect_children');
$vivi->{bar} = {};
is_deeply($vivi, { foo => 'default1', bar => {} }, 'can put an empty hashref in');
is($vivi->{bar}->{wibble}, 'default2', "children are now infected");

$vivi->{baz} = { quux => 'hlagh', garbleflux => { abc => [qw(a b c)] }};
is_deeply(
  $vivi,
  {
    foo => 'default1',
    bar => { wibble => 'default2' },
    baz => { quux => 'hlagh', garbleflux => { abc => [qw(a b c)] }}
  },
  'can put a complex hashref in'
);

is($vivi->{baz}->{garbleflux}->{hlagh}, 'default3', 'which auto-vivifies');
is_deeply(
  $vivi,
  {
    foo => 'default1',
    bar => { wibble => 'default2' },
    baz => {
      quux       => 'hlagh',
      garbleflux => {
        abc   => [qw(a b c)],
        hlagh => 'default3',
      }
    }
  },
  'and stores correctly (paranoia!)'
);

$defaulter = 0;
$vivi = Tie::Hash::Vivify->new(
  sub { "default" . $defaulter++ },
  infect_children => 1
);
my $differentdefaulter = 0;
my $vivi2 = Tie::Hash::Vivify->new(
  sub { "differentdefault" . $differentdefaulter++ },
  infect_children => 1
);

$vivi->{poing} = $vivi2;
is($vivi->{poing}->{foo}, 'differentdefault0', "putting a T::H::V hash in a T::H::V hash works");
is($vivi->{foo}, 'default0', "and the parent still auto-vivifies properly");

$vivi->{poing}->{bar} = {};
$vivi->{bar} = {};
is($vivi->{poing}->{bar}->{foo}, 'differentdefault1', "child hash infects its children correctly");
is($vivi->{bar}->{foo}, 'default1', "parent hash infects its children correctly");
