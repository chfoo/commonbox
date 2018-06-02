package commonbox.impl.sorting;

import commonbox.adt.Sequence;


class SelectionSort {
    // https://en.wikipedia.org/wiki/Selection_sort
    public static function swapSort<T>(seq:BaseSequence<T>,
            comparer:T->T->Int) {
        if (seq.length <= 1) {
            return;
        }

        for (sortedIndex in 0...seq.length) {
            var smallestIndex = sortedIndex;
            var smallestItem = seq.get(sortedIndex);

            for (testIndex in sortedIndex...seq.length) {
                var testItem = seq.get(testIndex);

                if (comparer(testItem, smallestItem) < 0) {
                    smallestIndex = testIndex;
                    smallestItem = testItem;
                }
            }

            if (smallestIndex != sortedIndex) {
                var itemIndexA = sortedIndex;
                var itemA = seq.get(sortedIndex);
                var itemIndexB = smallestIndex;
                var itemB = smallestItem;

                seq.set(itemIndexA, itemB);
                seq.set(itemIndexB, itemA);
            }
        }
    }

    public static function listInsertSort<T>(seq:LinkedList<T>,
            comparer:T->T->Int) {
        if (seq.length <= 1) {
            return;
        }

        for (sortedIndex in 0...seq.length) {
            var sortedNode = seq.getNodeAt(sortedIndex);
            var smallestNode = sortedNode;

            var testNode = sortedNode;
            while (true) {
                if (comparer(testNode.item, smallestNode.item) < 0) {
                    smallestNode = testNode;
                }

                switch (testNode.next) {
                    case Some(nextNode):
                        testNode = nextNode;
                    case None:
                        break;
                }
            }

            if (smallestNode != sortedNode) {
                var item = smallestNode.item;

                sortedNode.insertBefore(item);
                smallestNode.remove();
            }
        }
    }
}
