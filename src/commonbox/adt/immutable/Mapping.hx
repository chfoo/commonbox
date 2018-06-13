package commonbox.adt.immutable;

import haxe.ds.Option;


/**
    Collection of items pairs (key and value).

    At most one key is associated with a value.
**/
interface BaseMapping<K,V> extends Collection<V> {
    /**
        Returns whether the given key is in the collection.
    **/
    function containsKey(key:K):Bool;

    /**
        Returns the value associated with the given key.
    **/
    function get(key:K):Option<V>;

    /**
        Returns the keys in the collection.
    **/
    function keys():IIterator<K>;
}


interface Mapping<K,V>
        extends BaseMapping<K,V>
        {
    /**
        Returns the value if the key exists, otherwise the given default.
    **/
    function getOrElse(key:K, ?defaultItem:V):V;

    /**
        Returns the value if the key exists, otherwise throws `NotFoundException`.
    **/
    function getOnly(key:K):V;

    /**
        Returns whether the collection is empty.
    **/
    function isEmpty():Bool;

    /**
        Returns whether this collection has the same items in the given collection.
    **/
    function contentEquals(other:BaseMapping<K,V>):Bool;

    /**
        Returns a shallow clone.
    **/
    function copy():Mapping<K,V>;
}
