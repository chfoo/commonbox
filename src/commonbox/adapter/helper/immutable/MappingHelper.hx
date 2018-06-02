package commonbox.adapter.helper.immutable;

import commonbox.adt.immutable.Mapping;

using commonbox.utils.EquatableTools;


class MappingHelper<K,V> {
    var mapping:BaseMapping<K,V>;

    public function new(mapping:BaseMapping<K,V>) {
        this.mapping = mapping;
    }

    public function containsKey(key:K):Bool {
        switch (mapping.get(key)) {
            case None:
                return false;
            case Some(item):
                return true;
        }
    }

    public function getOrElse(key:K, ?defaultItem:V):V {
        switch (mapping.get(key)) {
            case None:
                return defaultItem;
            case Some(item):
                return item;
        }
    }

    public function getOnly(key:K, ?defaultItem:V):V {
        switch (mapping.get(key)) {
            case None:
                throw new Exception.NotFoundException();
            case Some(item):
                return item;
        }
    }

    public function isEmpty():Bool {
        return mapping.length == 0;
    }

    public function contentEquals(other:BaseMapping<K,V>):Bool {
        if (mapping.length != other.length) {
            return false;
        }

        for (keyA in mapping.keys()) {
            var valueA;
            var valueB;

            switch (mapping.get(keyA)) {
                case None:
                    return false;
                case Some(value):
                    valueA = value;
            }

            switch (other.get(keyA)) {
                case None:
                    return false;
                case Some(value):
                    valueB = value;
            }

            if (!valueA.equals(valueB)) {
                return false;
            }
        }

        return true;
    }

    public function toString():String {
        var buf = new StringBuf();
        buf.add("[Mapping:");

        var iterator = mapping.keys();

        for (key in iterator) {
            buf.add('$key => ${mapping.get(key)}');

            if (iterator.hasNext()) {
                buf.add(", ");
            }
        }

        buf.add("]");

        return buf.toString();
    }
}
