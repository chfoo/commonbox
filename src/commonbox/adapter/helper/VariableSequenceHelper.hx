package commonbox.adapter.helper;

import commonbox.adt.Collection;
import commonbox.adt.VariableSequence;
import commonbox.utils.SequenceUtil;
import haxe.ds.Option;

using commonbox.utils.EquatableTools;


class VariableSequenceHelper<T,S:BaseVariableSequence<T>>
        extends SequenceHelper<T,S> {

    var sequenceFactory:Void->BaseVariableSequence<T>;

    public function new(
            sequence:S,
            sequenceFactory:Void->BaseVariableSequence<T>) {
        super(sequence);
        this.sequenceFactory = sequenceFactory;
    }

    public function push(item:T) {
        sequence.insert(sequence.length, item);
    }

    public function pop():Option<T> {
        if (sequence.length > 0) {
            var item = sequence.get(sequence.length - 1);
            sequence.removeAt(sequence.length - 1);
            return Some(item);
        } else {
            return None;
        }
    }

    public function unshift(item:T) {
        sequence.insert(0, item);
    }

    public function shift():Option<T> {
        if (sequence.length > 0) {
            var item = sequence.get(0);
            sequence.removeAt(0);
            return Some(item);
        } else {
            return None;
        }
    }

    public function splice(index:Int, count:Int):BaseVariableSequence<T> {
        var index = SequenceUtil.normalizeInsertIndex(sequence, index);
        var target = sequenceFactory();

        if (count > sequence.length - index) {
            count = sequence.length - index;
        }

        for (loopCount in 0...count) {
            target.insert(target.length, sequence.get(index));
            sequence.removeAt(index);
        }

        return target;
    }

    public function unsplice(index:Int, other:Collection<T>) {
        var offset = 0;

        for (item in other) {
            sequence.insert(index + offset, item);
            offset += 1;
        }
    }

    public function extend(other:Collection<T>) {
        for (item in other) {
            push(item);
        }
    }

    public function remove(item:T):Bool {
        var index = 0;

        for (candidateItem in sequence) {
            if (item.equals(candidateItem)) {
                sequence.removeAt(index);
                return true;
            }

            index += 1;
        }

        return false;
    }

    public function clear() {
        while (sequence.length > 0) {
            sequence.removeAt(sequence.length - 1);
        }
    }

}
