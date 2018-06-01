package commonbox.adapter;

import commonbox.adapter.helper.MappingHelper;
import commonbox.adt.IIterator;
import commonbox.adt.Mapping;
import haxe.ds.Option;


/**
    Wraps `BaseMutableMapping` object to implement `MutableMapping`.
**/
class MutableMappingUpgrade<K,V> implements MutableMapping<K,V> {
    public var length(get, never):Int;

    var innerMapping:BaseMutableMapping<K,V>;
    var mapFactory:Void->BaseMutableMapping<K,V>;
    var helper:MutableMappingHelper<K,V>;

    public function new(
            mapping:BaseMutableMapping<K,V>,
            mapFactory:Void->BaseMutableMapping<K,V>) {
        this.innerMapping = mapping;
        this.mapFactory = mapFactory;
        helper = new MutableMappingHelper(mapping);
    }

    function get_length():Int {
        return innerMapping.length;
    }

    public function iterator():IIterator<V> {
        return innerMapping.iterator();
    }

    public function contains(item:V):Bool {
        return innerMapping.contains(item);
    }

    public function containsKey(key:K):Bool {
        return innerMapping.containsKey(key);
    }

    public function get(key:K):Option<V> {
        return innerMapping.get(key);
    }

    public function keys():IIterator<K> {
        return innerMapping.keys();
    }

    public function set(key:K, value:V) {
        innerMapping.set(key, value);
    }
    public function remove(key:K):Bool {
        return innerMapping.remove(key);
    }

    public function getOrElse(key:K, ?defaultItem:V):V {
        return helper.getOrElse(key, defaultItem);
    }

    public function getOnly(key:K):V {
        return helper.getOnly(key);
    }

    public function isEmpty():Bool {
        return helper.isEmpty();
    }

    public function contentEquals(other:BaseMapping<K,V>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():MutableMapping<K,V> {
        var newMap = mapFactory();

        for (key in keys()) {
            newMap.set(key, getOnly(key));
        }

        return new MutableMappingUpgrade(newMap, mapFactory);
    }

    public function clear() {
        helper.clear();
    }

    public function toString():String {
        return helper.toString();
    }
}
