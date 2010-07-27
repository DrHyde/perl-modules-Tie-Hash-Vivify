# $Id: pod-coverage.t,v 1.3 2007/11/01 17:00:19 drhyde Exp $
use strict;
$^W=1;

eval "use Test::Pod::Coverage 1.00";
if($@) {
    print "1..0 # SKIP Test::Pod::Coverage 1.00 required for testing POD coverage";
} else {
    # Pod::Coverage doesn't know that SCALAR is special, at least in
    # version 0.20. Remove this when that's fixed and declare the new
    # P::C as a pre-req
    all_pod_coverage_ok({also_private => ['SCALAR']});
}
