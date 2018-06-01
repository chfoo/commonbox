package commonbox.adt;


/**
    Object supporting value equality.

    This is different than reference equality. Two objects having the same
    value equality can be different instances.
**/
interface Equatable {
    /**
        Returns a uniformly distributed integer derived from this object.

        For details, see `HashCodeGenerator`.
    **/
    function hashCode():Int;

    /**
        Returns whether this object compares equal to another by value.
    **/
    function equals(other:Any):Bool;
}
