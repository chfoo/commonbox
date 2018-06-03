package commonbox.adt;

import commonbox.adt.VariableSequence;
import haxe.ds.Option;


/**
    Sequence that can be have references to its items (nodes).
**/
interface BaseNodeSequence<T> extends BaseVariableSequence<T> {
    /**
        Returns the node at given position.
    **/
    function getNodeAt(index:Int):NodeSequenceRef<T>;
}


interface NodeSequence<T> extends BaseNodeSequence<T> extends VariableSequence<T> {
}


interface NodeSequenceRef<T> extends ElementRef<T> {
    /**
        Next node in the sequence.
    **/
    var next(get, never):Option<NodeSequenceRef<T>>;

    /**
        Previous node in the sequence.
    **/
    var previous(get, never):Option<NodeSequenceRef<T>>;

    /**
        Removes the node from the sequence.

        This instance cannot be used after calling this method.
    **/
    function remove():Void;

    /**
        Inserts the given item before this node.
    **/
    function insertBefore(item:T):Void;

    /**
        Replaces the current item with the given item.
    **/
    function replaceItem(item:T):Void;
}
