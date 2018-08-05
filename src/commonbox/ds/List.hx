package commonbox.ds;

import commonbox.adapter.VariableSequenceUpgrade;
import commonbox.adt.Collection;
import commonbox.adt.NodeSequence;
import commonbox.adt.VariableSequence;
import commonbox.impl.LinkedList;


/**
    Variable length sequence optimized for insert & removal.


    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set, insert/remove | O(1) near the beginning and end of the sequence. O(n) otherwise. |
    | insertNode/removeNode | O(1) |
**/
class List<T>
        implements NodeSequence<T>
        extends VariableSequenceUpgrade<T> {
    var innerSequence:LinkedList<T>;

    /**
        Returns a new empty `List`.
    **/
    public function new() {
        innerSequence = new LinkedList();
        super(innerSequence, LinkedList.new);
    }

    /**
        Returns a new `List` from the given collection.
    **/
    public static function fromCollection<T>(other:Collection<T>):List<T> {
        var array = new List<T>();

        for (item in other) {
            array.push(item);
        }

        return array;
    }

    public function getNodeAt(index:Int):NodeSequenceRef<T> {
        return innerSequence.getNodeAt(index);
    }
}
