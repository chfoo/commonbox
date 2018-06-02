package commonbox.tests.ds;

import commonbox.ds.ArrayList;
import commonbox.ds.Deque;
import commonbox.testutils.VariableSequenceTester;
import utest.Assert;


class TestDeque {
    public function new() {
    }

    public function testList() {
        var tester = new VariableSequenceTester(
            function () { return new Deque(); });
        tester.test();
    }

    public function testFromCollection() {
        var seq = Deque.fromCollection(ArrayList.of([100, 200, 300]));

        Assert.equals(100, seq.get(0));
        Assert.equals(200, seq.get(1));
        Assert.equals(300, seq.get(2));
    }

    public function testMaxSize() {
        var deque = new Deque<Int>(10);

        for (dummy in 0...10) {
            deque.push(100);
        }

        Assert.raises(deque.push.bind(100), Exception.FullException);
        Assert.raises(deque.unshift.bind(100), Exception.FullException);
    }
}
