package commonbox.testutils;

import commonbox.adt.Comparable;
import commonbox.adt.Equatable;
import commonbox.utils.HashCodeGenerator;


class Coordinate implements Equatable implements Comparable<Coordinate> {
    public var x(default, null):Int;
    public var y(default, null):Int;

    var _hashCode:Int;

    public function new(x:Int, y:Int, ?hashCode:Int) {
        this.x = x;
        this.y = y;

        if (hashCode != null) {
            _hashCode = hashCode;
        } else {
            _hashCode = HashCodeGenerator.getHashCode(x);
            _hashCode = HashCodeGenerator.getHashCode(y, _hashCode);
        }
    }

    public function hashCode():Int {
        return _hashCode;
    }

    public function equals(other:Any):Bool {
        if (!Std.is(other, Coordinate)) {
            return false;
        }

        var other:Coordinate = other;

        return x == other.x && y == other.y;
    }

    public function compareTo(other:Coordinate):Int {
        if (x == other.x) {
            return y - other.y;
        } else {
            return x - other.x;
        }
    }
}
