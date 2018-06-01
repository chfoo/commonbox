package commonbox.tests.ds;

import commonbox.ds.AutoMap;
import commonbox.testutils.Coordinate;
import haxe.ds.Option;
import utest.Assert;


class TestAutoMap {
    public function new() {
    }

    public function testMultitype() {
        new AutoMap<Int,Any>();
        new AutoMap<String,Any>();
        new AutoMap<Option<Any>,Any>();
        new AutoMap<Int,Any>();
        new AutoMap<Coordinate,Any>();
        new AutoMap<{},Any>();
        new AutoMap<Any,Any>();

        Assert.pass();
    }
}
