package commonbox.tests.ds;

import commonbox.ds.AnyMap;
import commonbox.testutils.MappingTester;


class TestAnyMap {
    var _function:Void->Void;

    public function new() {
        _function = function () {};
    }

    public function testMap() {
        var tester = new MappingTester(AnyMap.new, keyGenerator);
        tester.test();
    }

    function keyGenerator(key:Int):Any {
        switch (key) {
            case 1:
                return _function;
            default:
                return key;
        }
    }
}
