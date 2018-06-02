package commonbox.adapter.helper;

import commonbox.adapter.helper.immutable.SetHelper as ImmutableSetHelper;
import commonbox.adt.Set;

using commonbox.utils.IteratorTools;


class SetHelper<T> extends ImmutableSetHelper<T> {
    var mutableSet:BaseSet<T>;

    public function new(
            set:BaseSet<T>, setFactory:Void->BaseSet<T>) {
        super(set, setFactory);
        this.set = set;
    }

    public function clear() {
        for (item in set.iterator().copy()) {
            mutableSet.remove(item);
        }
    }
}
