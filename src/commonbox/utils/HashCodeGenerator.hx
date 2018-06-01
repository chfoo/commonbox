package commonbox.utils;

import commonbox.adt.Equatable;
import haxe.Int32;
import haxe.Int64;

/**
    Generates hash codes.

    A hash code is a uniformly distributed integer value derived from an
    immutable instance intended for use in optimizing data structures. This
    is typically used when the object does not have natural ordering.

    Hash codes are not unique and different objects can produce the same hash
    code. Hash codes are only guaranteed to remain the same within the same
    process. They are not to be used as unique identifiers and should not
    be shared outside the process.
**/
class HashCodeGenerator {
    // Use random seed to mitigate some worst case attacks
    // http://ocert.org/advisories/ocert-2011-003.html
    // random is only 31-bit so two calls required.
    static var hashCodeSeed = (Std.random(0xffff) << 16) | Std.random(0xffff);

    /**
        Returns a hash code for the given object.

        @param object Immutable instance: null, Bool, Int, Float, String,
            Equatable, Int64.
        @param seed: Optional previously generated hash code. This parameter
            is intended for computing a hash code of multiple objects.
    **/
    public static function getHashCode(object:Any, ?seed:Int):Int {
        // Recipe based on https://stackoverflow.com/a/113600/1524507
        var seed:Int32 = seed != null ? seed : hashCodeSeed;
        var objectHashCode:Int32;

        switch (Type.typeof(object)) {
            case Type.ValueType.TNull:
                objectHashCode = 0;

            case Type.ValueType.TBool:
                objectHashCode = (object:Bool) ? 0 : 1;

            case Type.ValueType.TInt:
                objectHashCode = (object:Int);

            case Type.ValueType.TFloat:
                objectHashCode = getStringHashCode(Std.string(object));

            default:
                objectHashCode = getObjectHashCode(object);
        }

        return (31:Int32) * seed + objectHashCode;
    }

    static function getObjectHashCode(object:Any):Int {
        if (Std.is(object, Equatable)) {
            return (object:Equatable).hashCode();

        } else if (Int64.is(object)) {
            var num:Int64 = object;
            return num.high ^ num.low;

        } else if (Std.is(object, String)) {
            return getStringHashCode(object);

        } else {
            throw new Exception("Mutable value");
        }
    }

    static function getStringHashCode(string:String):Int {
        var hashCode:Int32 = 3;

        for (index in 0...string.length) {
            hashCode = 31 * hashCode + string.charCodeAt(index);
        }

        return hashCode;
    }
}
