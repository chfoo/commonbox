package commonbox.adt;

import haxe.ds.Option;


interface NodeSequence<T,N:Node<T,N>> {
    /**
        Returns the node at given position.
    **/
    function getNodeAt(index:Int):N;
}


interface Node<T,N:Node<T,N>> {
    var item(get, never):T;
    var next(get, never):Option<N>;
    var previous(get, never):Option<N>;
}


interface MutableNode<T,N:MutableNode<T,N>> extends Node<T,N> {
    /**
        Removes the node from the sequence.
    **/
    function remove():Void;

    /**
        Inserts the given item before this node.
    **/
    function insertBefore(item:T):Void;
}
