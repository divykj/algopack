from algopack.sort import (
    bubble,
    bucket,
    cocktail_shaker,
    comb,
    counting,
    gnome,
    heap,
    insertion,
    merge,
    pancake,
    quick,
    radix,
    selection,
    shell,
)

import pytest


def test_bubble():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        bubble([1000, 500, 100, 50, 10, 5, 1])


def test_bucket():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        bucket([1000, 500, 100, 50, 10, 5, 1])


def test_cocktail_shaker():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        cocktail_shaker([1000, 500, 100, 50, 10, 5, 1])


def test_comb():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        comb([1000, 500, 100, 50, 10, 5, 1])


def test_counting():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        counting([1000, 500, 100, 50, 10, 5, 1])


def test_gnome():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        gnome([1000, 500, 100, 50, 10, 5, 1])


def test_heap():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        heap([1000, 500, 100, 50, 10, 5, 1])


def test_insertion():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        insertion([1000, 500, 100, 50, 10, 5, 1])


def test_merge():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        merge([1000, 500, 100, 50, 10, 5, 1])


def test_pancake():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        pancake([1000, 500, 100, 50, 10, 5, 1])


def test_quick():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        quick([1000, 500, 100, 50, 10, 5, 1])


def test_radix():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        radix([1000, 500, 100, 50, 10, 5, 1])


def test_selection():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        selection([1000, 500, 100, 50, 10, 5, 1])


def test_shell():
    assert [1, 5, 10, 50, 100, 500, 1000] == \
        shell([1000, 500, 100, 50, 10, 5, 1])
