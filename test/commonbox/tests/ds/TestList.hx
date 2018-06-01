package commonbox.tests.ds;

import commonbox.ds.ArrayList;
import commonbox.ds.List;
import commonbox.testutils.VariableSequenceTester;
import utest.Assert;


class TestList {
    public function new() {
    }

    public function testList() {
        var tester = new VariableSequenceTester(List.new);
        tester.test();
    }

    public function testFromCollection() {
        var list = List.fromCollection(ArrayList.of([100, 200, 300]));

        Assert.equals(100, list.get(0));
        Assert.equals(200, list.get(1));
        Assert.equals(300, list.get(2));
    }
}
