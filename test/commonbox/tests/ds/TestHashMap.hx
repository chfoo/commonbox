package commonbox.tests.ds;

import commonbox.ds.HashMap;
import commonbox.testutils.Coordinate;
import commonbox.testutils.MappingTester;


class TestHashMap {
    public function new() {
    }

    public function testMap() {
        var tester = new MappingTester(HashMap.new, keyGenerator);
        tester.test();
    }

    public function testMapSameHashCode() {
        var tester = new MappingTester(HashMap.new, keyGeneratorHashCode);
        tester.test();
    }

    function keyGenerator(key:Int):Coordinate {
        return new Coordinate(key, 0);
    }

    function keyGeneratorHashCode(key:Int):Coordinate {
        return new Coordinate(key, 0, 12345);
    }
}
