# Bubble Sort
cpdef list bubble(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int i = 0
        bint swapped = True
    
    while swapped:
        n -= 1
        i = 0
        swapped=False
        while i<n:
            if sorted_array[i]>sorted_array[i+1]:
                swapped = True
                sorted_array[i], sorted_array[i+1] = sorted_array[i+1], sorted_array[i]
            i+=1
    return sorted_array


# Bucket Sort
cpdef list bucket(list array):
    cdef:
        list sorted_array = []
        int n = <int>len(array)
        list buckets = [[] for _ in range(n)]
        float factor = n / (max(array) + 1)
        int i

    for value in array:
        buckets[int(value*factor)].append(value)

    i = 0
    while i<n:
        sorted_array.extend(merge(buckets[i]))
        i+=1

    return sorted_array


# Cocktail Shaker Sort
cpdef list cocktail_shaker(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int i = 0
        bint swapped = True
    
    while swapped:
        n -= 1
        swapped=False
        while i<n:
            if sorted_array[i]>sorted_array[i+1]:
                swapped = True
                sorted_array[i], sorted_array[i+1] = sorted_array[i+1], sorted_array[i]
            i+=1
        if not swapped:
            return sorted_array
        while i>0:
            if sorted_array[i]<sorted_array[i-1]:
                swapped = True
                sorted_array[i], sorted_array[i-1] = sorted_array[i-1], sorted_array[i]
            i-=1
    return sorted_array


# Comb Sort
cpdef list comb(array):
    cdef:
        int n = <int>len(array)
        float shrink = 1.3
        int gap = n
        list sorted_array = array[:]
        bint sorted = False
        int i = 0
        int sm
    
    while not sorted:
        gap = int(gap/shrink)
        if gap <= 1:
            sorted=True
            gap=1
        i = 0
        while (i + gap) < n:
            sm = gap+i
            if sorted_array[i] > sorted_array[sm]:
                sorted_array[i], sorted_array[sm] = sorted_array[sm], sorted_array[i]
                sorted = False
            i += 1
    return sorted_array


# Counting Sort
cpdef list counting(list array):
    """\
    Only for integers.
    """
    cdef:
        int n = <int>len(array)
        list sorted_array = [0]*n
        int max_el = <int>max(array)
        int min_el = <int>min(array)
        int count_size = max_el-min_el+1
        list counts = [0]*count_size
        int i = 0
        int curr_el
    
    while i<n:
        counts[array[i] - min_el] += 1
        i+=1
    
    i = 1
    while i<count_size:
        counts[i] += counts[i-1]
        i+=1
    
    i = 0
    while i<n:
        curr_el = array[i]-min_el
        sorted_array[counts[curr_el]-1] = array[i]
        counts[curr_el] -= 1
        i+=1
    
    return sorted_array


# Gnome Sort
cpdef list gnome(list array):
    cdef:
        int n = <int>len(array)
        int index = 0
        list sorted_array = array[:]
    while index<n:
        if index == 0 or sorted_array[index] >= sorted_array[index-1]:
            index = index + 1
        else:
            sorted_array[index], sorted_array[index-1] = sorted_array[index-1], sorted_array[index]
            index = index - 1
    return sorted_array


# Heap Sort
cpdef list heap(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int i = n-1

    while i>-1:
        _heapify(sorted_array, n, i)
        i-=1
    
    i = n-1
    while i>-1:
        sorted_array[i], sorted_array[0] = \
            sorted_array[0], sorted_array[i]
        _heapify(sorted_array, i, 0)
        i-=1
        
    return sorted_array

cdef void _heapify(list array, int end, int current):
    cdef:
        int largest = current
        int left = 2*current + 1
        int right = 2*current + 2

    if left < end and array[largest] < array[left]:
        largest = left
    if right < end and array[largest] < array[right]:
        largest = right

    if largest!=current:
        array[largest], array[current] = array[current], array[largest]
        _heapify(array, end, largest)


# Insertion Sort
cpdef list insertion(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int partition = 0
        int pointer
        current
    
    while partition<n:
        pointer = partition
        current = sorted_array[partition]
        while pointer>0 and sorted_array[pointer-1] > current:
            sorted_array[pointer] = sorted_array[pointer-1]
            pointer -= 1
        sorted_array[pointer] = current
        partition += 1

    return sorted_array


# Merge Sort
cpdef list merge(list array):
    cdef:
        int n = <int>len(array)

    if n<2: return array[:]

    cdef:
        int mid = n//2
        list sorted_left, sorted_right

    sorted_left, sorted_right = merge(array[:mid]), merge(array[mid:])
    
    return _mergeMerge(sorted_left, sorted_right)

cdef list _mergeMerge(list left, list right):
    cdef:
        int left_pointer = 0
        int right_pointer = 0
        int left_len = <int>len(left)
        int right_len = <int>len(right)
        list sorted_array = [None]*(left_len+right_len)

    while left_pointer < left_len and right_pointer < right_len:
        if left[left_pointer] <= right[right_pointer]:
            sorted_array[left_pointer+right_pointer]=left[left_pointer]
            left_pointer += 1
        else:
            sorted_array[left_pointer + right_pointer] = right[right_pointer]
            right_pointer += 1
    
    while left_pointer<left_len:
        sorted_array[left_pointer + right_pointer] = left[left_pointer]
        left_pointer+=1
    
    while right_pointer<right_len:
        sorted_array[left_pointer + right_pointer] = right[right_pointer]
        right_pointer+=1

    return sorted_array


# Pancake Sort
cpdef list pancake(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int max_index

    while n > 1:
        max_index = sorted_array.index(max(sorted_array[:n]))
        if max_index < n:
            if max_index != 0:
                sorted_array[:max_index+1] = sorted_array[:max_index+1][::-1]
            sorted_array[:n] = sorted_array[:n][::-1]
        n-=1
    return sorted_array


# Quick Sort
cpdef list quick(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
    return <list>_quickInner(sorted_array, 0, n-1)

cdef list _quickInner(list sorted_array, int start, int end):
    cdef: 
        int partition
    if start<end:
        partition = _getQuickPartition(sorted_array, start, end)
        _quickInner(sorted_array, start, partition-1)
        _quickInner(sorted_array, partition, end)
    return sorted_array

cdef int _getQuickPartition(sorted_array, start, end):
    cdef:
        int partition = start
        int pointer = start
    
    while pointer<end:
        if sorted_array[pointer] < sorted_array[end]:
            sorted_array[pointer], sorted_array[partition] = \
                sorted_array[partition], sorted_array[pointer]
            partition += 1
        pointer += 1
    sorted_array[pointer], sorted_array[partition] = \
        sorted_array[partition], sorted_array[pointer]
    return partition


# Radix Sort
cpdef list radix(list array):
    cdef:
        list sorted_array = array[:]
        int factor = 1
        int max_el = <int>max(array)
        int n = <int>len(array)
        int i = 0
        list sorted_digits

    while factor <= max_el:
        sorted_digits = [[] for _ in range(10)]

        i = 0
        while i<n:
            sorted_digits[sorted_array[i] // factor % 10].append(sorted_array[i])
            i += 1

        i = 0
        for numbers in sorted_digits:
            for el in numbers:
                sorted_array[i] = el
                i += 1
        
        factor *= 10
    return sorted_array


# Selection Sort
cpdef list selection(list array):
    cdef:
        list sorted_array = array[:]
        int n = <int>len(array)
        int i = 0
        int minimum, j

    while i < n:
        minimum = i
        j = i+1
        while j < n:
            if sorted_array[j] < sorted_array[minimum]:
                minimum = j
            j += 1
        sorted_array[minimum], sorted_array[i] = sorted_array[i], sorted_array[minimum]
        i+=1
    return sorted_array


# Shell Sort
cpdef list shell(list array):
    cdef:
        int n = <int>len(array)
        int gap = n//2
        list sorted_array = array[:]
        int x_index, y_index, y
    
    while gap > 0:
        y_index = gap
        while y_index < n:
            y = sorted_array[y_index]
            x_index = y_index - gap
            while x_index >= 0 and y < sorted_array[x_index]:
                sorted_array[x_index + gap] = sorted_array[x_index]
                x_index = x_index - gap
            sorted_array[x_index + gap] = y
            y_index = y_index + 1
        gap = gap//2
        
    return sorted_array