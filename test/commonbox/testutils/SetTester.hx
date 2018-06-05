package commonbox.testutils;

import commonbox.adt.Set;
import utest.Assert;


class SetTester {
    var setFactory:Void->Set<Any>;

    public function new(setFactory:Void->Set<Any>) {
        this.setFactory = setFactory;
    }

    public function test() {
        testContainer();
        testAddRemove();
        testEqualsCopy();
        testUnion();
        testIntersection();
        testDifference();
        testSymmetricDifference();
        testDisjoint();
        testSubset();
        testProperSubset();
        testSuperset();
        testProperSuperset();
    }

    function testContainer() {
        var set = setFactory();

        Assert.equals(0, set.length);
        Assert.isTrue(set.isEmpty());

        set.add("a");
        Assert.equals(1, set.length);
        Assert.isTrue(set.contains("a"));
        Assert.isFalse(set.isEmpty());

        var iterator = set.iterator();
        Assert.isTrue(iterator.hasNext());
        Assert.equals("a", iterator.next());
        Assert.isFalse(iterator.hasNext());

        trace(set);

        set.clear();
        Assert.isTrue(set.isEmpty());
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

    function testUnion() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("b");

        var setResult = setFactory();
        setResult.add("a");
        setResult.add("b");

        Assert.isTrue(setResult.contentEquals(setA.union(setB)));
    }

    function testIntersection() {
        var setA = setFactory();
        setA.add("a");
        setA.add("b");

        var setB = setFactory();
        setB.add("b");
        setB.add("c");

        var setResult = setFactory();
        setResult.add("b");

        Assert.isTrue(setResult.contentEquals(setA.intersection(setB)));
    }

    function testDifference() {
        var setA = setFactory();
        setA.add("a");
        setA.add("b");

        var setB = setFactory();
        setB.add("b");
        setB.add("c");

        var setResult = setFactory();
        setResult.add("c");

        Assert.isTrue(setResult.contentEquals(setA.difference(setB)));
    }

    function testSymmetricDifference() {
        var setA = setFactory();
        setA.add("a");
        setA.add("b");

        var setB = setFactory();
        setB.add("b");
        setB.add("c");

        var setResult = setFactory();
        setResult.add("a");
        setResult.add("c");

        Assert.isTrue(setResult.contentEquals(setA.symmetricDifference(setB)));
    }

    function testDisjoint() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("c");

        Assert.isTrue(setA.isDisjoint(setB));

        setB.add("a");
        Assert.isFalse(setA.isDisjoint(setB));
    }

    function testSubset() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("c");

        Assert.isFalse(setA.isSubset(setB));

        setB.add("a");
        Assert.isTrue(setA.isSubset(setB));
    }

    function testProperSubset() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("c");

        Assert.isFalse(setA.isProperSubset(setB));

        setB.add("a");
        Assert.isTrue(setA.isProperSubset(setB));

        setA.add("c");
        Assert.isFalse(setA.isProperSubset(setB));
    }

    function testSuperset() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("c");

        Assert.isFalse(setA.isSuperset(setB));

        setA.add("c");
        Assert.isTrue(setA.isSuperset(setB));
    }

    function testProperSuperset() {
        var setA = setFactory();
        setA.add("a");

        var setB = setFactory();
        setB.add("c");

        Assert.isFalse(setA.isProperSuperset(setB));

        setA.add("c");
        Assert.isTrue(setA.isProperSuperset(setB));

        setB.add("a");
        Assert.isFalse(setA.isProperSuperset(setB));
    }
}
