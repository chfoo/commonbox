package commonbox.impl.sorting;

import commonbox.adt.Sequence;
import commonbox.ds.Vector;
import commonbox.impl.LinkedList;


class MergeSort {
    // https://en.wikipedia.org/wiki/Merge_sort
    public static function sort<T>(seq:BaseSequence<T>,
            comparer:T->T->Int) {
        if (seq.length <= 1) {
            return;
        }

        var n = seq.length;
        var workArray = new Vector<T>(n);

        var width = 1;

        while (width < n) {
            var i = 0;

            while (i < n) {
                bottomUpMerge(
                    seq,
                    i,
                    Std.int(Math.min(i + width, n)),
                    Std.int(Math.min(i + 2 * width, n)),
                    workArray,
                    comparer
                );

                i += 2 * width;
            }

            for (index in 0...n) {
                seq.set(index, workArray.get(index));
            }

            width *= 2;
        }
    }

    static function bottomUpMerge<T>(
            seq:BaseSequence<T>,
            iLeft:Int,
            iRight:Int,
            iEnd:Int,
            workArray:BaseSequence<T>,
            comparer:T->T->Int) {
        var i = iLeft;
        var j = iRight;

        var k = iLeft;
        while (k < iEnd) {
            if (i < iRight
                    && (j >= iEnd || comparer(seq.get(i), seq.get(j)) <= 0)) {
                workArray.set(k, seq.get(i));
                i += 1;
            } else {
                workArray.set(k, seq.get(j));
                j += 1;
            }

            k += 1;
        }
    }
}
