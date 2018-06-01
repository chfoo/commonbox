package commonbox.impl;

import commonbox.adt.IIterator;


/**
    Wraps a copy of an iterator.

    This iterator consumes the given iterator into its own buffer.

    This iterator is intended for use on iterators that are not safe
    when its data structure is mutated. For example, it is not guaranteed to
    be safe iterating a map while deleting items from it.
**/
class CopyIterator<T> implements IIterator<T> {
    var items:Array<T>;
    var index = 0;

    public function new(iterator:IIterator<T>) {
        items = new Array();

        for (item in iterator) {
            items.push(item);
        }
    }

    public function hasNext():Bool {
        return index <= items.length - 1;
    }

    public function next():T {
        var item = items[index];
        index += 1;
        return item;
    }
}
