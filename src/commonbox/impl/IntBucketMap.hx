package commonbox.impl;

import commonbox.adt.Equatable;
import commonbox.adt.IIterator;
import commonbox.adt.Mapping;
import commonbox.utils.IteratorTools;
import haxe.ds.IntMap;
import haxe.ds.Option;


@:structInit
private class BucketItem<K:Equatable,V> {
    public var key:K;
    public var value:V;
}


private typedef BucketArray<K:Equatable,V> = Array<BucketItem<K,V>>;


/**
    Hash map using an IntMap to store its buckets.
**/
class IntBucketMap<K:Equatable,V> implements BaseMutableMapping<K,V> {
    public var length(get, never):Int;

    var _length = 0;
    var innerMap:IntMap<BucketArray<K,V>>;

    public function new() {
        innerMap = new IntMap();
    }

    function get_length():Int {
        return _length;
    }

    public function iterator():IIterator<V> {
        return new ValueIterator(innerMap);
    }

    public function contains(item:V):Bool {
        return IteratorTools.contains(iterator(), item);
    }

    public function containsKey(key:K):Bool {
        switch (get(key)) {
            case Some(bucketItem):
                return true;
            case None:
                return false;
        }
    }

    public function get(key:K):Option<V> {
        var hashCode = key.hashCode();

        if (innerMap.exists(hashCode)) {
            for (bucketItem in innerMap.get(hashCode)) {
                if (bucketItem.key.equals(key)) {
                    return Some(bucketItem.value);
                }
            }
        }

        return None;
    }

    public function keys():IIterator<K> {
        return new KeyIterator(innerMap);
    }

    public function set(key:K, value:V):Void {
        var hashCode = key.hashCode();

        var bucketArray;

        if (innerMap.exists(hashCode)) {
            bucketArray = innerMap.get(hashCode);
        } else {
            bucketArray = new BucketArray();
            innerMap.set(hashCode, bucketArray);
        }

        for (bucketItem in bucketArray) {
            if (bucketItem.key.equals(key)) {
                bucketItem.value = value;
                return;
            }
        }

        bucketArray.push({key: key, value: value});
        _length += 1;
    }

    public function remove(key:K):Bool {
        var hashCode = key.hashCode();

        if (!innerMap.exists(hashCode)) {
            return false;
        }

        var bucketArray = innerMap.get(hashCode);

        for (index in 0...bucketArray.length) {
            var bucketItem = bucketArray[index];

            if (bucketItem.key.equals(key)) {
                bucketArray.splice(index, 1);

                if (bucketArray.length == 0) {
                    innerMap.remove(hashCode);
                }

                _length -= 1;
                return true;
            }
        }

        return false;
    }
}


private class BaseIterator<K:Equatable,V> {
    var innerMap:IntMap<BucketArray<K,V>>;
    var keyIterator:Iterator<Int>;
    var bucketArrayIterator:Iterator<BucketItem<K,V>>;

    public function new(innerMap:IntMap<BucketArray<K,V>>) {
        this.innerMap = innerMap;
        keyIterator = innerMap.keys();
    }

    public function hasNext():Bool {
        if (bucketArrayIterator != null && bucketArrayIterator.hasNext()) {
            return true;
        }

        if (keyIterator.hasNext()) {
            return true;
        }

        return false;
    }

    function _next():BucketItem<K,V> {
        if (bucketArrayIterator == null) {
            var key = keyIterator.next();
            bucketArrayIterator = innerMap.get(key).iterator();
        }

        var item = bucketArrayIterator.next();

        if (!bucketArrayIterator.hasNext()) {
            bucketArrayIterator = null;
        }

        return item;
    }
}


private class ItemIterator<K:Equatable,V> extends BaseIterator<K,V>
        implements IIterator<BucketItem<K,V>> {
    public function next():BucketItem<K,V> {
        return _next();
    }
}


private class ValueIterator<K:Equatable,V> extends BaseIterator<K,V>
        implements IIterator<V> {
    public function next():V {
        return _next().value;
    }
}


private class KeyIterator<K:Equatable,V> extends BaseIterator<K,V>
        implements IIterator<K> {
    public function next():K {
        return _next().key;
    }
}
