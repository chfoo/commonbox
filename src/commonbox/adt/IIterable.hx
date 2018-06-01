package commonbox.adt;


/**
    Interface version of `Iterable`.

    Haxe standard `Iterable` uses structural subtyping which may not be
    desirable in some cases. This interface is provided when needed.
**/
interface IIterable<T> {
    function iterator():IIterator<T>;
}
