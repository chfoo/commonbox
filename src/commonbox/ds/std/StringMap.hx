package commonbox.ds.std;

import commonbox.adapter.MapWrapper;
import commonbox.adapter.MutableMappingUpgrade;
import commonbox.adt.Mapping;
import haxe.ds.StringMap as StdStringMap;


/**
    Mapping using standard `haxe.ds.StringMap` as the implementation.
**/
class StringMap<V> extends MutableMappingUpgrade<String,V>
        implements MutableMapping<String,V>
        implements StandardDataStructureWrapper<StdStringMap<V>> {
    var _stdDS:StdStringMap<V>;

    public function new(?ds:StdStringMap<V>) {
        _stdDS = ds != null ? ds : new StdStringMap<V>();

        super(new MapWrapper(_stdDS), factory);
    }

    function factory() {
        return new MapWrapper(new StdStringMap<V>());
    }

    public function unwrap() {
        return _stdDS;
    }
}
