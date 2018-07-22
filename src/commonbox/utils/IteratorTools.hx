package commonbox.utils;

import commonbox.adt.IIterator;
import commonbox.impl.CopyIterator;
import haxe.ds.Option;

using commonbox.utils.EquatableTools;


/**
    Extensions to iterators.
**/
class IteratorTools<T> {
    /**
        Consumes and returns whether the given item exists in the iterator.

        This method accepts `Equatable` instances.
    **/
    public static function contains<T>(iterator:IIterator<T>, item:T):Bool {
        for (iteratorItem in iterator) {
            if (item.equals(iteratorItem)) {
                return true;
            }
        }

        return false;
    }

    /**
        Consumes and returns the number of elements in the iterator.
    **/
    public static function count<T>(iterator:IIterator<T>):Int {
        var count = 0;

        for (iteratorItem in iterator) {
            count += 1;
        }

        return count;
    }

    /**
        Consumes and returns the position of the item in the iterator.

        This method accepts `Equatable` instances.
    **/
    public static function indexOf<T>(iterator:IIterator<T>, item:T,
            ?fromIndex:Int):Option<Int> {
        if (fromIndex == null) {
            fromIndex = 0;
        }

        var index = 0;

        for (candidateItem in iterator) {
            if (index >= fromIndex && item.equals(candidateItem)) {
                return Some(index);
            }

            index += 1;
        }

        return None;
    }

    /**
        Consumes and returns a copy of the iterator.
    **/
    public static function copy<T>(iterator:IIterator<T>):IIterator<T> {
        return new CopyIterator<T>(iterator);
    }

    /**
        Consumes and returns whether the two iterators contains the same items.

        This method accepts `Equatable` instances.
    **/
    public static function contentEquals<T>(iterator:IIterator<T>,
            other:IIterator<T>):Bool {
        while (true) {
            if (!iterator.hasNext() && !other.hasNext()) {
                return true;
            } else if (!iterator.hasNext() || !other.hasNext()) {
                return false;
            }

            var itemA = iterator.next();
            var itemB = other.next();

            if (!itemA.equals(itemB)) {
                return false;
            }
        }

        throw "Shouldn't reach here";
    }
}
