package commonbox.adapter.helper;

import commonbox.adt.Collection;
import commonbox.adt.Sequence;
import commonbox.utils.SequenceUtil;


class VariableSequenceRangeCopyableHelper<T> {
    var sequence:BaseSequence<T>;
    var sequenceFactory:Void->BaseVariableSequence<T>;

    public function new(
            sequence:BaseVariableSequence<T>,
            sequenceFactory:Void->BaseVariableSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;
    }

    public function slice(index:Int, ?endIndex:Int):BaseVariableSequence<T> {
        index = SequenceUtil.normalizeInsertIndex(sequence, index);

        if (endIndex == null) {
            endIndex = sequence.length;
        } else {
            SequenceUtil.normalizeInsertIndex(sequence, index);
        }

        var length = endIndex - index;

        if (length < 0) {
            length = 0;
        }

        var target = sequenceFactory();

        for (targetIndex in 0...length) {
            target.insert(targetIndex, sequence.get(index + targetIndex));
        }

        return target;
    }

    public function concat(other:Collection<T>):BaseVariableSequence<T> {
        var target = sequenceFactory();

        for (index in 0...sequence.length) {
            target.insert(index, sequence.get(index));
        }

        for (item in other) {
            target.insert(target.length, item);
        }

        return target;
    }
}
