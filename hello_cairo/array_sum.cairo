# https://www.cairo-lang.org/docs/hello_cairo/intro.html#using-array-sum


%builtins output range_check

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.math_cmp import is_le

func array_sum_two(arr : felt*, size) -> (sum):
    if size == 0:
        # could optionally write as return (0)
        # however it is recommended to write as follows
        # since it increases readibility. this can be done
        # with function parameters as well
        return (sum=0)
    end

    # size is not zero.

    # the way `arr` works is similar to pointers in C.
    # this means:
    #   `arr` is the first elemnt in the array
    #   `arr + 1` is the second element in the array

    # based on the above comment we can conclude that this recursively
    # calls `array_sum`, starting at the second element of the array
    # decrementing the provided size by 1
    # 
    # we could visualize multiple calls to this with an array of [0, 1, 2, 3, 4].
    # where `iteration 0` is the very first time `array_sum` is called
    # iteration 0: arr = [0, 1, 2, 3, 4], size = 5
    # iteration 1: arr = [1, 2, 3, 4] size = 4
    # iteration 2: arr = [2, 3, 4] size = 3
    # iteration 3: arr = [3, 4] size = 2
    # iteration 4: arr = [4] size = 1
    # iteration 5: return sum = 10
    let (sum_of_rest) = array_sum_two(arr=arr + 1, size=size - 1)
    return (sum=[arr] + sum_of_rest)
end

func array_sum_equal{output_ptr: felt*, range_check_ptr}(arr : felt*, size) -> (sum):
    if size == 0:
        # could optionally write as return (0)
        # however it is recommended to write as follows
        # since it increases readibility. this can be done
        # with function parameters as well
        return (sum=0)
    end

    let arr_div_two = [arr] / 2

    # returns 0 if arr_div_two >  arr
    # which means arr is not a multiple of 2 
    let is_le_felt: felt = is_le(arr_div_two, [arr])
    if is_le_felt == 0:
        # next value is odd
        let (sum_of_rest) = array_sum_equal(arr=arr+1, size=size-1)
        return (sum=sum_of_rest)
    else:
        # next value is even
        let (sum_of_rest) = array_sum_equal(arr=arr+1, size=size-1)
        return (sum=[arr] + sum_of_rest)
    end
end

# builtins need to be included in the order they were declaredi in
func main{output_ptr : felt*, range_check_ptr}():
    const ARRAY_SIZE = 5

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 2
    assert [ptr + 1] = 3
    assert [ptr + 2] = 4
    assert [ptr + 3] = 5
    assert [ptr + 4] = 6


    # Call array_sum to compute the sum of the elements.
    let (sum) = array_sum_equal(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(sum)

    return ()
end