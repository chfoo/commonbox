package commonbox.adt;

/**
    Collection of items.
**/
interface Collection<T> extends IIterable<T> {
    /**
        Number of items in the collection.
    **/
    var length(get, never):Int;

    /**
        Returns whether the given item is in the collection.
    **/
    function contains(item:T):Bool;
}
