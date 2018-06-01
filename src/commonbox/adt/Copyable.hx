package commonbox.adt;


/**
    Object than can create a clone of itself.
**/
interface Copyable<T> {
    /**
        Returns a shallow clone.
    **/
    function copy():T;
}
