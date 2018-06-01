package commonbox.adapter;

import commonbox.adt.IIterator;
import commonbox.adt.Sequence;
import commonbox.utils.SequenceUtil;
import haxe.ds.Vector;


/**
    Wraps a Haxe `haxe.ds.Vector`.
**/
class VectorWrapper<T> implements BaseMutableSequence<T> {
    public var length(get, never):Int;
    var innerVector:Vector<T>;

    public function new(vector:Vector<T>) {
        this.innerVector = vector;
    }

    function get_length():Int {
        return innerVector.length;
    }

    public function contains(item:T):Bool {
        return SequenceUtil.contains(this, item);
    }

    public function iterator():IIterator<T> {
        return new VectorWrapperIterator<T>(innerVector);
    }

    public function get(index:Int):T {
        return innerVector[SequenceUtil.normalizeIndex(this, index)];
    }

    public function set(index:Int, item:T) {
        innerVector[SequenceUtil.normalizeIndex(this, index)] = item;
    }
}


class VectorWrapperIterator<T> implements IIterator<T> {
    var vector:Vector<T>;
    var index = 0;

    public function new(vector:Vector<T>) {
        this.vector = vector;
    }

    public function hasNext():Bool {
        return index <= vector.length - 1;
    }

    public function next():T {
        var item = vector[index];
        index += 1;
        return item;
    }
}
