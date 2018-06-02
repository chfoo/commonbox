package commonbox.testutils;

import commonbox.adt.Sequence;
import haxe.ds.Option;
import utest.Assert;


class SequenceTester {
    var sequence:Sequence<Any>;
    var itemA:Int;
    var itemB:Coordinate;
    var itemC:String;
    var sequenceFactory:Int->Sequence<Any>;

    public function new(sequenceFactory:Int->Sequence<Any>) {
        this.sequence = sequenceFactory(3);
        this.sequenceFactory = sequenceFactory;
    }

    public function test() {
        Assert.equals(3, sequence.length);

        setItems();
        testGet();
        testFirstLast();
        testContainer();
        testIterator();
        testConcat();
        testSlice();
        testEqualsCopy();
        testReverse();
        testSortSmall();
        testSortBig();
    }

    function setItems() {
        itemA = 123;
        itemB = new Coordinate(100, 200);
        itemC = "abc";

        sequence.set(0, itemA);
        sequence.set(1, itemB);
        sequence.set(2, itemC);

        trace(sequence);
    }

    function testGet() {
        Assert.equals(itemA, sequence.get(0));
        Assert.equals(itemB, sequence.get(1));
        Assert.equals(itemC, sequence.get(2));

        Assert.equals(itemA, sequence.get(-3));
        Assert.equals(itemB, sequence.get(-2));
        Assert.equals(itemC, sequence.get(-1));

        Assert.raises(sequence.get.bind(3), Exception.OutOfBoundsException);
        Assert.raises(sequence.get.bind(-4), Exception.OutOfBoundsException);
    }

    function testFirstLast() {
        Assert.equals(itemA, sequence.first());
        Assert.equals(itemA, sequence.firstOption().getParameters()[0]);

        Assert.equals(itemC, sequence.last());
        Assert.equals(itemC, sequence.lastOption().getParameters()[0]);
    }

    function testContainer() {
        var coord = new Coordinate(100, 200);

        Assert.isTrue(sequence.contains(coord));
        Assert.equals(1, sequence.indexOf(coord).getParameters()[0]);
        Assert.isFalse(sequence.isEmpty());

        Assert.isFalse(sequence.contains("xyz"));
        Assert.equals(None, sequence.indexOf("xyz"));

    }

    function testIterator() {
        var iterator = sequence.iterator();

        Assert.isTrue(iterator.hasNext());
        Assert.equals(itemA, iterator.next());

        Assert.isTrue(iterator.hasNext());
        Assert.equals(itemB, iterator.next());

        Assert.isTrue(iterator.hasNext());
        Assert.equals(itemC, iterator.next());

        Assert.isFalse(iterator.hasNext());
    }

    function testConcat() {
        var newSequence = sequence.concat(sequence);

        Assert.equals(6, newSequence.length);
        Assert.equals(itemA, newSequence.get(0));
        Assert.equals(itemB, newSequence.get(1));
        Assert.equals(itemC, newSequence.get(2));
    }

    function testSlice() {
        var newSequence = sequence.slice(1, 2);

        Assert.equals(1, newSequence.length);
        Assert.equals(itemB, newSequence.get(0));
    }

    function testEqualsCopy() {
        Assert.isTrue(sequence.contentEquals(sequence.copy()));
    }

    function testReverse() {
        sequence.reverse();

        Assert.equals(itemA, sequence.get(2));
        Assert.equals(itemB, sequence.get(1));
        Assert.equals(itemC, sequence.get(0));

        sequence.reverse();

        Assert.equals(itemA, sequence.get(0));
        Assert.equals(itemB, sequence.get(1));
        Assert.equals(itemC, sequence.get(2));
    }

    function testSortSmall() {
        var sequence:Sequence<Coordinate> = cast sequenceFactory(8);
        var nums = [32, 99, 68, 40, 72, -21, 8, -21];

        for (index in 0...nums.length) {
            sequence.set(index, new Coordinate(nums[index], 0));
        }

        sequence.sort();

        var sortedNums = nums.copy();
        sortedNums.sort(Reflect.compare);

        for (index in 0...nums.length) {
            Assert.equals(sortedNums[index], sequence.get(index).x);
        }
    }

    function testSortBig() {
        var sequence = sequenceFactory(1000);
        var nums = [];

        for (index in 0...1000) {
            var num = Std.random(0xffff);
            nums.push(num);
            sequence.set(index, num);
        }

        var sortedNums = nums.copy();
        sortedNums.sort(Reflect.compare);

        sequence.sort();

        for (index in 0...nums.length) {
            Assert.equals(sortedNums[index], sequence.get(index));
        }
    }
}
