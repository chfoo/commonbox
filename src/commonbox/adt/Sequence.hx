package commonbox.adt;

import commonbox.adt.immutable.Sequence as ImmutableSequence;
import commonbox.adt.immutable.Sequence.BaseSequence as ImmutableBaseSequence;
import commonbox.adt.immutable.Sequence.SequenceRangeCopyable;
import haxe.ds.Option;


interface BaseSequence<T> extends ImmutableBaseSequence<T> {
    /**
        Replaces the item at the given position with the given item.

        Accepted index ranges are the same as in `BaseSequence.get`.

        @param index Position of item.
        @param item Item to be placed.
    **/
    function set(index:Int, item:T):Void;
}


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

        Accepted index ranges are the same as in `BaseMutableVariableSequence.insert`.

        @param index Position to item to be removed.
    **/
    function removeAt(index:Int):Void;
}



interface Sequence<T>
        extends ImmutableSequence<T>
        extends BaseSequence<T>
        extends Copyable<Sequence<T>>
        extends SequenceRangeCopyable<T,Sequence<T>>
        {
    /**
        Reverses the positions of the items in the sequence.
    **/
    function reverse():Void;

    /**
        Sorts the items.

        If the items implement `Comparable`, it will use that for ordering.

        @param comparer Optional comparison function. If not given,
            `Reflect.compare` is used instead.
    **/
    function sort(?comparer:T->T->Int):Void;
}


interface VariableSequence<T>
        extends ImmutableSequence<T>
        extends Sequence<T>
        extends BaseVariableSequence<T>
        extends Copyable<VariableSequence<T>>
        extends SequenceRangeCopyable<T,VariableSequence<T>>
        {
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
    function shift(item:T):Void;

    /**
        Removes the first item in the sequence and returns it.
    **/
    function unshift():Option<T>;

    /**
        Removes a range of items and returns it.

        Accepted index ranges are the same as in `BaseMutableVariableSequence.insert`.

        @param index Beginning of the range.
        @param count Number of items. It is clamped if it is out of range.
    **/
    function splice(index:Int, count:Int):VariableSequence<T>;

    /**
        Inserts a given sequence.

        Accepted index ranges are the same as in `BaseMutableVariableSequence.insert`.

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
