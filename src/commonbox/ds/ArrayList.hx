package commonbox.ds;

import Array as StdArray;
import commonbox.adt.Collection;


/**
    Variable-length sequence suited for random access.

    This sequence is the equivalent of Haxe standard Array and should
    be the general choice of sequence.

    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set | O(1) |
    | append/prepend | O(1) or O(n) depending on the implementation |
    | insert/remove | O(n) |
**/
@:forward
@:forwardStatics
abstract ArrayList<T>(ArrayListImpl<T>) to ArrayListImpl<T>
        from ArrayListImpl<T> {
    inline public function new(?ds:StdArray<T>) {
        this = new ArrayListImpl<T>(ds);
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


class ArrayListImpl<T> extends commonbox.ds.std.Array.ArrayImpl<T> {
    /**
        Wraps a standard Haxe Array.

        The array is not copied.
    **/
    public static function of<T>(array:StdArray<T>):ArrayList<T> {
        return new ArrayList<T>(array);
    }

    /**
        Returns a new `ArrayList` from the given collection.
    **/
    public static function fromCollection<T>(other:Collection<T>):ArrayList<T> {
        var array = new Array<T>();

        for (item in other) {
            array.push(item);
        }

        return of(array);
    }
}
