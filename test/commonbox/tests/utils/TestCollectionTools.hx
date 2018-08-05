package commonbox.tests.utils;

import commonbox.ds.ArrayList;
import commonbox.utils.CollectionTools;
import utest.Assert;


class TestCollectionTools {
    public function new() {
    }

    public function testJoin() {
        Assert.equals("", CollectionTools.join(ArrayList.of([]), ","));
        Assert.equals("A", CollectionTools.join(ArrayList.of(["A"]), ","));
        Assert.equals("A,B", CollectionTools.join(ArrayList.of(["A", "B"]), ","));
        Assert.equals("A,B,C", CollectionTools.join(ArrayList.of(["A", "B", "C"]), ","));
    }
}
