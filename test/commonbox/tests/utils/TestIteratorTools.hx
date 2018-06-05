package commonbox.tests.utils;

import commonbox.ds.ArrayList;
import haxe.ds.Option;
import utest.Assert;

using commonbox.utils.IteratorTools;


class TestIteratorTools {
    public function new() {
    }

    public function testContains() {
        var seq = ArrayList.of([1, 2, 3]);

        Assert.isTrue(seq.iterator().contains(1));
        Assert.isFalse(seq.iterator().contains(4));
    }

    public function testCount() {
        var seq = ArrayList.of([1, 2, 3]);

        Assert.equals(3, seq.iterator().count());
    }

    public function testIndexOf() {
        var seq = ArrayList.of([1, 2, 3]);

        Assert.isTrue(seq.iterator().indexOf(2).equals(Option.Some(1)));
        Assert.equals(Option.None, seq.iterator().indexOf(4));
    }

    public function testContentEquals() {
        var seq1 = ArrayList.of([1, 2, 3]);
        var seq2 = ArrayList.of([1, 2, 3]);
        var seq3 = ArrayList.of([1, 2]);
        var seq4 = ArrayList.of([1, 2, 4]);

        Assert.isTrue(seq1.iterator().contentEquals(seq2.iterator()));
        Assert.isFalse(seq1.iterator().contentEquals(seq3.iterator()));
        Assert.isFalse(seq1.iterator().contentEquals(seq4.iterator()));
    }
}
