package commonbox.ds;

import Array as StdArray;
import commonbox.adt.Collection;
import commonbox.ds.std.Vector.VectorImpl as WrappedVectorImpl;
import haxe.ds.Vector as StdVector;

/**
    Fixed-length sequence.

    A vector is a fixed-length sequence equivalent to `haxe.ds.Vector`.
    On some targets, it provides faster operations than `ArrayList`.

    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set | O(1) |
**/
@:forward
@:forwardStatics
abstract Vector<T>(VectorImpl<T>) to VectorImpl<T>
        from VectorImpl<T> {
    /**
        Returns a new `Vector` with default values.

        The default value of each item in the vector is dependent on the
        standard Haxe Vector. See the Haxe documentation on Vector for details.

        @param length Length of the collection.
        @param ds Optional standard Vector to be wrapped.
    **/
    inline public function new(length:Int, ?ds:StdVector<T>) {
        this = new VectorImpl<T>(length, ds);
    }

    @:arrayAccess
    inline function _get(index:Int) {
        return this.get(index);
    }

    @:arrayAccess
    inline function _set(index:Int, item:T) {
        return this.set(index, item);
    }
}


class VectorImpl<T> extends WrappedVectorImpl<T> {
    /**
        Returns a new `Vector` from the given collection.
    **/
    public static function fromCollection<T>(other:Collection<T>):Vector<T> {
        var vector = new Vector<T>(other.length);
        var index = 0;

        for (item in other) {
            vector.set(index, item);
            index += 1;
        }

        return vector;
    }
}
