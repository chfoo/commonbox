package commonbox.ds;

import commonbox.adt.Equatable;
import commonbox.adt.Mapping;
import commonbox.ds.std.StringMap as WrappedStringMap;
import commonbox.ds.std.IntMap as WrappedIntMap;
import commonbox.ds.std.EnumValueMap as WrappedEnumValueMap;
import commonbox.ds.std.ObjectMap as WrappedObjectMap;


/**
    Multitype abstract that morphs into a mapping instance suitable for its
    key type.

    This abstract is similar to standard `Map`.

    This abstract morphs into:

    * `HashMap` if the keys implement `Equatable`
    * `StringMap` if the keys are String
    * `IntMap` if the keys are Int
    * `EnumValueMap` if the keys are Enum values
    * `ObjectMap` if the keys are class instances
    * `AnyMap` otherwise

    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set/remove | O(1) average (except for `AnyMap`) |
**/
@:forward
@:forwardStatics
@:multiType(@:followWithAbstracts K)
abstract AutoMap<K,V>(Mapping<K,V>) {
    public function new();

    @:to
    static inline function toHashMap<K:Equatable,V>(map:Mapping<K,V>)
            :HashMap<K,V> {
        return new HashMap<K,V>();
    }

    @:to
    static inline function toStringMap<K:String,V>(map:Mapping<K,V>)
            :WrappedStringMap<V> {
        return new WrappedStringMap<V>();
    }

    @:to
    static inline function toIntMap<K:Int,V>(map:Mapping<K,V>)
            :WrappedIntMap<V> {
        return new WrappedIntMap<V>();
    }

    @:to
    static inline function toEnumValueMap<K:EnumValue,V>(
            map:Mapping<K,V>):WrappedEnumValueMap<K,V> {
        return new WrappedEnumValueMap<K,V>();
    }

    @:to
    static inline function toObjectMap<K:{},V>(map:Mapping<K,V>)
            :WrappedObjectMap<K,V> {
        return new WrappedObjectMap();
    }

    @:to
    static inline function toAnyMap<K,V>(map:Mapping<K,V>)
            :AnyMap<K,V> {
        return new AnyMap();
    }

    @:arrayAccess
    inline function _get(key:K) {
        return this.get(key);
    }

    @:arrayAccess
    inline function _set(key:K, value:V) {
        return this.set(key, value);
    }
}
