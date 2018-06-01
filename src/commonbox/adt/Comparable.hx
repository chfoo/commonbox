package commonbox.adt;


/**
    Object that can be compared to another for ordering.
**/
interface Comparable<T> extends Equatable {
    /**
        Compares another object and returns the ordering.

        Returns

        * a negative integer if this object is less than `other`,
        * zero if compared equal,
        * or positive integer if this object is greater than `other`.
    **/
    function compareTo(other:T):Int;
}
