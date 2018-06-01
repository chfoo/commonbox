package commonbox.adapter;

import commonbox.adapter.helper.SetHelper;
import commonbox.adt.IIterator;
import commonbox.adt.Set;
import commonbox.impl.MapSet;


/**
    Wraps `BaseMutableSet` object to implement `MutableSet`.
**/
class MutableSetUpgrade<T> implements MutableSet<T> {
    public var length(get, never):Int;

    var innerSet:BaseMutableSet<T>;
    var helper:MutableSetHelper<T>;
    var setFactory:Void->BaseMutableSet<T>;

    public function new(
            set:BaseMutableSet<T>,
            setFactory:Void->BaseMutableSet<T>) {
        this.innerSet = set;
        this.setFactory = setFactory;
        helper = new MutableSetHelper<T>(set, setFactory);
    }

    function get_length():Int {
        return innerSet.length;
    }

    public function iterator():IIterator<T> {
        return innerSet.iterator();
    }

    public function contains(item:T):Bool {
        return innerSet.contains(item);
    }

    public function add(item:T):Bool {
        return innerSet.add(item);
    }

    public function remove(item:T):Bool {
        return innerSet.remove(item);
    }

    public function union(other:Set<T>):MutableSet<T> {
        return new MutableSetUpgrade(helper.union(other), setFactory);
    }

    public function intersection(other:Set<T>):MutableSet<T> {
        return new MutableSetUpgrade(helper.intersection(other), setFactory);
    }

    public function difference(other:Set<T>):MutableSet<T> {
        return new MutableSetUpgrade(helper.difference(other), setFactory);
    }

    public function symmetricDifference(other:Set<T>):MutableSet<T> {
        return new MutableSetUpgrade(
            helper.symmetricDifference(other), setFactory);
    }

    public function isEmpty():Bool {
        return helper.isEmpty();
    }

    public function isDisjoint(other:Set<T>):Bool {
        return helper.isDisjoint(other);
    }

    public function isSubset(other:Set<T>):Bool {
        return helper.isSubset(other);
    }

    public function isProperSubset(other:Set<T>):Bool {
        return helper.isProperSubset(other);
    }

    public function isSuperset(other:Set<T>):Bool {
        return helper.isSuperset(other);
    }

    public function isProperSuperset(other:Set<T>):Bool {
        return helper.isProperSuperset(other);
    }

    public function clear() {
        return helper.clear();
    }

    public function contentEquals(other:Set<T>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():MutableSet<T> {
        var newSet = new MapSet<T>();

        for (item in innerSet) {
            newSet.add(item);
        }

        return new MutableSetUpgrade(newSet, setFactory);
    }

    public function toString() {
        return helper.toString();
    }
}
