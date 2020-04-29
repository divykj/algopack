from algopack.stack import Stack

import pytest


def test_stack_push():
    s = Stack()
    s.push(0)
    s.push("0")
    s.push(False)
    s.push(None)


def test_stack_pop():
    s = Stack()
    with pytest.raises(IndexError):
        s.pop()
    s.push(1)
    assert s.pop() == 1
    s.push("abc")
    assert s.pop() == "abc"
    with pytest.raises(IndexError):
        s.pop()


def test_stack_top():
    s = Stack()
    with pytest.raises(IndexError):
        s.top()
    s.push(1)
    assert s.top() == 1
    s.push("abc")
    assert s.top() == "abc"
    s.pop()
    s.pop()
    with pytest.raises(IndexError):
        s.top()


def test_stack_empty():
    s = Stack()
    assert s.isEmpty()
    s.push(1)
    assert not s.isEmpty()
    s.pop()
    assert s.isEmpty()


def test_stack_size():
    s = Stack()
    assert s.size() == 0
    s.push(1)
    assert s.size() == 1
    s.push(10)
    assert s.size() == 2
    s.pop()
    assert s.size() == 1
    s.pop()
    assert s.size() == 0
