package commonbox.impl;

import commonbox.adt.IIterator;
import commonbox.adt.VariableSequence;
import commonbox.adt.NodeSequence;
import commonbox.utils.EquatableTools;
import commonbox.utils.SequenceUtil;
import haxe.ds.Option;

using commonbox.utils.OptionTools;


/**
    Doubly linked list.
**/
class LinkedList<T>
        implements BaseVariableSequence<T>
        implements BaseNodeSequence<T> {
    public var length(get, never):Int;
    var _length = 0;

    var head:Option<Node<T>> = None;
    var tail:Option<Node<T>> = None;

    public function new() {
    }

    function get_length():Int {
        return _length;
    }

    public function contains(item:T):Bool {
        if ((head.isSome() && EquatableTools.equals(head.getSome().item, item))
        || (tail.isSome() && EquatableTools.equals(tail.getSome().item, item))) {
            return true;
        }

        return SequenceUtil.contains(this, item);
    }

    public function iterator():IIterator<T> {
        return new NodeIterator(head);
    }

    public function get(index:Int):T {
        return nodeAt(SequenceUtil.normalizeIndex(this, index)).item;
    }

    public function set(index:Int, item:T) {
        nodeAt(SequenceUtil.normalizeIndex(this, index)).item = item;
    }

    @:allow(commonbox.impl.LinkedListNode)
    function insertBefore(item:T, referenceNode:LinkedListNode<T>) {
        if (!referenceNode.owner.someEquals(this)) {
            throw new Exception("Node does not belong to list");
        }

        if (head.someEquals(referenceNode.node)) {
            prepend(item);
        } else {
            onlyInsertBefore(item, referenceNode.node);
        }
    }

    public function insert(index:Int, item:T) {
        var index = SequenceUtil.normalizeInsertIndex(this, index);

        if (_length == 0) {
            addToEmpty(item);
            return;
        } else if (index == _length) {
            append(item);
            return;
        } else if (index == 0) {
            prepend(item);
            return;
        }

        var nodeNext = nodeAt(index);
        onlyInsertBefore(item, nodeNext);
    }

    function addToEmpty(item:T) {
        Debug.assert(head.isNone());
        Debug.assert(tail.isNone());

        var newNode:Node<T> = {
            previous: None,
            next: None,
            item: item
        };

        head = tail = Some(newNode);
        _length = 1;
    }

    function append(item:T) {
        var tailNode = tail.getSome();
        var newNode:Node<T> = {
            previous: tail,
            next: None,
            item: item
        };

        Debug.assert(head.isSome());
        Debug.assert(tailNode.next.isNone());

        tailNode.next = Some(newNode);
        tail = Some(newNode);
        _length += 1;
    }

    function prepend(item:T) {
        var headNode = head.getSome();
        var newNode:Node<T> = {
            previous: None,
            next: head,
            item: item
        };

        Debug.assert(tail.isSome());
        Debug.assert(headNode.previous.isNone());

        headNode.previous = Some(newNode);
        head = Some(newNode);
        _length += 1;
    }

    function onlyInsertBefore(item:T, nodeNext:Node<T>) {
        Debug.assert(head.isSome());
        Debug.assert(tail.isSome());
        Debug.assert(_length >= 2);

        var nodePrevious = nodeNext.previous;
        Debug.assert(nodePrevious.isSome());

        var newNode:Node<T> = {
            previous: nodePrevious,
            next: Some(nodeNext),
            item: item
        };

        nodePrevious.getSome().next = Some(newNode);
        nodeNext.previous = Some(newNode);
        _length += 1;
    }

    public function removeAt(index:Int) {
        var node = nodeAt(SequenceUtil.normalizeIndex(this, index));

        _removeNode(node);
    }

    @:allow(commonbox.impl.LinkedListNode)
    function removeNode(node:LinkedListNode<T>) {
        if (!node.owner.someEquals(this)) {
            throw new Exception("Node does not belong to list");
        }

        _removeNode(node.node);
        node.owner = None;
    }

    function _removeNode(node:Node<T>) {
        var previousNode = node.previous;
        var nextNode = node.next;

        if (head.someEquals(node)) {
            Debug.assert(previousNode.isNone());
            head = nextNode;
        } else {
            Debug.assert(previousNode.isSome());
            previousNode.getSome().next = nextNode;
        }

        if (tail.someEquals(node)) {
            Debug.assert(nextNode.isNone());
            tail = previousNode;
        } else {
            Debug.assert(nextNode.isSome());
            nextNode.getSome().previous = previousNode;
        }

        node.previous = node.next = None;
        _length -= 1;

        Debug.assert(
            (_length == 0 && head.isNone() && tail.isNone())
            || (_length == 1 && head.getSome() == tail.getSome())
            || (_length > 1 && head.isSome() && tail.isSome()),
            '$_length $head $tail'
        );
    }

    public function getNodeAt(index:Int):LinkedListNode<T> {
        return new LinkedListNode(nodeAt(index), this);
    }

    function nodeAt(index:Int) {
        if (index <= Std.int(_length / 2)) {
            return nodeAtForward(index);
        } else {
            return nodeAtBackward(index);
        }
    }

    function nodeAtForward(index:Int):Node<T> {
        var currentIndex = 0;
        var currentNode = head.getSome();

        while (true) {
            if (currentIndex == index) {
                return currentNode;
            }

            switch (currentNode.next) {
                case Some(nextNode):
                    currentNode = nextNode;
                    currentIndex += 1;
                case None:
                    throw new Exception.OutOfBoundsException();
            }
        }

        throw "Shouldn't reach here";
    }

    function nodeAtBackward(index:Int):Node<T> {
        var currentIndex = _length - 1;
        var currentNode = tail.getSome();

        while (true) {
            if (currentIndex == index) {
                return currentNode;
            }

            switch (currentNode.previous) {
                case Some(previousNode):
                    currentNode = previousNode;
                    currentIndex -= 1;
                case None:
                    throw new Exception.OutOfBoundsException();
            }
        }

        throw "Shouldn't reach here";
    }
}


