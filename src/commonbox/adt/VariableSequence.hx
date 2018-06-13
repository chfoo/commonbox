package commonbox.adt;

import commonbox.adt.immutable.Sequence.SequenceRangeCopyable;
import commonbox.adt.Sequence;
import haxe.ds.Option;


interface BaseVariableSequence<T> extends BaseSequence<T> {
    /**
        Inserts the given item at the given position.

        Insertion points by indexes are addressed from 0 to `length` inclusive.
        If a negative index is provided, it is computed to be an offset from
        the end of the sequence (`length - index`).
        If the index is not in range, it is clamped to the nearest beginning
        or end.

        Abstractly, items at the given index and greater are shifted by
        incrementing their position by one. Then, the given item is placed
        at the given index.

        @param index Position of item.
        @param item Item to be inserted.
    **/
    function insert(index:Int, item:T):Void;

    /**
        Removes an item at the given position.

        Accepted index ranges are the same as in `BaseVariableSequence.insert`.

        @param index Position to item to be removed.
    **/
    function removeAt(index:Int):Void;
}


interface VariableSequence<T>
        extends Sequence<T>
        extends BaseVariableSequence<T>
        {

    // Contravariant return type methods:
    function copy():VariableSequence<T>;
    function slice(index:Int, ?endIndex:Int):VariableSequence<T>;
    function concat(other:Collection<T>):VariableSequence<T>;

    /**
        Adds the given item to the end of the sequence.
    **/
    function push(item:T):Void;

    /**
        Removes the last item in the sequence and return it.
    **/
    function pop():Option<T>;

    /**
        Adds the given item to the beginning of the sequence.
    **/
    function unshift(item:T):Void;

    /**
        Removes the first item in the sequence and returns it.
    **/
    function shift():Option<T>;

    /**
        Removes a range of items and returns it.

        Accepted index ranges are the same as in `BaseVariableSequence.insert`.

        @param index Beginning of the range.
        @param count Number of items. It is clamped if it is out of range.
    **/
    function splice(index:Int, count:Int):VariableSequence<T>;

    /**
        Inserts a given sequence.

        Accepted index ranges are the same as in `BaseVariableSequence.insert`.

        @param index Position to insert.
        @param other Items to be inserted.
    **/
    function unsplice(index:Int, other:Collection<T>):Void;

    /**
        Appends items to the sequence.

        @param other Items to be appended.
    **/
    function extend(other:Collection<T>):Void;

    /**
        Removes the first occurrence of an item.
    **/
    function remove(item:T):Bool;

    /**
        Removes all items in the sequence.
    **/
    function clear():Void;
}
