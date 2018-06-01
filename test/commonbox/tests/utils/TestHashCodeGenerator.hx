package commonbox.tests.utils;

import commonbox.utils.HashCodeGenerator;
import haxe.Int64;
import utest.Assert;


class TestHashCodeGenerator {
    public function new() {
    }

    public function testHashCode() {
        var items:Array<Any> = [
            null,
            true,
            123,
            123.456,
            Int64.make(123, 123),
            "123"
        ];

        for (item in items) {
            // trace('$item');
            var result = HashCodeGenerator.getHashCode(item);
            // trace('$item $result');

            Assert.is(result, Int);
            Assert.notEquals(result, 0);
        }
    }

    public function testHashCodeMutable() {
        Assert.raises(
            HashCodeGenerator.getHashCode.bind(new EmptyClass()),
            Exception
        );
    }
}

private class EmptyClass {
    public function new() {
    }
}
