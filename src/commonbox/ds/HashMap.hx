package commonbox.ds;

import commonbox.adt.Equatable;
import commonbox.adt.Mapping;
import commonbox.impl.IntBucketMap;
import commonbox.adapter.MappingUpgrade;


/**
    Mapping for keys that implement `Equatable`.

    This mapping is suitable for keys that do not have a natural ordering,
    unlike an integer, or are composed of multiple data types. This differs
    from an `ObjectMap` which only uses reference equality.

    For example, this map can be used to store pairs of xy coordinates which
    is a composite of two integers. A class implementing `Equatable`
    representing the coordinate can be used as a key.


    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set/remove |  O(1) average |
**/
class HashMap<K:Equatable,V> extends MappingUpgrade<K,V>
        implements Mapping<K,V> {
    public function new() {
        super(new IntBucketMap(), IntBucketMap.new);
    }
}
