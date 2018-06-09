package commonbox.testutils;

import commonbox.adt.Mapping;
import utest.Assert;

using commonbox.utils.IteratorTools;


class MappingTester<K> {
    var mapping:Mapping<K,Any>;
    var keyGenerator:Int->K;
    var mappingFactory:Void->Mapping<K,Any>;

    public function new(mappingFactory:Void->Mapping<K,Any>, keyGenerator:Int->K) {
        this.mappingFactory = mappingFactory;
        this.mapping = mappingFactory();
        this.keyGenerator = keyGenerator;
    }

    public function test() {
        testContainer();
        testCopy();
        testGetters();
        testRemoveClear();
        testEquals();
    }

    function testContainer() {
        var key1 = keyGenerator(1);
        var key2 = keyGenerator(2);
        var key3 = keyGenerator(3);

        mapping.set(key1, "a");
        mapping.set(key2, "b");
        mapping.set(key3, "c");

        trace(mapping);

        Assert.equals(3, mapping.length);
        Assert.isTrue(mapping.contains("b"));
        Assert.isTrue(mapping.containsKey(key2));

        Assert.equals(3, mapping.iterator().count());
        Assert.isTrue(mapping.iterator().contains("a"));
        Assert.isTrue(mapping.iterator().contains("b"));
        Assert.isTrue(mapping.iterator().contains("c"));

        Assert.equals(3, mapping.keys().count());
        Assert.isTrue(mapping.keys().contains(key1));
        Assert.isTrue(mapping.keys().contains(key2));
        Assert.isTrue(mapping.keys().contains(key3));
    }

    function testCopy() {
        var mappingCopy = mapping.copy();
        Assert.isTrue(mapping.contentEquals(mappingCopy));
    }

    function testGetters() {
        var key1 = keyGenerator(1);
        var key999 = keyGenerator(999);

        Assert.equals("a", mapping.getOnly(key1));
        Assert.raises(mapping.getOnly.bind(key999), Exception.NotFoundException);
        Assert.equals("a", mapping.getOrElse(key1, "zzz"));
        Assert.equals("zzz", mapping.getOrElse(key999, "zzz"));
    }

    function testRemoveClear() {
        Assert.equals(3, mapping.length);

        var key1 = keyGenerator(1);
        Assert.isTrue(mapping.remove(key1));
        Assert.isFalse(mapping.remove(key1));
        Assert.equals(2, mapping.length);

        mapping.clear();
        Assert.equals(0, mapping.length);
        Assert.isTrue(mapping.isEmpty());
        Assert.isTrue(!mapping.containsKey(key1));
    }

    function testEquals() {
        var mappingA = mappingFactory();
        var mappingB = mappingFactory();

        Assert.isTrue(mappingA.contentEquals(mappingB));

        mappingA.set(keyGenerator(1), "a");
        mappingB.set(keyGenerator(1), "a");
        Assert.isTrue(mappingA.contentEquals(mappingB));

        mappingA.set(keyGenerator(1), "a");
        mappingB.set(keyGenerator(1), "b");
        Assert.isFalse(mappingA.contentEquals(mappingB));

        mappingA = mappingFactory();
        mappingB = mappingFactory();
        mappingA.set(keyGenerator(1), "a");
        mappingB.set(keyGenerator(1), "a");
        mappingB.set(keyGenerator(2), "b");
        Assert.isFalse(mappingA.contentEquals(mappingB));

        mappingA = mappingFactory();
        mappingB = mappingFactory();
        mappingA.set(keyGenerator(1), "a");
        mappingA.set(keyGenerator(2), "b");
        mappingB.set(keyGenerator(1), "a");
        Assert.isFalse(mappingA.contentEquals(mappingB));
    }
}
