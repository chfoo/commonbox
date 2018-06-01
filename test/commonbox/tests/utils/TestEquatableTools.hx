package commonbox.tests.utils;

import commonbox.testutils.Coordinate;
import commonbox.utils.EquatableTools;
import utest.Assert;


class TestEquatableTools {
    public function new() {
    }

    public function testEquals() {
        Assert.isTrue(EquatableTools.equals(123, 123));
        Assert.isFalse(EquatableTools.equals(123, 789));

        Assert.isTrue(EquatableTools.equals("abc", "abc"));
        Assert.isFalse(EquatableTools.equals("abc", "xyz"));

        Assert.isTrue(EquatableTools.equals(
            new Coordinate(123, 456), new Coordinate(123, 456)
        ));
        Assert.isFalse(EquatableTools.equals(
            new Coordinate(123, 456), new Coordinate(123, 789)
        ));
    }
}
