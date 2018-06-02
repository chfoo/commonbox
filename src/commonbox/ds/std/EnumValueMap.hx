package commonbox.ds.std;

import commonbox.adapter.MapWrapper;
import commonbox.adapter.MappingUpgrade;
import commonbox.adt.Mapping;
import haxe.ds.EnumValueMap as StdEnumValueMap;


/**
    Mapping using standard `haxe.ds.EnumValueMap` as the implementation.
**/
class EnumValueMap<K:EnumValue,V>
        extends MappingUpgrade<K,V>
        implements Mapping<K,V>
        implements StandardDataStructureWrapper<StdEnumValueMap<K,V>> {
    var _stdDS:StdEnumValueMap<K,V>;

    public function new(?ds:StdEnumValueMap<K,V>) {
        _stdDS = ds != null ? ds : new StdEnumValueMap<K,V>();

        super(new MapWrapper(_stdDS), factory);
    }

    function factory() {
        return new MapWrapper(new StdEnumValueMap<K,V>());
    }

    public function unwrap() {
        return _stdDS;
    }
}
