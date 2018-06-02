package commonbox.adapter;

import commonbox.adt.IIterator;
import commonbox.adt.Mapping;
import commonbox.utils.IteratorTools;
import haxe.Constraints.IMap;
import haxe.ds.Option;


/**
    Wraps a `haxe.Constraints.IMap`.
**/
class MapWrapper<K,V> implements BaseMapping<K,V> {
    public var length(get, never):Int;

    var innerMap:IMap<K,V>;
    var _length = 0;

    public function new(map:IMap<K,V>) {
        this.innerMap = map;
    }

    inline function get_length():Int {
        return _length;
    }

    public function iterator():IIterator<V> {
        return new IteratorWrapper(innerMap.iterator());
    }

    public function contains(value:V):Bool {
        return IteratorTools.contains(iterator(), value);
    }

    public function containsKey(key:K):Bool {
        return innerMap.exists(key);
    }

    public function get(key:K):Option<V> {
        if (innerMap.exists(key)) {
            return Some(innerMap.get(key));
        } else {
            return None;
        }
    }

    public function keys():IIterator<K> {
        return new IteratorWrapper(innerMap.keys());
    }

    public function set(key:K, value:V) {
        if (!innerMap.exists(key)) {
            _length += 1;
        }

        innerMap.set(key, value);
    }

    public function remove(key:K):Bool {
        var result = innerMap.remove(key);
        if (result) {
            _length -= 1;
        }

        return result;
    }
}
