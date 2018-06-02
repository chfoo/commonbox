package commonbox.adt.immutable;

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


interface SequenceRangeCopyable<T,S:BaseSequence<T>> extends BaseSequence<T> {
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
