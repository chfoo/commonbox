package commonbox.adt;

import commonbox.adt.immutable.Sequence as ImmutableSequence;
import commonbox.adt.immutable.Sequence.BaseSequence as ImmutableBaseSequence;
import commonbox.adt.immutable.Sequence.SequenceRangeCopyable;


interface BaseSequence<T> extends ImmutableBaseSequence<T> {
    /**
        Replaces the item at the given position with the given item.

        Accepted index ranges are the same as in `BaseSequence.get`.

        @param index Position of item.
        @param item Item to be placed.
    **/
    function set(index:Int, item:T):Void;
}


interface Sequence<T>
        extends ImmutableSequence<T>
        extends BaseSequence<T>
        {
    // Contravariant return type methods:
    function copy():Sequence<T>;
    function slice(index:Int, ?endIndex:Int):Sequence<T>;
    function concat(other:Collection<T>):Sequence<T>;

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
