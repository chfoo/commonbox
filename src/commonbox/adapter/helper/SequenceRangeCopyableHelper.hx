package commonbox.adapter.helper;

import commonbox.adt.Collection;
import commonbox.adt.Sequence;
import commonbox.utils.SequenceUtil;


class SequenceRangeCopyableHelper<T> {
    var sequence:BaseMutableSequence<T>;
    var sequenceFactory:Int->BaseMutableSequence<T>;

    public function new(
            sequence:BaseMutableSequence<T>,
            sequenceFactory:Int->BaseMutableSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;
    }

    public function slice(index:Int, ?endIndex:Int):BaseMutableSequence<T> {
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

        var target = sequenceFactory(length);

        for (targetIndex in 0...length) {
            target.set(targetIndex, sequence.get(index + targetIndex));
        }

        return target;
    }

    public function concat(other:Collection<T>):BaseMutableSequence<T> {
        var target = sequenceFactory(sequence.length + other.length);

        for (index in 0...sequence.length) {
            target.set(index, sequence.get(index));
        }

        var index = sequence.length;
        for (item in other) {
            target.set(index, item);
            index += 1;
        }

        return target;
    }
}


class VariableSequenceRangeCopyableHelper<T> {
    var sequence:BaseMutableSequence<T>;
    var sequenceFactory:Void->BaseMutableVariableSequence<T>;

    public function new(
            sequence:BaseMutableVariableSequence<T>,
            sequenceFactory:Void->BaseMutableVariableSequence<T>) {
        this.sequence = sequence;
        this.sequenceFactory = sequenceFactory;
    }

    public function slice(index:Int, ?endIndex:Int):BaseMutableVariableSequence<T> {
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

    public function concat(other:Collection<T>):BaseMutableVariableSequence<T> {
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