@:structInit
private class Node<T> {
    public var item:T;
    public var previous:Option<Node<T>>;
    public var next:Option<Node<T>>;
}


class LinkedListNode<T> implements NodeSequenceRef<T> {
    @:allow(commonbox.impl.LinkedList)
    var node(default, null):Node<T>;

    @:allow(commonbox.impl.LinkedList)
    var owner:Option<LinkedList<T>>;

    public var item(get, never):T;
    public var previous(get, never):Option<NodeSequenceRef<T>>;
    public var next(get, never):Option<NodeSequenceRef<T>>;

    public function new(node:Node<T>, owner:LinkedList<T>) {
        this.node = node;
        this.owner = Some(owner);
    }

    function get_item() {
        return node.item;
    }

    function get_previous():Option<NodeSequenceRef<T>> {
        switch (node.previous) {
            case Some(previousNode):
                var node_ = new LinkedListNode(previousNode, owner.getSome());
                return Some((node_:NodeSequenceRef<T>));
            case None:
                return None;
        }
    }

    function get_next():Option<NodeSequenceRef<T>> {
        switch (node.next) {
            case Some(nextNode):
                var node_= new LinkedListNode(nextNode, owner.getSome());
                return Some((node_:NodeSequenceRef<T>));
            case None:
                return None;
        }
    }

    public function remove() {
        owner.getSome().removeNode(this);
    }

    public function insertBefore(item:T) {
        owner.getSome().insertBefore(item, this);
    }

    public function replaceItem(item:T) {
        node.item = item;
    }
}


private class NodeIterator<T> implements IIterator<T> {
    var node:Option<Node<T>>;

    public function new(node:Option<Node<T>>) {
        this.node = node;
    }

    public function hasNext() {
        return node.isSome() && node.getSome().next != null;
    }

    public function next():T {
        var item = node.getSome().item;
        node = node.getSome().next;

        return item;
    }
}
