package commonbox.testutils;

import commonbox.adt.VariableSequence;
import utest.Assert;


class VariableSequenceTester {
    var sequenceFactory:Void->VariableSequence<Any>;

    public function new(sequenceFactory:Void->VariableSequence<Any>) {
        this.sequenceFactory = sequenceFactory;
    }

    function fixedSequenceFactory(count:Int) {
        var seq = sequenceFactory();

        for (dummy in 0...count) {
            seq.push(0);
        }

        return seq;
    }

    public function test() {
        var tester = new SequenceTester(fixedSequenceFactory);
        tester.test();

        testEqualsCopy();
        testClear();
        testInsert();
        testShiftUnshift();
        testPushPop();
        testExtend();
        testSplice();
        testSpliceBounds();
    }

    function testEqualsCopy() {
        var sequence = sequenceFactory();
        sequence.push("a");
        sequence.push("b");
        sequence.push("c");

        var sequenceCopy = sequence.copy();
        sequenceCopy.reverse();

        Assert.isFalse(sequence.contentEquals(sequenceCopy));
    }

    function testClear() {
        var sequence = sequenceFactory();
        sequence.push("a");
        sequence.push("b");
        sequence.push("c");

        sequence.clear();

        Assert.equals(0, sequence.length);
        Assert.raises(sequence.first, Exception.OutOfBoundsException);
        Assert.raises(sequence.last, Exception.OutOfBoundsException);
    }

    function testInsert() {
        var sequence = sequenceFactory();

        sequence.insert(-100, "c");
        sequence.insert(-100, "a");
        sequence.insert(1, "b");
        sequence.insert(100, "d");

        Assert.equals("a", sequence.get(0));
        Assert.equals("b", sequence.get(1));
        Assert.equals("c", sequence.get(2));
        Assert.equals("d", sequence.get(3));
    }

    function testShiftUnshift() {
        var sequence = sequenceFactory();

        sequence.shift("a");

        Assert.equals(1, sequence.length);
        Assert.equals("a", sequence.get(0));

        sequence.shift("b");
        Assert.equals(2, sequence.length);
        Assert.equals("b", sequence.get(0));
        Assert.equals("a", sequence.get(1));

        switch (sequence.unshift()) {
            case Some(item):
                Assert.equals("b", item);
            case None:
                Assert.fail();
        }

        Assert.equals(1, sequence.length);
        Assert.equals("a", sequence.get(0));

        switch (sequence.unshift()) {
            case Some(item):
                Assert.equals("a", item);
            case None:
                Assert.fail();
        }

        Assert.equals(0, sequence.length);

        switch (sequence.unshift()) {
            case Some(item):
                Assert.fail();
            case None:
                Assert.pass();
        }
    }

    function testPushPop() {
        var sequence = sequenceFactory();

        sequence.push("a");

        Assert.equals(1, sequence.length);
        Assert.equals("a", sequence.get(0));

        sequence.push("b");
        Assert.equals(2, sequence.length);
        Assert.equals("a", sequence.get(0));
        Assert.equals("b", sequence.get(1));

        switch (sequence.pop()) {
            case Some(item):
                Assert.equals("b", item);
            case None:
                Assert.fail();
        }

        Assert.equals(1, sequence.length);
        Assert.equals("a", sequence.get(0));

        switch (sequence.pop()) {
            case Some(item):
                Assert.equals("a", item);
            case None:
                Assert.fail();
        }

        Assert.equals(0, sequence.length);

        switch (sequence.pop()) {
            case Some(item):
                Assert.fail();
            case None:
                Assert.pass();
        }
    }

    function testExtend() {
        var sequence = sequenceFactory();

        sequence.push("a");
        sequence.push("b");

        sequence.extend(sequence.copy());

        Assert.equals(4, sequence.length);

        Assert.equals("a", sequence.get(2));
        Assert.equals("b", sequence.get(3));
    }

    function testSplice() {
        var sequence = sequenceFactory();

        sequence.push("a");
        sequence.push("b");
        sequence.push("c");

        var newSequence = sequence.splice(0, 2);

        Assert.equals(1, sequence.length);
        Assert.equals("c", sequence.get(0));

        Assert.equals(2, newSequence.length);
        Assert.equals("a", newSequence.get(0));
        Assert.equals("b", newSequence.get(1));

        sequence.unsplice(0, newSequence);

        Assert.equals(3, sequence.length);
        Assert.equals("a", sequence.get(0));
        Assert.equals("b", sequence.get(1));
        Assert.equals("c", sequence.get(2));
    }

    function testSpliceBounds() {
        var sequence = sequenceFactory();

        sequence.push("a");
        sequence.push("b");
        sequence.push("c");

        var newSequence = sequence.splice(0, 100);
        Assert.equals(0, sequence.length);
        Assert.equals(3, newSequence.length);

        sequence.unsplice(0, newSequence);

        var newSequence = sequence.splice(100, 100);
        Assert.equals(3, sequence.length);
        Assert.equals(0, newSequence.length);

        var newSequence = sequence.splice(100, -100);
        Assert.equals(3, sequence.length);
        Assert.equals(0, newSequence.length);

        var newSequence = sequence.splice(1, 1);
        Assert.equals(2, sequence.length);
        Assert.equals(1, newSequence.length);
    }
}
