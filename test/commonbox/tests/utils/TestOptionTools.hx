package commonbox.tests.utils;

import commonbox.utils.OptionTools;
import haxe.ds.Option;
import utest.Assert;


class TestOptionTools {
    public function new() {
    }

    public function testIsSome() {
        Assert.isTrue(OptionTools.isSome(Option.Some(123)));
        Assert.isFalse(OptionTools.isSome(Option.None));
    }

    public function testIsNone() {
        Assert.isFalse(OptionTools.isNone(Option.Some(123)));
        Assert.isTrue(OptionTools.isNone(Option.None));
    }

    public function testGetSome() {
        Assert.equals(123, OptionTools.getSome(Option.Some(123)));

        Assert.raises(
            OptionTools.getSome.bind(Option.None),
            Exception.InvalidStateException);
    }


    public function testGetSomeOrElse() {
        Assert.equals(123, OptionTools.getSomeOrElse(Option.Some(123), 456));
        Assert.equals(456, OptionTools.getSomeOrElse(Option.None, 456));
    }

    public function testSomeEquals() {
        Assert.isTrue(OptionTools.someEquals(Option.Some(123), 123));
        Assert.isFalse(OptionTools.someEquals(Option.Some(123), 456));
        Assert.isFalse(OptionTools.someEquals(Option.None, 123));
    }
}
