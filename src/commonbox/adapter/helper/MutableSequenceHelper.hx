package commonbox.adapter.helper;

import commonbox.adt.Sequence;
import commonbox.impl.LinkedList;
import commonbox.impl.sorting.MergeSort;
import commonbox.impl.sorting.SelectionSort;
import commonbox.utils.Comparer;


class MutableSequenceHelper<T,S:BaseMutableSequence<T>>
        extends SequenceHelper<T,S> {

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
            if (Std.is(sequence, LinkedList)) {
                SelectionSort.listInsertSort(cast sequence, comparer);
            } else {
                SelectionSort.swapSort(sequence, comparer);
            }
        } else {
            // TODO: linked list version
            MergeSort.sort(sequence, comparer);
        }
    }
}
