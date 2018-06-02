package commonbox.adt;

import commonbox.adt.immutable.Set as ImmutableSet;
import commonbox.adt.immutable.Set.BaseSet as ImmutableBaseSet;


interface BaseSet<T> extends ImmutableBaseSet<T> {
    /**
        Adds the given item to the set.

        Returns true if the item was already in the set.
    **/
    function add(item:T):Bool;

    /**
        Removes the item from the set.

        Returns true if the item was in the set.
    **/
    function remove(item:T):Bool;
}


interface Set<T>
        extends ImmutableSet<T, Set<T>>
        extends BaseSet<T>
        extends Copyable<Set<T>> {
    /**
        Removes all items from the set.
    **/
    function clear():Void;
}
