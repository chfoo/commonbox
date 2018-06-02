package commonbox.ds;

import commonbox.adapter.VariableSequenceUpgrade;
import commonbox.adt.Collection;
import commonbox.adt.VariableSequence;
import commonbox.impl.CircularBuffer;


/**
    Sequence optimized for add/removing items at the beginning or end.

    | Operation | Computational complexity |
    | --------- | ------------------------ |
    | length | O(1) |
    | get/set | O(1) |
    | push/pop, unshift/shift | O(1)
    | insert/remove | O(n) |

    @param maxSize Optional maximum size of the collection. By default, the
        sequence is unbounded. If `maxSize` is given, any attempt to add
        more items will cause the method to throw `FullException`.
**/
class Deque<T>
        implements VariableSequence<T>
        extends VariableSequenceUpgrade<T> {
    var innerSequence:CircularBuffer<T>;

    public function new(?maxSize:Int) {
        innerSequence = new CircularBuffer(maxSize);
        super(innerSequence, factory);
    }

    /**
        Returns a new `Deque` from the given collection.
    **/
    public static function fromCollection<T>(other:Collection<T>):Deque<T> {
        var seq = new Deque<T>();

        for (item in other) {
            seq.push(item);
        }

        return seq;
    }

    function factory() {
        return new CircularBuffer<T>();
    }
}
