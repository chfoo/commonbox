package commonbox.adapter.helper;

import commonbox.adt.Mapping;
import commonbox.adapter.helper.immutable.MappingHelper as ImmutableMappingHelper;

using commonbox.utils.IteratorTools;


class MappingHelper<K,V> extends ImmutableMappingHelper<K,V> {
    var mutableMapping:BaseMapping<K,V>;

    public function new(mapping:BaseMapping<K,V>) {
        super(mapping);
        mutableMapping = mapping;
    }

    public function clear() {
        for (key in mapping.keys().copy()) {
            mutableMapping.remove(key);
        }
    }
}
