package commonbox.adapter;

import commonbox.adapter.helper.MutableSequenceHelper;
import commonbox.adapter.helper.SequenceRangeCopyableHelper;
import commonbox.adt.Collection;
import commonbox.adt.IIterator;
import commonbox.adt.Sequence;
import haxe.ds.Option;


/**
    Wraps `BaseMutableSequence` object to implement `MutableSequence`.
**/
class MutableSequenceUpgrade<T> implements MutableSequence<T> {
    public var length(get, never):Int;

    var sequence:BaseMutableSequence<T>;
    var sequenceFactory:Int->BaseMutableSequence<T>;
    var helper:MutableSequenceHelper<T,BaseMutableSequence<T>>;
    var rangeCopyHelper:SequenceRangeCopyableHelper<T>;

    public function new(
            sequence:BaseMutableSequence<T>,
            sequenceFactory:Int->BaseMutableSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;

        helper = new MutableSequenceHelper(sequence);
        rangeCopyHelper = new SequenceRangeCopyableHelper(
            sequence, sequenceFactory);
    }

    function get_length():Int {
        return sequence.length;
    }

    public function iterator():IIterator<T> {
        return sequence.iterator();
    }

    public function contains(item:T):Bool {
        return sequence.contains(item);
    }

    public function get(index:Int):T {
        return sequence.get(index);
    }

    public function set(index:Int, item:T) {
        sequence.set(index, item);
    }

    public function first():T {
        return helper.first();
    }

    public function firstOption():Option<T> {
        return helper.firstOption();
    }

    public function last():T {
        return helper.last();
    }

    public function lastOption():Option<T> {
        return helper.lastOption();
    }

    public function indexOf(item:T, ?fromIndex:Int):Option<Int> {
        return helper.indexOf(item, fromIndex);
    }

    public function slice(index:Int, ?endIndex:Int):MutableSequence<T> {
        return new MutableSequenceUpgrade(
            rangeCopyHelper.slice(index, endIndex), sequenceFactory);
    }

    public function concat(other:Collection<T>):MutableSequence<T> {
        return new MutableSequenceUpgrade(
            rangeCopyHelper.concat(other), sequenceFactory);
    }

    public function isEmpty():Bool {
        return helper.isEmpty();
    }

    public function reverse() {
        helper.reverse();
    }

    public function sort(?comparer:T->T->Int):Void {
        helper.sort(comparer);
    }

    public function contentEquals(other:BaseSequence<T>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():MutableSequence<T> {
        var newVector = sequenceFactory(sequence.length);

        for (index in 0...sequence.length) {
            newVector.set(index, sequence.get(index));
        }

        return new MutableSequenceUpgrade(newVector, sequenceFactory);
    }

    public function toString():String {
        return helper.toString();
    }
}
