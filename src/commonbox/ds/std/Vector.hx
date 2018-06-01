package commonbox.ds.std;

import commonbox.adapter.MutableSequenceUpgrade;
import commonbox.adapter.VectorWrapper;
import commonbox.adt.Sequence;
import haxe.ds.Vector as StdVector;


/**
    Sequence using standard `haxe.ds.Vector` as the implementation.
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


class VectorImpl<T> extends MutableSequenceUpgrade<T>
        implements MutableSequence<T>
        implements StandardDataStructureWrapper<StdVector<T>> {
    var _stdDS:StdVector<T>;

    public function new(length:Int, ?ds:StdVector<T>) {
        _stdDS = ds != null ? ds : new StdVector<T>(length);

        super(new VectorWrapper(_stdDS), factory);
    }

    function factory(length:Int) {
        return new VectorWrapper(new StdVector<T>(length));
    }

    public function unwrap() {
        return _stdDS;
    }
}
