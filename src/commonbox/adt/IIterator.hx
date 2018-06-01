package commonbox.adt;


/**
    Interface version of `Iterator`.

    Haxe standard `Iterator` uses structural subtyping which may not be
    desirable in some cases. This interface is provided when needed.
**/
interface IIterator<T> {
    function hasNext():Bool;
    function next():T;
}
