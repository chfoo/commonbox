package commonbox.adt;


/**
    Collection of non-repeating items.
**/
interface BaseSet<T> extends Collection<T> {
}


interface Set<T> extends BaseSet<T> extends Copyable<Set<T>> {
    /**
        Returns a set containing items in This, Other, or both.
    **/
    function union(other:Set<T>):Set<T>;

    /**
        Returns a set containing items in only both.
    **/
    function intersection(other:Set<T>):Set<T>;

    /**
        Returns a set containing items in only Other.
    **/
    function difference(other:Set<T>):Set<T>;

    /**
        Returns a set containing items in This" and Other, but not both.
    **/
    function symmetricDifference(other:Set<T>):Set<T>;

    /**
        Returns whether the set is empty.
    **/
    function isEmpty():Bool;

    /**
        Returns whether the sets do not have common items.
    **/
    function isDisjoint(other:Set<T>):Bool;

    /**
        Returns whether items in This are in Other.
    **/
    function isSubset(other:Set<T>):Bool;

    /**
        Returns whether items in This are in Other and This is not equal
        to Other.
    **/
    function isProperSubset(other:Set<T>):Bool;

    /**
        Returns whether items in Other are in This.
    **/
    function isSuperset(other:Set<T>):Bool;

    /**
        Returns whether items in Other are in This and This is not equal
        to Other.
    **/
    function isProperSuperset(other:Set<T>):Bool;

    /**
        Returns whether the set contains the same items in the given set.
    **/
    function contentEquals(other:Set<T>):Bool;
}


interface BaseMutableSet<T> extends BaseSet<T> {
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


interface MutableSet<T>
        extends Set<T>
        extends BaseMutableSet<T>
        extends Copyable<MutableSet<T>> {
    /**
        Removes all items from the set.
    **/
    function clear():Void;
}
