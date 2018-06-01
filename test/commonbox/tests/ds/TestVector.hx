package commonbox.tests.ds;

import utest.Assert;
import commonbox.ds.ArrayList;
import commonbox.ds.Vector;
import commonbox.testutils.SequenceTester;


class TestVector {
    public function new() {
    }

    public function testVector() {
        // Can't use due to Null parameter
        // var tester = new SequenceTester(Vector.new);
        var tester = new SequenceTester(
            function (size) { return new Vector<Any>(size); });
        tester.test();
    }

    public function testFromCollection() {
        var vector = Vector.fromCollection(ArrayList.of([100, 200, 300]));

        Assert.equals(100, vector[0]);
        Assert.equals(200, vector[1]);
        Assert.equals(300, vector[2]);
    }
}
