package commonbox.utils;

import commonbox.adt.immutable.Sequence;

using commonbox.utils.IteratorTools;


/**
    Utility functions for sequences.
**/
class SequenceUtil {
    /**
        Returns whether the given sequence contains the given item.
    **/
    public static function contains<T>(
            sequence:BaseSequence<T>, item:T):Bool {
        return sequence.iterator().contains(item);
    }

    /**
        Returns an index bounded by the sequence range or throw an exception.

        Negative indexes are normalized to positive indexes.
        If the computed index is 0 to `length - 1` inclusive, it is returned.
        Otherwise, `OutOfBoundsException` is thrown.
    **/
    public static function normalizeIndex<T>(
            sequence:BaseSequence<T>, index:Int):Int {
        if (index > sequence.length - 1) {
            throw new Exception.OutOfBoundsException();
        } else if (index >= 0) {
            return index;
        }

        var index = sequence.length + index;

        if (index < 0) {
            throw new Exception.OutOfBoundsException();
        }

        return index;
    }

    /**
        Return an index bounded to the sequence range.

        Negative indexes are normalized to positive indexes. If the computed
        index is out of range, it is clamped to 0 or `length`.
        The index range is 0 to `length` inclusive.
    **/
    public static function normalizeInsertIndex<T>(
            sequence:BaseSequence<T>, index:Int):Int {
        if (index > sequence.length) {
            return sequence.length;
        } else if (index >= 0) {
            return index;
        }

        var index = sequence.length + index;

        if (index < 0) {
            index = 0;
        }

        return index;
    }
}
