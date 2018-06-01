package commonbox.adapter.helper;

import commonbox.adt.Set;

using commonbox.utils.IteratorTools;


class SetHelper<T> {
    var set:BaseSet<T>;
    var setFactory:Void->BaseMutableSet<T>;

    public function new(
            set:BaseSet<T>, setFactory:Void->BaseMutableSet<T>) {
        this.set = set;
        this.setFactory = setFactory;
    }

    public function contentEquals(other:Set<T>):Bool {
        if (set.length != other.length) {
            return false;
        }

        for (item in set) {
            if (!other.contains(item)) {
                return false;
            }
        }

        return true;
    }

    public function union(other:Set<T>):BaseMutableSet<T> {
        var newSet = setFactory();

        for (item in set) {
            newSet.add(item);
        }

        for (item in other) {
            newSet.add(item);
        }

        return newSet;
    }

    public function intersection(other:Set<T>):BaseMutableSet<T> {
        var newSet = setFactory();

        for (item in set) {
            if (other.contains(item)) {
                newSet.add(item);
            }
        }

        return newSet;
    }

    public function difference(other:Set<T>):BaseMutableSet<T> {
        var newSet = setFactory();

        for (item in set) {
            if (!other.contains(item)) {
                newSet.add(item);
            }
        }

        return newSet;
    }

    public function symmetricDifference(other:Set<T>):BaseMutableSet<T> {
        var newSet = setFactory();

        for (item in set) {
            if (!other.contains(item)) {
                newSet.add(item);
            }
        }

         for (item in other) {
            if (!set.contains(item)) {
                newSet.add(item);
            }
        }

        return newSet;
    }

    public function isEmpty():Bool {
        return set.length == 0;
    }

    public function isDisjoint(other:Set<T>):Bool {
        return intersection(other).length == 0;
    }

    public function isSubset(other:Set<T>):Bool {
        for (item in set) {
            if (!other.contains(item)) {
                return false;
            }
        }

        return true;
    }

    public function isProperSubset(other:Set<T>):Bool {
        for (item in set) {
            if (!other.contains(item)) {
                return false;
            }
        }

        if (set.length == other.length) {
            return false;
        }

        return true;
    }

    public function isSuperset(other:Set<T>):Bool {
        for (item in other) {
            if (!set.contains(item)) {
                return false;
            }
        }

        return true;
    }

    public function isProperSuperset(other:Set<T>):Bool {
        for (item in other) {
            if (!set.contains(item)) {
                return false;
            }
        }

        if (set.length == other.length) {
            return false;
        }

        return true;
    }

    public function toString():String {
        var buf = new StringBuf();
        buf.add("[Set:");

        var iterator = set.iterator();

        for (item in iterator) {
            buf.add(Std.string(item));

            if (iterator.hasNext()) {
                buf.add(", ");
            }
        }

        buf.add("]");

        return buf.toString();
    }
}


class MutableSetHelper<T> extends SetHelper<T> {
    var mutableSet:BaseMutableSet<T>;

    public function new(
            set:BaseMutableSet<T>, setFactory:Void->BaseMutableSet<T>) {
        super(set, setFactory);
        this.set = set;
    }

    public function clear() {
        for (item in set.iterator().copy()) {
            mutableSet.remove(item);
        }
    }
}
