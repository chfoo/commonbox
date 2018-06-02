package commonbox.adt;

import commonbox.adt.immutable.Mapping as ImmutableMapping;
import commonbox.adt.immutable.Mapping.BaseMapping as BaseImmutableMapping;


interface BaseMapping<K,V> extends BaseImmutableMapping<K,V> {
    /**
        Sets the value associated with the key.

        If the given key already has an association, it is replaced.
    **/
    function set(key:K, value:V):Void;

    /**
        Remove the association by the given key.
    **/
    function remove(key:K):Bool;
}


interface Mapping<K,V>
        extends ImmutableMapping<K,V>
        extends BaseMapping<K,V>
        extends Copyable<Mapping<K,V>>
        {
    /**
        Remove all associations.
    **/
    function clear():Void;
}
