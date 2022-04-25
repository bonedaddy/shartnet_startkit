# https://www.cairo-lang.org/docs/hello_cairo/intro.html#using-array-sum


%builtins output range_check bitwise
from starkware.cairo.common.bitwise import bitwise_and
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
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


# used to check if the value `a` is even, returning `1` if even
# returning 0 if odd
func is_even{bitwise_ptr: BitwiseBuiltin*}(a) -> (is_value_even):
    let bitwised_felt: felt = bitwise_and(a, 1)
    if bitwised_felt == 0:
        return (is_value_even=1)
    else:
        return (is_value_even=0)
    end
end

func array_product{output_ptr: felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}(arr : felt*, size) -> (sum):
    if size == 0:
        # could optionally write as return (0)
        # however it is recommended to write as follows
        # since it increases readibility. this can be done
        # with function parameters as well
        return (sum=1)
    end
    let value_of_arr = [arr]
    # returns 0 if arr_div_two >  arr
    # which means arr is not a multiple of 2 
    let is_arr_even: felt = is_even(value_of_arr)
    if is_arr_even == 1:
        let (prod_of_rest) = array_product(arr=arr+1, size=size-1)
        return (sum=value_of_arr * prod_of_rest)
    else:
        # this just returns the result of the call to `array_product`
        # instead of multiplying the result by the value_of_arr
        let (prod_of_rest) = array_product(arr=arr+1, size=size-1)
        return (sum=prod_of_rest)
    end
end

# builtins need to be included in the order they were declaredi in
func main{output_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}():
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
    let (sum) = array_product(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(sum)

    return ()
end