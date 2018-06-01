package commonbox.utils;

import commonbox.adt.Comparable;

/**
    Utility for comparing the ordering of objects.
**/
class Comparer {
    /**
        Returns the ordering between two objects.

        @param itemA First object.
        @param itemB Second object.
        @param comparer Optional comparison function.

        This method uses `Comparable.compareTo` if possible. Otherwise,
        the standard `Reflect.compare` is used.

        The return value is negative if `itemA` is less than `itemB`, zero
        if they compare equal, and positive if `itemA` is greater than `itemB`.
    **/
    public static function compare<T>(itemA:T, itemB:T, ?comparer:T->T->Int):Int {
        if (comparer == null) {
            comparer = Reflect.compare;
        }

        if (Std.is(itemA, Comparable) && Std.is(itemB, Comparable)) {
            var comparableA:Comparable<T> = cast itemA;
            return comparableA.compareTo(itemB);
        } else {
            return comparer(itemA, itemB);
        }
    }
}
