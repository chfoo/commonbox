package commonbox.adapter;

import commonbox.adapter.helper.SequenceHelper;
import commonbox.adapter.helper.immutable.SequenceRangeCopyableHelper;
import commonbox.adt.Collection;
import commonbox.adt.IIterator;
import commonbox.adt.Sequence;
import commonbox.adt.immutable.Sequence.BaseSequence as ImmutableBaseSequence;
import haxe.ds.Option;


/**
    Wraps `BaseSequence` object to implement `Sequence`.
**/
class SequenceUpgrade<T> implements Sequence<T> {
    public var length(get, never):Int;

    var sequence:BaseSequence<T>;
    var sequenceFactory:Int->BaseSequence<T>;
    var helper:SequenceHelper<T,BaseSequence<T>>;
    var rangeCopyHelper:SequenceRangeCopyableHelper<T>;

    public function new(
            sequence:BaseSequence<T>,
            sequenceFactory:Int->BaseSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;

        helper = new SequenceHelper(sequence);
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

    public function lastIndexOf(item:T, ?fromIndex:Int):Option<Int> {
        return helper.lastIndexOf(item, fromIndex);
    }

    public function slice(index:Int, ?endIndex:Int):Sequence<T> {
        return new SequenceUpgrade(
            rangeCopyHelper.slice(index, endIndex), sequenceFactory);
    }

    public function concat(other:Collection<T>):Sequence<T> {
        return new SequenceUpgrade(
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

    public function contentEquals(other:ImmutableBaseSequence<T>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():Sequence<T> {
        var newVector = sequenceFactory(sequence.length);

        for (index in 0...sequence.length) {
            newVector.set(index, sequence.get(index));
        }

        return new SequenceUpgrade(newVector, sequenceFactory);
    }

    public function toString():String {
        return helper.toString();
    }
}
