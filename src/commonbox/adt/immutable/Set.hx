package commonbox.adt.immutable;


/**
    Collection of non-repeating items.
**/
interface BaseSet<T> extends Collection<T> {
}


interface Set<T,S:BaseSet<T>> extends BaseSet<T> extends Copyable<Set<T,S>> {
    /**
        Returns a set containing items in This, Other, or both.
    **/
    function union(other:BaseSet<T>):S;

    /**
        Returns a set containing items in only both.
    **/
    function intersection(other:BaseSet<T>):S;

    /**
        Returns a set containing items in only Other.
    **/
    function difference(other:BaseSet<T>):S;

    /**
        Returns a set containing items in This and Other, but not both.
    **/
    function symmetricDifference(other:BaseSet<T>):S;

    /**
        Returns whether the set is empty.
    **/
    function isEmpty():Bool;

    /**
        Returns whether the sets do not have common items.
    **/
    function isDisjoint(other:BaseSet<T>):Bool;

    /**
        Returns whether items in This are in Other.
    **/
    function isSubset(other:BaseSet<T>):Bool;

    /**
        Returns whether items in This are in Other and This is not equal
        to Other.
    **/
    function isProperSubset(other:BaseSet<T>):Bool;

    /**
        Returns whether items in Other are in This.
    **/
    function isSuperset(other:BaseSet<T>):Bool;

    /**
        Returns whether items in Other are in This and This is not equal
        to Other.
    **/
    function isProperSuperset(other:BaseSet<T>):Bool;

    /**
        Returns whether the set contains the same items in the given set.
    **/
    function contentEquals(other:BaseSet<T>):Bool;
}
