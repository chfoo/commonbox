package commonbox.adt;


/**
    Reference to an item in a collection.
**/
interface ElementRef<T> {
    /**
        Item in the collection.
    **/
    var item(get, never):T;
}
