package commonbox.ds.std;

import commonbox.adapter.MapWrapper;
import commonbox.adapter.MappingUpgrade;
import commonbox.adt.Mapping;
import haxe.ds.IntMap as StdIntMap;


/**
    Mapping using standard `haxe.ds.IntMap` as the implementation.
**/
class IntMap<V> extends MappingUpgrade<Int,V>
        implements Mapping<Int,V>
        implements StandardDataStructureWrapper<StdIntMap<V>> {
    var _stdDS:StdIntMap<V>;

    public function new(?ds:StdIntMap<V>) {
        _stdDS = ds != null ? ds : new StdIntMap<V>();

        super(new MapWrapper(_stdDS), factory);
    }

    function factory() {
        return new MapWrapper(new StdIntMap<V>());
    }

    public function unwrap() {
        return _stdDS;
    }
}
