package commonbox.adapter;

import commonbox.adt.IIterable;
import commonbox.adt.IIterator;


/**
    Wraps a Iterable object to conform to the `IIterable` interface.
**/
class IterableWrapper<C:Iterable<T>,T> implements IIterable<T> {
    var iterable:C;

    inline public function new(iterable:C) {
        this.iterable = iterable;
    }

    inline public function iterator():IIterator<T> {
        return new IteratorWrapper(this.iterable.iterator());
    }
}
