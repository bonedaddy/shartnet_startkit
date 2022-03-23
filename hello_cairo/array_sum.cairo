# https://www.cairo-lang.org/docs/hello_cairo/intro.html#using-array-sum


%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

func array_sum(arr : felt*, size) -> (sum):
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
    let (sum_of_rest) = array_sum(arr=arr + 1, size=size - 1)
    return (sum=[arr] + sum_of_rest)
end



func main{output_ptr : felt*}():
    const ARRAY_SIZE = 3

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 9
    assert [ptr + 1] = 16
    assert [ptr + 2] = 25

    # Call array_sum to compute the sum of the elements.
    let (sum) = array_sum(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(sum)

    return ()
end