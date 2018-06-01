package commonbox.ds.std;

import Array as StdArray;
import commonbox.adapter.ArrayWrapper;
import commonbox.adapter.MutableVariableSequenceUpgrade;
import commonbox.adt.Collection;
import commonbox.adt.Sequence;


/**
    Sequence using standard Haxe Array as the implementation.
**/
@:forward
@:forwardStatics
abstract Array<T>(ArrayImpl<T>) to ArrayImpl<T>
        from ArrayImpl<T> {
    inline public function new() {
        this = new ArrayImpl<T>();
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


class ArrayImpl<T> extends MutableVariableSequenceUpgrade<T>
        implements MutableVariableSequence<T>
        implements StandardDataStructureWrapper<StdArray<T>> {
    var _stdDS:StdArray<T>;

    public function new(?ds:StdArray<T>) {
        _stdDS = ds != null ? ds : new StdArray<T>();

        super(new ArrayWrapper<T>(_stdDS), factory);
    }

    function factory() {
        return new ArrayWrapper<T>(new StdArray<T>());
    }

    public function unwrap() {
        return _stdDS;
    }

    @:access(commonbox.ds.std.ArrayImpl)
    function getUnderlyingArray() {
        return _stdDS;
    }

    override public function concat(other:Collection<T>)
            :MutableVariableSequence<T> {
        if (Std.is(other, ArrayImpl)) {
            var otherArray:ArrayImpl<T> = cast other;
            var newArray = _stdDS.concat(otherArray.getUnderlyingArray());

            return new MutableVariableSequenceUpgrade(
                new ArrayWrapper(newArray),
                sequenceFactory
            );

        } else {
            return super.concat(other);
        }
    }

    override public function slice(index:Int, ?endIndex:Int) {
        return new MutableVariableSequenceUpgrade(
            new ArrayWrapper(_stdDS.slice(index, endIndex)),
            sequenceFactory
        );
    }
}
