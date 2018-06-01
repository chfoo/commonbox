package commonbox.impl;

import commonbox.adt.IIterator;
import commonbox.adt.Set;
import commonbox.ds.AutoMap;


/**
    Set that uses a map as its implementation.
**/
class MapSet<T> implements BaseMutableSet<T> {
    public var length(get, never):Int;
    var _length = 0;
    var innerMap:AutoMap<T,Int>;

    public function new() {
        innerMap = new AutoMap();
    }

    function get_length():Int {
        return _length;
    }

    public function iterator():IIterator<T> {
        return innerMap.keys();
    }

    public function contains(item:T):Bool {
        return innerMap.containsKey(item);
    }

    public function add(item:T):Bool {
        if (!innerMap.containsKey(item)) {
            innerMap.set(item, 1);
            _length += 1;
            return true;
        } else {
            return false;
        }
    }

    public function remove(item:T):Bool {
        if (innerMap.containsKey(item)) {
            innerMap.remove(item);
            _length -= 1;
            return true;
        } else {
            return false;
        }
    }
}
