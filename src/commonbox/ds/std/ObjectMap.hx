package commonbox.ds.std;

import commonbox.adapter.MapWrapper;
import commonbox.adapter.MutableMappingUpgrade;
import commonbox.adt.Mapping;
import haxe.ds.ObjectMap as StdObjectMap;


/**
    Mapping using standard `haxe.ds.ObjectMap` as the implementation.
**/
class ObjectMap<K:{},V> extends MutableMappingUpgrade<K,V>
        implements MutableMapping<K,V>
        implements StandardDataStructureWrapper<StdObjectMap<K,V>> {
    var _stdDS:StdObjectMap<K,V>;

    public function new(?ds:StdObjectMap<K,V>) {
        _stdDS = ds != null ? ds : new StdObjectMap<K,V>();

        super(new MapWrapper(_stdDS), factory);
    }

    function factory() {
        return new MapWrapper(new StdObjectMap<K,V>());
    }

    public function unwrap() {
        return _stdDS;
    }
}
