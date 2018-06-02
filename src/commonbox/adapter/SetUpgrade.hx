package commonbox.adapter;

import commonbox.adapter.helper.SetHelper;
import commonbox.adt.IIterator;
import commonbox.adt.Set;
import commonbox.adt.immutable.Set.BaseSet as ImmutableBaseSet;
import commonbox.impl.MapSet;


/**
    Wraps `BaseSet` object to implement `Set`.
**/
class SetUpgrade<T> implements Set<T> {
    public var length(get, never):Int;

    var innerSet:BaseSet<T>;
    var helper:SetHelper<T>;
    var setFactory:Void->BaseSet<T>;

    public function new(
            set:BaseSet<T>,
            setFactory:Void->BaseSet<T>) {
        this.innerSet = set;
        this.setFactory = setFactory;
        helper = new SetHelper<T>(set, setFactory);
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

    public function union(other:ImmutableBaseSet<T>):Set<T> {
        return new SetUpgrade(helper.union(other), setFactory);
    }

    public function intersection(other:ImmutableBaseSet<T>):Set<T> {
        return new SetUpgrade(helper.intersection(other), setFactory);
    }

    public function difference(other:ImmutableBaseSet<T>):Set<T> {
        return new SetUpgrade(helper.difference(other), setFactory);
    }

    public function symmetricDifference(other:ImmutableBaseSet<T>):Set<T> {
        return new SetUpgrade(
            helper.symmetricDifference(other), setFactory);
    }

    public function isEmpty():Bool {
        return helper.isEmpty();
    }

    public function isDisjoint(other:ImmutableBaseSet<T>):Bool {
        return helper.isDisjoint(other);
    }

    public function isSubset(other:ImmutableBaseSet<T>):Bool {
        return helper.isSubset(other);
    }

    public function isProperSubset(other:ImmutableBaseSet<T>):Bool {
        return helper.isProperSubset(other);
    }

    public function isSuperset(other:ImmutableBaseSet<T>):Bool {
        return helper.isSuperset(other);
    }

    public function isProperSuperset(other:ImmutableBaseSet<T>):Bool {
        return helper.isProperSuperset(other);
    }

    public function clear() {
        return helper.clear();
    }

    public function contentEquals(other:ImmutableBaseSet<T>):Bool {
        return helper.contentEquals(other);
    }

    public function copy():Set<T> {
        var newSet = new MapSet<T>();

        for (item in innerSet) {
            newSet.add(item);
        }

        return new SetUpgrade(newSet, setFactory);
    }

    public function toString() {
        return helper.toString();
    }
}
