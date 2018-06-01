package commonbox.tests.ds;

import commonbox.ds.ArrayList;
import commonbox.ds.Set;
import commonbox.testutils.SetTester;
import utest.Assert;


class TestSet {
    public function new() {
    }

    public function testSet() {
        var tester = new SetTester(Set.new);
        tester.test();
    }

    public function testFromCollection() {
        var set = Set.fromCollection(ArrayList.of([100, 200, 300]));

        Assert.isTrue(set.contains(100));
        Assert.isTrue(set.contains(200));
        Assert.isTrue(set.contains(300));
    }
}
