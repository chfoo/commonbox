package commonbox;

/**
    Base class for exceptions thrown by this library.
**/
class Exception {
    /**
        Reason for the exception.
    **/
    public var message(default, null):String;

    public function new(message:String = "") {
        this.message = message;
    }

    public function toString():String {
        var name = Type.getClassName(Type.getClass(this));
        return '[$name: $message]';
    }
}


/**
    Thrown on attempt to access an array out of bounds.
**/
class OutOfBoundsException extends Exception {
}


/**
    Thrown when an item does not exist in the collection.
**/
class NotFoundException extends Exception {
}


/**
    Thrown when the state of an object is invalid for the operation.
**/
class InvalidStateException extends Exception {
}
