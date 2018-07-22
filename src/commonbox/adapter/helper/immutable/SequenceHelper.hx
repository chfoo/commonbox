package commonbox.adapter.helper.immutable;

import commonbox.adt.immutable.Sequence;
import haxe.ds.Option;

using commonbox.utils.IteratorTools;
using commonbox.utils.EquatableTools;


class SequenceHelper<T,S:BaseSequence<T>> {
    var sequence:S;

    public function new(sequence:S) {
        this.sequence = sequence;
    }

    public function contentEquals(other:BaseSequence<T>):Bool {
        if (sequence.length != other.length) {
            return false;
        }

        for (index in 0...sequence.length) {
            var itemA = sequence.get(index);
            var itemB = other.get(index);

            if (!itemA.equals(itemB)) {
                return false;
            }
        }

        return true;
    }

    public function first():T {
        if (sequence.length > 0) {
            return sequence.get(0);
        } else {
            throw new Exception.OutOfBoundsException();
        }
    }

    public function firstOption():Option<T> {
        if (sequence.length > 0) {
            return Some(sequence.get(0));
        } else {
            return None;
        }
    }

    public function last():T {
        if (sequence.length > 0) {
            return sequence.get(sequence.length - 1);
        } else {
            throw new Exception.OutOfBoundsException();
        }
    }

    public function lastOption():Option<T> {
        if (sequence.length > 0) {
            return Some(sequence.get(sequence.length - 1));
        } else {
            return None;
        }
    }

    public function indexOf(item:T, ?fromIndex:Int):Option<Int> {
        return sequence.iterator().indexOf(item, fromIndex);
    }

    public function lastIndexOf(item:T, ?fromIndex:Int):Option<Int> {
        // We don't know if get() is O(1), so we just scan the entire list
        // instead searching by get()

        if (fromIndex == null) {
            fromIndex = sequence.length;
        }

        var index = 0;
        var foundIndex = -1;

        for (iterItem in sequence.iterator()) {
            if (item.equals(iterItem) && index <= fromIndex) {
                foundIndex = index;
            }

            index += 1;
        }

        if (foundIndex >= 0) {
            return Some(foundIndex);
        } else {
            return None;
        }
    }

    public function isEmpty():Bool {
        return sequence.length == 0;
    }

    public function toString():String {
        var buf = new StringBuf();
        buf.add("[Sequence:");

        var iterator = sequence.iterator();

        for (item in iterator) {
            buf.add(Std.string(item));

            if (iterator.hasNext()) {
                buf.add(", ");
            }
        }

        buf.add("]");

        return buf.toString();
    }
}
