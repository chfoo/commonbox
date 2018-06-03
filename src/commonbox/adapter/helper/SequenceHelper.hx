package commonbox.adapter.helper;

import commonbox.adapter.helper.immutable.SequenceHelper as ImmutableSequenceHelper;
import commonbox.adt.Sequence;
import commonbox.adt.NodeSequence;
import commonbox.impl.sorting.MergeSort;
import commonbox.impl.sorting.SelectionSort;
import commonbox.utils.Comparer;


class SequenceHelper<T,S:BaseSequence<T>>
        extends ImmutableSequenceHelper<T,S> {

    public function reverse() {
        for (indexA in 0...Std.int(sequence.length / 2)) {
            var indexB = sequence.length - 1 - indexA;
            var itemA = sequence.get(indexA);
            var itemB = sequence.get(indexB);

            sequence.set(indexA, itemB);
            sequence.set(indexB, itemA);
        }
    }

    public function sort(?comparer:T->T->Int) {
        if (comparer == null) {
            comparer = Comparer.compare.bind(_, _, null);
        }

        if (sequence.length <= 32) {
            if (Std.is(sequence, NodeSequence)) {
                SelectionSort.listInsertSort(cast sequence, comparer);
            } else {
                SelectionSort.swapSort(sequence, comparer);
            }
        } else {
            if (Std.is(sequence, NodeSequence)) {
                MergeSort.listSort(cast sequence, comparer);
            } else {
                MergeSort.sort(sequence, comparer);
            }
        }
    }
}
