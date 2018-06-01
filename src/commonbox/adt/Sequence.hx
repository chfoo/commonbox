package commonbox.adt;

import haxe.ds.Option;

/**
    Ordered collection of items.
**/
interface BaseSequence<T> extends Collection<T> {
    /**
        Returns the item at the given position.

        The sequence is addressed by indexes from 0 to `length - 1` inclusive.
        If a negative index is provided, it is computed to be an offset from
        the end of the sequence (`length - index`).
        If the computed index is not valid, `OutOfBoundsException` is thrown.

        @param index Position of item.
    **/
    function get(index:Int):T;
}


interface BaseMutableSequence<T> extends BaseSequence<T> {
    /**
        Replaces the item at the given position with the given item.

        Accepted index ranges are the same as in `BaseSequence.get`.

        @param index Position of item.
        @param item Item to be placed.
    **/
    function set(index:Int, item:T):Void;
}


interface BaseMutableVariableSequence<T> extends BaseMutableSequence<T> {
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


interface SequenceRangeCopyable<T,S> extends BaseSequence<T> {
    /**
        Returns a new sequence containing the given range.

        Accepted index ranges are the same as in `BaseMutableVariableSequence.insert`.

        @param index Starting range.
        @param endIndex Ending range (not inclusive).
    **/
    function slice(index:Int, ?endIndex:Int):S;

    /**
        Returns a new sequence containing the sequence's items and
        the given collection's items.

        @param other Items to be placed after this sequence's items.
    **/
    function concat(other:Collection<T>):S;
}


interface Sequence<T>
        extends BaseSequence<T>
        extends Copyable<Sequence<T>>
        extends SequenceRangeCopyable<T,Sequence<T>>
        {
    /**
        Returns the first item in the sequence.

        If the sequence is empty, `OutOfBoundsException` is thrown.
    **/
    function first():T;

    /**
        Returns the first item in the sequence.
    **/
    function firstOption():Option<T>;

    /**
        Returns the `length - 1`-th item in the sequence.

        If the sequence is empty, `OutOfBoundsException` is thrown.
    **/
    function last():T;

    /**
        Returns the `length - 1`-th item in the sequence.
    **/
    function lastOption():Option<T>;

    /**
        Returns the position of first occurrence of the given item.

        This method accepts items implementing `Equatable`.

        @param item Item to be searched.
        @param fromIndex If given, the search is begin at the given index.
            Otherwise, the search starts at index 0.
    **/
    function indexOf(item:T, ?fromIndex:Int):Option<Int>;

    /**
        Returns whether the sequence is empty.
    **/
    function isEmpty():Bool;

    /**
        Returns whether the given contains the same items in order.

        This method accepts items implementing `Equatable`.

        @param other Another ordered sequence.
    **/
    function contentEquals(other:BaseSequence<T>):Bool;
}


interface MutableSequence<T>
        extends Sequence<T>
        extends BaseMutableSequence<T>
        extends Copyable<MutableSequence<T>>
        extends SequenceRangeCopyable<T,MutableSequence<T>>
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


interface MutableVariableSequence<T>
        extends Sequence<T>
        extends MutableSequence<T>
        extends BaseMutableVariableSequence<T>
        extends Copyable<MutableVariableSequence<T>>
        extends SequenceRangeCopyable<T,MutableVariableSequence<T>>
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
    function splice(index:Int, count:Int):MutableVariableSequence<T>;

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
