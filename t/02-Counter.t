#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Counter;

my $s = Net::PulseMeter::Sensor::Counter->new("foo");
my $r = Redis->new;
    
subtest 'describe .event' => sub {
    $s->redis->flushdb;
    $s->event(10);
    $s->event(1);
    ok(
        $r->get($s->value_key) == 11,
        "it increments counter by given value"
    );
};

subtest 'describe .incr' => sub {
    $s->redis->flushdb;
    $s->incr;
    $s->incr;
    ok(
        $r->get($s->value_key) == 2,
        "it increments counter by one"
    );
};

done_testing();
