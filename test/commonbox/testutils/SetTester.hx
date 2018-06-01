package commonbox.testutils;

import commonbox.adt.Set;
import utest.Assert;


class SetTester {
    var setFactory:Void->MutableSet<Any>;

    public function new(setFactory:Void->MutableSet<Any>) {
        this.setFactory = setFactory;
    }

    public function test() {
        testContainer();
        testAddRemove();
        testEqualsCopy();
    }

    function testContainer() {
        var set = setFactory();

        Assert.equals(0, set.length);

        set.add("a");
        Assert.equals(1, set.length);
        Assert.isTrue(set.contains("a"));

        var iterator = set.iterator();
        Assert.isTrue(iterator.hasNext());
        Assert.equals("a", iterator.next());
        Assert.isFalse(iterator.hasNext());

        trace(set);
    }

    function testAddRemove() {
        var set = setFactory();

        Assert.isTrue(set.add("a"));
        Assert.isFalse(set.add("a"));
        Assert.isTrue(set.contains("a"));

        Assert.isTrue(set.remove("a"));
        Assert.isFalse(set.remove("a"));
        Assert.isFalse(set.contains("a"));
    }

    function testEqualsCopy() {
        var set = setFactory();
        set.add("a");
        set.add("b");

        var copy = set.copy();

        Assert.isTrue(set.contentEquals(copy));

        copy.remove("b");
        Assert.isFalse(set.contentEquals(copy));
    }
}
