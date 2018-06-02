package commonbox.adt;

import haxe.ds.Option;


/**
    Sequence that can be have references to its items (nodes).
**/
interface NodeSequence<T,N:NodeSequenceRef<T,N>> {
    /**
        Returns the node at given position.
    **/
    function getNodeAt(index:Int):NodeSequenceRef<T,N>;
}


interface NodeSequenceRef<T,N:NodeSequenceRef<T,N>> extends ElementRef<T> {
    /**
        Next node in the sequence.
    **/
    var next(get, never):Option<N>;

    /**
        Previous node in the sequence.
    **/
    var previous(get, never):Option<N>;

    /**
        Removes the node from the sequence.

        This instance cannot be used after calling this method.
    **/
    function remove():Void;

    /**
        Inserts the given item before this node.
    **/
    function insertBefore(item:T):Void;
}
