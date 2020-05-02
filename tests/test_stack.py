from algopack.stack import (
    Stack,
    infix_to_postfix,
    infix_to_prefix,
    eval_postfix,
    eval_prefix,
)

import pytest
from pytest import approx


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


def test_infix_to_postfix():
    assert infix_to_postfix("A+B") == "AB+"
    assert infix_to_postfix("1-2") == "12-"
    assert infix_to_postfix("x*y") == "xy*"
    assert infix_to_postfix("a/2") == "a2/"
    assert infix_to_postfix("2^A") == "2A^"
    assert infix_to_postfix("") == ""
    assert infix_to_postfix("()") == ""
    assert infix_to_postfix("A+(B*C-(D/E^F)*G)*H") == "ABC*DEF^/G*-H*+"
    with pytest.raises(TypeError):
        infix_to_postfix([])
    with pytest.raises(TypeError):
        infix_to_postfix(None)
    with pytest.raises(TypeError):
        infix_to_postfix(123)


def test_infix_to_prefix():
    assert infix_to_prefix("A+B") == "+AB"
    assert infix_to_prefix("1-2") == "-12"
    assert infix_to_prefix("x*y") == "*xy"
    assert infix_to_prefix("a/2") == "/a2"
    assert infix_to_prefix("2^A") == "^2A"
    assert infix_to_prefix("") == ""
    assert infix_to_prefix("()") == ""
    assert infix_to_prefix("(A+B^C)*D+E^5") == "+*+A^BCD^E5"
    with pytest.raises(TypeError):
        infix_to_prefix([])
    with pytest.raises(TypeError):
        infix_to_prefix(None)
    with pytest.raises(TypeError):
        infix_to_prefix(123)


def test_eval_postfix():
    assert eval_postfix("12+") == approx(1 + 2)
    assert eval_postfix("12-") == approx(1 - 2)
    assert eval_postfix("12*") == approx(1 * 2)
    assert eval_postfix("12/") == approx(1 / 2)
    assert eval_postfix("32^") == approx(3 ** 2)
    assert eval_postfix("462/^") == approx(4 ** (6 / 2))
    assert eval_postfix("125+-") == approx(1 - (2 + 5))
    assert eval_postfix("945*345+^-/") == approx(9 / ((4 * 5) - (3 ** (4 + 5))))


def test_eval_prefix():
    assert eval_prefix("+12") == approx(1 + 2)
    assert eval_prefix("-12") == approx(1 - 2)
    assert eval_prefix("*12") == approx(1 * 2)
    assert eval_prefix("/12") == approx(1 / 2)
    assert eval_prefix("^32") == approx(3 ** 2)
    assert eval_prefix("/^462") == approx((4 ** 6) / 2)
    assert eval_prefix("-+125") == approx((1 + 2) - 5)
    assert eval_prefix("+^-/945*345") == approx((((9 / 4) - 5) ** (3 * 4)) + 5)
