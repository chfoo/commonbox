package commonbox.impl.sorting;

import commonbox.adt.Sequence;
import commonbox.adt.NodeSequence;
import commonbox.adt.VariableSequence;
import commonbox.ds.List;
import commonbox.ds.Vector;

using commonbox.utils.OptionTools;


class MergeSort {
    // https://en.wikipedia.org/wiki/Merge_sort
    public static function sort<T>(seq:BaseSequence<T>, comparer:T->T->Int) {
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

    public static function listSort<T>(seq:NodeSequence<T>, comparer:T->T->Int) {
        if (seq.length <= 1) {
            return;
        }

        var newList = _listSort(seq, comparer);
        Debug.assert(seq.length == newList.length);

        var node = newList.getNodeAt(0);
        var newNode = newList.getNodeAt(0);

        while (true) {
            node.replaceItem(newNode.item);

            switch (node.next) {
                case Some(nextNode):
                    node = nextNode;
                case None:
                    break;
            }

            switch (newNode.next) {
                case Some(nextNode):
                    newNode = nextNode;
                case None:
                    break;
            }
        }
    }

    static function _listSort<T>(seq:NodeSequence<T>, comparer:T->T->Int)
            :NodeSequence<T> {
        if (seq.length <= 1) {
            return seq;
        }

        var left:NodeSequence<T> = new List<T>();
        var right:NodeSequence<T> = new List<T>();

        var i = 0;
        for (item in seq) {
            if (i < seq.length / 2) {
                left.push(item);
            } else {
                right.push(item);
            }

            i += 1;
        }

        left = _listSort(left, comparer);
        right = _listSort(right, comparer);

        return listMerge(left, right, comparer);
    }

    static function listMerge<T>(
            left:NodeSequence<T>,
            right:NodeSequence<T>,
            comparer:T->T->Int):List<T> {
        var result = new List<T>();

        while (!left.isEmpty() && !right.isEmpty()) {
            if (comparer(left.first(), right.first()) <= 0) {
                result.push(left.shift().getSome());
            } else {
                result.push(right.shift().getSome());
            }
        }

        while (!left.isEmpty()) {
            result.push(left.shift().getSome());
        }

        while (!right.isEmpty()) {
            result.push(right.shift().getSome());
        }

        return result;
    }
}
