package example.example;

import commonbox.utils.HashCodeGenerator;
import commonbox.adt.Comparable;
import commonbox.adt.Equatable;
import commonbox.adt.Sequence;
import commonbox.ds.ArrayList;
import commonbox.ds.List;
import commonbox.ds.AutoMap;
import commonbox.ds.HashMap;
import commonbox.ds.Vector;


class ExampleReadme {
    public static function main() {
        sequenceExample();
        mappingExample();
        equalityAndComparisonExample();
    }

    static function sequenceExample() {
        var array = [1, 2, 3];
        var sequence = ArrayList.of(array);

        sequence.push(4);
        array = sequence.unwrap();
        trace(sequence);

        var vector = Vector.fromCollection(sequence);
        trace(vector);

        function addOne(sequence:Sequence<Int>) {
            for (index in 0...sequence.length) {
                sequence.set(index, sequence.get(index) + 1);
            }
        }

        var array = ArrayList.of([1, 2, 3]);
        var vector = Vector.fromCollection(array);
        var list = List.fromCollection(array);

        addOne(array);
        addOne(vector);
        addOne(list);

        trace(array);
        trace(vector);
        trace(list);
    }

    static function mappingExample() {
        var map = new AutoMap<Int,String>();
        map.set(100, "hello");

        switch (map.get(100)) {
            case Some(value):
                trace(value);
            case None:
                trace("No value");
        }

        trace(map.getOnly(100));
        // trace(map.getOnly(200)); // NotFoundException
        trace(map.getOrElse(200, "default value")); // "default value"
    }

    static function equalityAndComparisonExample() {
        var points = ArrayList.of([
            new Coordinate(10, 5),
            new Coordinate(5, 5),
            new Coordinate(10, -10)
        ]);

        points.sort();
        trace(points);

        var map = new HashMap<Coordinate,String>();
        map.set(new Coordinate(3, 4), "point 1");

        var label = map.getOnly(new Coordinate(3, 4));
        trace(label);
    }
}


class Coordinate implements Equatable implements Comparable<Coordinate> {
    public var x:Float;
    public var y:Float;

    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
    }

    public function hashCode():Int {
        var hashCode = HashCodeGenerator.getHashCode(x);
        hashCode = HashCodeGenerator.getHashCode(y, hashCode);
        return hashCode;
    }

    public function equals(other:Any):Bool {
        if (other == null || !Std.is(other, Coordinate)) {
            return false;
        }

        var other:Coordinate = cast other;

        return x == other.x && y == other.y;
    }

    public function compareTo(other:Coordinate):Int {
        if (x == other.x) {
            return Reflect.compare(y, other.y);
        } else {
            return Reflect.compare(x, other.x);
        }
    }
}
