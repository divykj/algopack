# distutils: language = c++

from cpython.ref cimport Py_DECREF, Py_INCREF
from libcpp.stack cimport stack

ctypedef void* VoidPtr


cdef class Stack:
    cdef stack[VoidPtr] _stack
    
    def __cinit__(self):
        self._stack = stack[VoidPtr]()

    cpdef void push(self, object element):
        Py_INCREF(<object>element)
        self._stack.push(<void*>element)
    
    cpdef object pop(self):
        if self._stack.empty():
            raise IndexError("pop from empty stack")
        cdef object popped = <object>self._stack.top()
        self._stack.pop()
        Py_DECREF(<object>popped)
        return popped

    cpdef object top(self):
        if self._stack.empty():
            raise IndexError("empty stack")
        return <object>self._stack.top()

    cpdef bint isEmpty(self):
        return <bint>self._stack.empty()

    cpdef size_t size(self):
        return <size_t>self._stack.size()

    def __repr__(self):
        size = self.size()
        if size:
            return f"<Stack size={size} top={repr(self.top())}>"
        else: 
            return "<Stack empty>"
