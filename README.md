CommonBox
=========

CommonBox is a unified collections interface to abstract data types and data structures for Haxe.

This library provides a consistent API to common data structures by separating them into 3 concerns: abstract data types, data structure interfaces, and data structure implementations. It allows flexibility for swapping between data structures and reuse of common idioms to collections.

The API is inspired by other containers and collections in other programming languages, such as Python, C#, Java, Scala, and Haskell.


Getting started
---------------

### Installation

Compatible with Haxe 3.

Install using haxelib:

        haxelib install commonbox


### Replacing standard Haxe data structures

#### Sequences

This section shows how to replace Haxe data structures that manipulate Sequences.

In CommonBox, the equivalent of standard `Array` is `ArrayList`. (The name is different to avoid conflicts.) You can easily convert between them.

```haxe
var array = [1, 2, 3];
var sequence = ArrayList.of(array);

sequence.push(4);
array = sequence.unwrap();
trace(sequence); // [1, 2, 3, 4]
```

The Haxe `Vector`, also named `Vector` in CommonBox, is a fixed length vector. This example shows how to copy the preceding `ArrayList` to `Vector`:

```haxe
var vector = Vector.fromCollection(sequence);
trace(vector); // [1, 2, 3, 4]
```

A Haxe `Vector` isn't iterable, but a CommonBox `Vector` is! In fact, both `ArrayList` and `Vector` implement the `Sequence` abstract data type. The following example contains a function that accepts a sequence of integers adds 1 to them:

```haxe
function addOne(sequence:Sequence<Int>) {
    for (index in 0...sequence.length) {
        sequence.set(index, sequence.get(index) + 1);
    }
}

var array = ArrayList.of([1, 2, 3]);
var vector = Vector.fromCollection(array);
var list = List.fromCollection(array);

addOne(array);
addOne(vector);
addOne(list);

trace(array); // [2, 3, 4]
trace(vector); // [2, 3, 4]
trace(list); // [2, 3, 4]
```

In the example above, you may have noticed `List`. That is another sequence data structure similar to the Haxe `List`. This is an example of why a unified interface can make collections much easier to use.


#### Mapings

This section shows how to replace Haxe data structures that manipulate Mappings.

In Haxe, `Map` is multitype abstract that morphs into an implementation that can handle the particular key type. In CommonBox, `AutoMap` is provided and works the same way:

```haxe
var map = new AutoMap<Int,String>();
map.set(100, "hello");
```

In the example above, `map` is a CommonBox `IntMap` which uses Haxe's `IntMap` as the underlying implementation.

To distinguish between a null value or a missing value, the `get()` method will return an enum value of `haxe.ds.Option`:

```haxe
switch (map.get(100)) {
    case Some(value):
        trace(value);
    case None:
        trace("No value");
}

trace(map.getOnly(100));
// trace(map.getOnly(200)); // NotFoundException
trace(map.getOrElse(200, "default value")); // "default value"
```

CommonBox also provides a CommonBox `HashMap` and `AnyMap`. A CommonBox `HashMap` is useful for keys that are a composite of data types. An example of using `HashMap` is in the next section.

`AnyMap`, however, is unique because it can use anything as its keys unlike a Haxe `ObjectMap` where only instances of classes may be used. The tradeoff is that its underlying implementation uses linear scanning of arrays, a detail which is covered in the complexity notes in the API documentation.


### Equality and comparison checking

By default, equality and comparison checking is done using the Haxe `==` operator and `Reflect.compare` method. This can be changed by implementing the interfaces `Equatable` and `Comparable<T>` on the objects.

The following example shows how to sort and use XY coordinates as items and keys.

First, we define our Coordinate data structure and implement the `Equatable` and `Comparable` interface.

```haxe
class Coordinate implements Equatable implements Comparable<Coordinate> {
    public var x:Float;
    public var y:Float;

    public function new(x:Float, y:Float) {
        this.x = x;
        this.y = y;
    }

    public function hashCode():Int {
        var hashCode = HashCodeGenerator.getHashCode(x);
        hashCode = HashCodeGenerator.getHashCode(y, hashCode);
        return hashCode;
    }

    public function equals(other:Any):Bool {
        if (other == null || !Std.is(other, Coordinate)) {
            return false;
        }

        var other:Coordinate = cast other;

        return x == other.x && y == other.y;
    }

    public function compareTo(other:Coordinate):Int {
        if (x == other.x) {
            return Reflect.compare(y, other.y);
        } else {
            return Reflect.compare(x, other.x);
        }
    }
}
```

Now define our array and we can sort various coordinates automatically:

```haxe
var points = ArrayList.of([
    new Coordinate(10, 5),
    new Coordinate(5, 5),
    new Coordinate(10, -10)
]);

points.sort();
trace(points); // {5, 5}, {10, -10}, {10, 5}
```

We can also use the data structure as a key in a mapping:

```haxe
var map = new HashMap<Coordinate,String>();
map.set(new Coordinate(3, 4), "point 1");

var label = map.get(new Coordinate(3, 4));
trace(label); // "point 1"
```

Data structure summary
----------------------

The following table describes appropriate uses for common data structures. For details on complexity, see the [API documentation](https://chfoo.github.io/commonbox/api/).

| ADT | Use case |
|-----|----------|
| Sequence | Ordered collection of items |
| Mapping | Collection of item pairs |
| Set | Collection of non-repeating items |


| Sequence Type | Strengths | Weakness |
| --------------|-----------|----------|
| ArrayList | Random access | Slow inserts |
| Vector | Fast random access | Fixed size |
| List | Fast add/insert/remove | Slow random access |
| Deque | Fast add/remove on first and last position | Slow random access and inserts |


| Mapping type | Summary |
|--------------|---------|
| AutoMap | Select the best map for the keys. Similar to Haxe Map |
| EnumValueMap | Same as Haxe EnumValueMap where keys comparison of Enums |
| IntMap | Same as Haxe IntMap where keys are Ints |
| ObjectMap | Same as Haxe ObjectMap where keys are instances of classes |
| StringMap | Same as Haxe StringMap where keys are compared by Strings |
| HashMap | Keys are instances of Equatable usually a composite of data types |
| AnyMap | Like ObjectMap, but any instance (such as functions) can be used as keys |


Development
-----------

### Running tests

To run tests, use the provided hxml for a target:

        haxe hxml/test.neko.hxml && neko out/neko/test.n
        haxe hxml/test.js.hxml && xdg-open file://$PWD/test.html
        haxe hxml/test.cpp.hxml && ./out/cpp/TestAll-debug

Or supply your own target and arguments:

        haxe test.hxml -python out/python/test.py && python3 out/python/test.py
