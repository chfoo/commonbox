package commonbox.utils;

import haxe.ds.Option;

/**
    Extensions to Haxe Option.
**/
class OptionTools {
    /**
        Returns whether the option is Some.
    **/
    public static function isSome<T>(option:Option<T>):Bool {
        switch (option) {
            case Some(t):
                return true;
            case None:
                return false;
        }
    }

    /**
        Returns whether the option is None.
    **/
    public static function isNone<T>(option:Option<T>):Bool {
        return !isSome(option);
    }

    /**
        Returns the value of Some or throws `InvalidStateException` if None.
    **/
    public static function getSome<T>(option:Option<T>):T {
         switch (option) {
            case Some(t):
                return t;
            case None:
                throw new Exception.InvalidStateException();
        }
    }

    /**
        Returns the value of Some or default if None.
    **/
    public static function getSomeOrElse<T>(option:Option<T>, defaultValue:T):T {
         switch (option) {
            case Some(t):
                return t;
            case None:
                return defaultValue;
        }
    }

    /**
        Returns whether is Some and its value equals the given value.
    **/
    public static function someEquals<T>(option:Option<T>, value:T):Bool {
         switch (option) {
            case Some(t):
                return t == value;
            case None:
                return false;
        }
    }
}
