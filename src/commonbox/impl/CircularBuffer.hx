package commonbox.impl;

import commonbox.adt.IIterator;
import commonbox.adt.VariableSequence;
import commonbox.utils.SequenceUtil;
import haxe.ds.Vector;

using commonbox.utils.EquatableTools;


/**
    Circular buffer using an array.
**/
class CircularBuffer<T> implements BaseVariableSequence<T> {
    public var length(get, never):Int;
    public var bufferLength(get, never):Int;

    var buffer:Vector<T>;
    var maxSize:Int;
    var minSize:Int = 16;
    var bufferIndex:Int = 0;
    var logicalLength:Int = 0;

    public function new(?maxSize:Int) {
        this.maxSize = maxSize = maxSize != null ? maxSize : -1;

        Debug.assert(maxSize != null);

        if (maxSize >= 0) {
            buffer = new Vector(maxSize);
        } else {
            buffer = new Vector(minSize);
        }
    }

    function get_length():Int {
        return logicalLength;
    }

    function get_bufferLength():Int {
        return buffer.length;
    }

    inline function logicalIndexToBuffer(logicalIndex:Int):Int {
        return (bufferIndex + logicalIndex) % buffer.length;
    }

    public function iterator():IIterator<T> {
        return new CircularBufferIterator(this);
    }

    public function contains(item:T):Bool {
        for (logicalIndex in 0...logicalLength) {
            var bufferIndex = logicalIndexToBuffer(logicalIndex);

            if (item.equals(buffer[bufferIndex])) {
                return true;
            }
        }

        return false;
    }

    public function get(index:Int):T {
        index = SequenceUtil.normalizeIndex(this, index);

        return buffer[logicalIndexToBuffer(index)];
    }

    public function set(index:Int, item:T) {
        index = SequenceUtil.normalizeIndex(this, index);

        buffer[logicalIndexToBuffer(index)] = item;
    }

    public function insert(index:Int, item:T) {
        index = SequenceUtil.normalizeInsertIndex(this, index);

        checkIncreaseResize();

        if (index == logicalLength) {
            push(item);
        } else if (index == 0) {
            unshift(item);
        } else {
            rebuildWithInsert(index, item);
        }
    }

    public function removeAt(index:Int) {
        index = SequenceUtil.normalizeIndex(this, index);

        if (index == logicalLength - 1) {
            pop();
        } else if (index == 0) {
            shift();
        } else {
            rebuildWithRemove(index);
        }

        checkDecreaseResize();
    }

    function push(item:T) {
        buffer[logicalIndexToBuffer(logicalLength)] = item;

        logicalLength += 1;

        Debug.assert(logicalLength <= buffer.length);
    }

    function pop() {
        logicalLength -= 1;
        Debug.assert(logicalLength >= 0);
    }

    function unshift(item:T) {
        checkIncreaseResize();

        bufferIndex -= 1;
        logicalLength += 1;

        if (bufferIndex < 0) {
            bufferIndex = buffer.length - 1;
        }

        buffer[logicalIndexToBuffer(0)] = item;

        Debug.assert(logicalLength <= buffer.length);
    }

    function shift() {
        bufferIndex += 1;

        if (bufferIndex >= buffer.length) {
            bufferIndex = 0;
        }

        logicalLength -= 1;

        checkDecreaseResize();

        Debug.assert(logicalLength >= 0);
    }

    function checkIncreaseResize() {
        if (logicalLength == buffer.length && maxSize >= 0) {
            throw new Exception.FullException();
        }

        if (logicalLength == buffer.length) {
            resize(buffer.length * 2);
        }
    }

    function checkDecreaseResize() {
        if (maxSize >= 0 && buffer.length > minSize
                && logicalLength < Std.int(buffer.length / 4)) {
            resize(Std.int(Math.max(minSize, buffer.length / 2)));
        }
    }

    function resize(newLength:Int) {
        Debug.assert(newLength >= logicalLength);
        var newBuffer = new Vector<T>(newLength);

        for (index in 0...logicalLength) {
            newBuffer[index] = get(index);
        }

        buffer = newBuffer;
        bufferIndex = 0;
    }

    function rebuildWithInsert(itemIndex:Int, item:T) {
        var newBuffer = new Vector<T>(buffer.length);

        for (newBufferIndex in 0...logicalLength + 1) {
            if (newBufferIndex < itemIndex) {
                newBuffer.set(newBufferIndex, get(newBufferIndex));
            } else if (newBufferIndex == itemIndex) {
                newBuffer.set(newBufferIndex, item);
            } else {
                newBuffer.set(newBufferIndex, get(newBufferIndex - 1));
            }
        }

        buffer = newBuffer;
        bufferIndex = 0;
        logicalLength += 1;
        Debug.assert(logicalLength <= buffer.length);
    }

    function rebuildWithRemove(removeIndex:Int) {
        var newBuffer = new Vector<T>(buffer.length);

        for (newBufferIndex in 0...logicalLength - 1) {
            if (newBufferIndex < removeIndex) {
                newBuffer.set(newBufferIndex, get(newBufferIndex));
            } else {
                newBuffer.set(newBufferIndex, get(newBufferIndex + 1));
            }
        }

        buffer = newBuffer;
        bufferIndex = 0;
        logicalLength -= 1;
        Debug.assert(logicalLength >= 0);
    }
}


class CircularBufferIterator<T> implements IIterator<T> {
    var buffer:CircularBuffer<T>;
    var index:Int = 0;

    public function new(buffer:CircularBuffer<T>) {
        this.buffer = buffer;
    }

    public function hasNext():Bool {
        return index < buffer.length;
    }

    public function next():T {
        var item = buffer.get(index);
        index += 1;
        return item;
    }
}
