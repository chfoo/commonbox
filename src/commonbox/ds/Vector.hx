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
        var items = new StdArray<T>();

        for (item in other) {
            items.push(item);
        }

        var vector = new Vector<T>(items.length);

        for (index in 0...items.length) {
            vector.set(index, items[index]);
        }

        return vector;
    }
}
