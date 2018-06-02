package commonbox.adapter.helper.immutable;

import commonbox.adt.immutable.Set;
import commonbox.adt.Set.BaseSet as MutableBaseSet;


class SetHelper<T> {
    var set:BaseSet<T>;
    var setFactory:Void->MutableBaseSet<T>;

    public function new(
            set:BaseSet<T>, setFactory:Void->MutableBaseSet<T>) {
        this.set = set;
        this.setFactory = setFactory;
    }

    public function contentEquals(other:BaseSet<T>):Bool {
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

    public function union(other:BaseSet<T>):MutableBaseSet<T> {
        var newSet = setFactory();

        for (item in set) {
            newSet.add(item);
        }

        for (item in other) {
            newSet.add(item);
        }

        return newSet;
    }

    public function intersection(other:BaseSet<T>):MutableBaseSet<T> {
        var newSet = setFactory();

        for (item in set) {
            if (other.contains(item)) {
                newSet.add(item);
            }
        }

        return newSet;
    }

    public function difference(other:BaseSet<T>):MutableBaseSet<T> {
        var newSet = setFactory();

        for (item in set) {
            if (!other.contains(item)) {
                newSet.add(item);
            }
        }

        return newSet;
    }

    public function symmetricDifference(other:BaseSet<T>):MutableBaseSet<T> {
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

    public function isDisjoint(other:BaseSet<T>):Bool {
        return intersection(other).length == 0;
    }

    public function isSubset(other:BaseSet<T>):Bool {
        for (item in set) {
            if (!other.contains(item)) {
                return false;
            }
        }

        return true;
    }

    public function isProperSubset(other:BaseSet<T>):Bool {
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

    public function isSuperset(other:BaseSet<T>):Bool {
        for (item in other) {
            if (!set.contains(item)) {
                return false;
            }
        }

        return true;
    }

    public function isProperSuperset(other:BaseSet<T>):Bool {
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
