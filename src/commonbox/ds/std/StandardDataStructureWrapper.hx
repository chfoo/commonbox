package commonbox.ds.std;


/**
    Data structures that can expose the underlying Haxe standard data structure.
**/
interface StandardDataStructureWrapper<DS> {
    /**
        Returns the underlying data structure.

        Using this class after calling this method is undefined.
    **/
    function unwrap():DS;
}
