package commonbox.utils;

import commonbox.adt.Collection;


/**
    Common extended features involving collections.

    These static method extensions tightly involve collections, but don't
    manipulate collections themselves.
**/
class CollectionTools {
    /**
        Returns a string containing string representations of each item
        separated by the given separator.
    **/
    public static function join<T>(collection:Collection<T>,
            separator:String):String {
        var buffer = new StringBuf();
        var index = 0;

        for (item in collection) {
            buffer.add(Std.string(item));

            if (index < collection.length - 1) {
                buffer.add(separator);
            }

            index += 1;
        }

        return buffer.toString();
    }
}
