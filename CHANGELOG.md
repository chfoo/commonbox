Change Log
==========

0.4.0 2018-08-05
----------------

* Fixed `fromIndex` parameter not respected in `Sequence.indexOf`.
* Added `Sequence.lastIndexOf`.
* Added `CollectionTools` having `join()`.


0.3.0 (2018-07-02)
------------------

* Added `shrinkable` parameter to `CircularBuffer`.
* Changed `Deque` specified behavior to always dynamically resize.


0.2.0 (2018-06-19)
------------------

* Fixed Deque/CircularBuffer modulus/division by zero on PHP target.
* Fixed compatibility with Java and C# target.
* Changed ADT interfaces to use explicit covariant return types instead of relying on interface inheritance with variant generic parameters.
* Changed `Exception` to inherit `haxe.Exception` from the "exception" package.
* Removed `Copyable` interface.


0.1.1 (2018-06-11)
------------------

* Fixed `Set.clear()`.
* Fixed `Set.difference()`.


0.1.0 (2018-06-03)
------------------

First release.
