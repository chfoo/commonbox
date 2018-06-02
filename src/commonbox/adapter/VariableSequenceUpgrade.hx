package commonbox.adapter;

import commonbox.adapter.helper.VariableSequenceHelper;
import commonbox.adapter.helper.VariableSequenceRangeCopyableHelper;
import commonbox.adt.Collection;
import commonbox.adt.IIterator;
import commonbox.adt.immutable.Sequence.BaseSequence as ImmutableBaseSequence;
import commonbox.adt.Sequence;
import commonbox.adt.VariableSequence;
import haxe.ds.Option;


/**
    Wraps `BaseVariableSequence` object to implement `VariableSequence`.
**/
class VariableSequenceUpgrade<T> implements VariableSequence<T> {
    public var length(get, never):Int;

    var sequence:BaseVariableSequence<T>;
    var sequenceFactory:Void->BaseVariableSequence<T>;
    var helper:VariableSequenceHelper<T,BaseVariableSequence<T>>;
    var rangeCopyHelper:VariableSequenceRangeCopyableHelper<T>;

    public function new(
            sequence:BaseVariableSequence<T>,
            sequenceFactory:Void->BaseVariableSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;

        helper = new VariableSequenceHelper(sequence, sequenceFactory);
        rangeCopyHelper = new VariableSequenceRangeCopyableHelper(
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

    public function copy():VariableSequence<T> {
        var newSeq = sequenceFactory();

        for (item in sequence) {
            newSeq.insert(newSeq.length, item);
        }

        return new VariableSequenceUpgrade(newSeq, sequenceFactory);
    }

    public function slice(index:Int, ?endIndex:Int):VariableSequence<T> {
        return new VariableSequenceUpgrade(
            rangeCopyHelper.slice(index, endIndex), sequenceFactory);
    }

    public function concat(other:Collection<T>):VariableSequence<T> {
        return new VariableSequenceUpgrade(
            rangeCopyHelper.concat(other), sequenceFactory);
    }

    public function insert(index:Int, item:T) {
        sequence.insert(index, item);
    }
    public function removeAt(index:Int) {
        sequence.removeAt(index);
    }

    public function push(item:T) {
        helper.push(item);
    }

    public function pop():Option<T> {
        return helper.pop();
    }

    public function shift(item:T) {
        helper.shift(item);
    }

    public function unshift():Option<T> {
        return helper.unshift();
    }

    public function splice(index:Int, count:Int):VariableSequence<T> {
        return new VariableSequenceUpgrade(
            helper.splice(index, count), sequenceFactory);
    }

    public function unsplice(index:Int, other:Collection<T>) {
        helper.unsplice(index, other);
    }

    public function extend(other:Collection<T>) {
        helper.extend(other);
    }

    public function remove(item:T):Bool {
        return helper.remove(item);
    }

    public function clear() {
        helper.clear();
    }

    public function toString():String {
        return helper.toString();
    }
}
