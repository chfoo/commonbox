package commonbox.impl;

import commonbox.adt.IIterator;
import commonbox.adt.Mapping;
import commonbox.utils.IteratorTools;
import commonbox.adapter.IteratorWrapper;
import haxe.ds.Option;


/**
    A mapping using arrays between any key and value.

    All operations are O(n).
**/
class AnyKeyArrayMap<K,V> implements BaseMutableMapping<K,V> {
    public var length(get, never):Int;

    var _keys:Array<K>;
    var _values:Array<V>;

    public function new() {
        _keys = new Array();
        _values = new Array();
    }

    function get_length():Int {
        return _keys.length;
    }

    public function iterator():IIterator<V> {
        return new IteratorWrapper<V>(_values.iterator());
    }

    public function contains(item:V):Bool {
        return IteratorTools.contains(iterator(), item);
    }

    public function containsKey(key:K):Bool {
        return _keys.indexOf(key) >= 0;
    }

    public function get(key:K):Option<V> {
        var index = _keys.indexOf(key);

        if (index >= 0) {
            return Some(_values[index]);
        } else {
            return None;
        }
    }

    public function keys():IIterator<K> {
        return new IteratorWrapper(_keys.iterator());
    }

    public function set(key:K, value:V):Void {
        var index = _keys.indexOf(key);

        if (index >= 0) {
            _values[index] = value;
        } else {
            _keys.push(key);
            _values.push(value);
        }
    }

    public function remove(key:K):Bool {
        var index = _keys.indexOf(key);

        if (index >= 0) {
            _keys.splice(index, 1);
            _values.splice(index, 1);
            return true;
        } else {
            return false;
        }
    }
}
