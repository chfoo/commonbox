package commonbox.utils;

import commonbox.adt.Equatable;
import commonbox.utils.HashCodeGenerator;


/**
    Extensions for checking the equality of objects.
**/
class EquatableTools  {
    /**
        Returns a hash code for the object.

        The hash code will be zero if the object is immutable.
    **/
    public static function hashCode(object:Any):Int {
        try {
            return HashCodeGenerator.getHashCode(object);
        } catch (exception:Exception) {
            return 0;
        }
    }

    /**
        Returns whether the objects are equal.

        This will call `Equatable.equals` if possible. Otherwise, standard
        `==` operator is used.
    **/
    public static function equals(object:Any, other:Any):Bool {
        return getEquals(object, other);
    }

    static function getEquals(objectA:Any, objectB:Any):Bool {
        if (Std.is(objectA, Equatable)) {
            return (objectA:Equatable).equals(objectB);
        } else {
            return objectA == objectB;
        }
    }
}
