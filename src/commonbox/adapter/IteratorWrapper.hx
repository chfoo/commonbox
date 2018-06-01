package commonbox.adapter;

import commonbox.adt.IIterator;


/**
    Wraps a Iterator object to conform to the `IIterator` interface.
**/
class IteratorWrapper<T> implements IIterator<T> {
    var iterator:Iterator<T>;

    inline public function new(iterator:Iterator<T>) {
        this.iterator = iterator;
    }

    inline public function hasNext():Bool {
        return iterator.hasNext();
    }

    inline public function next():T {
        return iterator.next();
    }
}
