# distutils: language = c++

from cpython.ref cimport Py_DECREF, Py_INCREF
from libcpp.stack cimport stack
from libc.stdlib cimport malloc, free

cdef extern from "ctype.h":
    int isalpha(int)
    int isdigit(int)

ctypedef void* VoidPtr

# C++ Stack Wrapper
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

# Infix To Postfix
cpdef str infix_to_postfix(str infix):
    cdef:
        bytes infix_bytes = (infix+")").encode()
        char* infix_string = infix_bytes
        stack[char] _stack = stack[char]()
        char* postfix_string
        bytes postfix
        char item
        char popped_item
        int n = len(infix_string)
        int i = 0
        int j = 0

    postfix_string = <char *>malloc(len(infix_string)*sizeof(char))
    if postfix_string==NULL:
        raise MemoryError()
    
    _stack.push(ord("("))

    while i<n:
        item = infix_string[i]
        if item==ord("("):
            _stack.push(item)
        elif isalpha(item) or isdigit(item):
            postfix_string[j] = item
            j+=1
        elif is_operator(item):
            popped_item = _stack.top()
            _stack.pop()
            while is_operator(popped_item) and precedence(popped_item)>=precedence(item):
                postfix_string[j] = popped_item
                j+=1
                popped_item = _stack.top()
                _stack.pop()
            _stack.push(popped_item)
            _stack.push(item)
        elif item==ord(")"):
            popped_item = _stack.top()
            _stack.pop()
            while popped_item!=ord("("):
                postfix_string[j] = popped_item
                j+=1
                popped_item = _stack.top()
                _stack.pop()
        i+=1
    postfix_string[j]=0
    postfix = bytes(postfix_string)
    free(postfix_string)
    return postfix.decode()

cdef int precedence(char symbol):
    if symbol == ord("^"):
        return 3
    elif symbol == ord("*") or symbol == ord("/"):
        return 2
    elif symbol == ord("+") or symbol == ord("-"):
        return 1
    else:
        return 0

cdef inline int is_operator(char symbol):
    return symbol == ord("^") or symbol == ord("*") or \
        symbol == ord("/") or symbol == ord("+") or symbol == ord("-")
