# distutils: language = c++

from cpython.ref cimport PyObject
from libcpp.stack cimport stack

ctypedef PyObject* PyObjectPtr

cdef class Stack:
    cdef stack[PyObjectPtr] _stack
    
    def __cinit__(self):
        self._stack = stack[PyObjectPtr]()

    cpdef void push(self, object element):
        self._stack.push(<PyObjectPtr>element)
    
    cpdef object pop(self):
        if self._stack.empty():
            raise IndexError("pop from empty stack")
        cdef object popped = <object>self._stack.top()
        self._stack.pop()
        return popped

    cpdef object top(self):
        if self._stack.empty():
            raise IndexError("empty stack")
        return <object>self._stack.top()

    cpdef bint isEmpty(self):
        return self._stack.empty()

    cpdef size_t size(self):
        return self._stack.size()
