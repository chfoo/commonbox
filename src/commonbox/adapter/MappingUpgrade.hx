package commonbox.adapter;

import commonbox.adapter.helper.MappingHelper;
import commonbox.adt.IIterator;
import commonbox.adt.Mapping;
import commonbox.adt.immutable.Mapping.BaseMapping as ImmutableBaseMapping;
import haxe.ds.Option;


/**
    Wraps `BaseMapping` object to implement `Mapping`.
**/
class MappingUpgrade<K,V> implements Mapping<K,V> {
    public var length(get, never):Int;

    var innerMapping:BaseMapping<K,V>;
    var mapFactory:Void->BaseMapping<K,V>;
    var helper:MappingHelper<K,V>;

    public function new(
            mapping:BaseMapping<K,V>,
            mapFactory:Void->BaseMapping<K,V>) {
        this.innerMapping = mapping;
        this.mapFactory = mapFactory;
        helper = new MappingHelper(mapping);
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

    public function contentEquals(other:ImmutableBaseMapping<K,V>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():Mapping<K,V> {
        var newMap = mapFactory();

        for (key in keys()) {
            newMap.set(key, getOnly(key));
        }

        return new MappingUpgrade(newMap, mapFactory);
    }

    public function clear() {
        helper.clear();
    }

    public function toString():String {
        return helper.toString();
    }
}
