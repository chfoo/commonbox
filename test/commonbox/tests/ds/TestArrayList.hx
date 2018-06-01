package commonbox.tests.ds;

import commonbox.ds.ArrayList;
import commonbox.testutils.VariableSequenceTester;
import utest.Assert;


class TestArrayList {
    public function new() {
    }

    public function testArray() {
        // File "src/typing/type.ml", line 555, characters 9-15: Assertion failed
        // var tester = new VariableSequenceTester(ArrayList.new);
        var tester = new VariableSequenceTester(
            function () { return new ArrayList<Any>(); });
        tester.test();
    }

    public function testOfStdArray() {
        var arrayList = ArrayList.of([100, 200, 300]);

        Assert.equals(100, arrayList[0]);
        Assert.equals(200, arrayList[1]);
        Assert.equals(300, arrayList[2]);
    }

    public function testFromCollection() {
        var arrayList = ArrayList.fromCollection(ArrayList.of([100, 200, 300]));

        Assert.equals(100, arrayList[0]);
        Assert.equals(200, arrayList[1]);
        Assert.equals(300, arrayList[2]);
    }
}
