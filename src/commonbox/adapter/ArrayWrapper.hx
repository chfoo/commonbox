package commonbox.adapter;

import commonbox.adt.IIterator;
import commonbox.adt.Sequence;
import commonbox.utils.SequenceUtil;


/**
    Wraps a standard Haxe Array.
**/
class ArrayWrapper<T> implements BaseMutableVariableSequence<T> {
    public var length(get, never):Int;
    var innerArray:Array<T>;

    public function new(array:Array<T>) {
        this.innerArray = array;
    }

    function get_length():Int {
        return innerArray.length;
    }

    public function contains(item:T):Bool {
        return SequenceUtil.contains(this, item);
    }

    public function iterator():IIterator<T> {
        return new IteratorWrapper<T>(innerArray.iterator());
    }

    public function get(index:Int):T {
        return innerArray[SequenceUtil.normalizeIndex(this, index)];
    }

    public function set(index:Int, item:T) {
        innerArray[SequenceUtil.normalizeIndex(this, index)] = item;
    }

    public function insert(index:Int, item:T) {
        // Array already normalizes so no need for normalizeIndex()
        innerArray.insert(index, item);
    }

    public function removeAt(index:Int) {
        // Array already normalizes
        innerArray.splice(index, 1);
    }
}
