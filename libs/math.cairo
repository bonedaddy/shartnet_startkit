%builtins bitwise
from starkware.cairo.common.bitwise import bitwise_and
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin

# used to check if the value `a` is even, returning `1` if even
# returning 0 if odd
func is_even{bitwise_ptr: BitwiseBuiltin*}(a) -> (is_value_even):
    let bitwised_felt: felt = bitwise_ad(a, 1)
    if bitwised_felt == 0:
        return (is_value_even=1)
    else:
        return (is_value_even=0)
    end
end


    let is_arr_even: felt = is_even([arr])
    if is_arr_even == 1:
        let (prod_of_rest) = array_product(arr=arr+1, size=size-1)
        return (sum=[arr] * prod_of_rest)
    else:
        let (sum_of_rest) = array_product(arr=arr+1, size=size-1)
        #return (sum=[arr] + sum_of_rest)
        return (sum=sum_of_rest)
    end

        if is_le_felt == 0:
        # next value is odd
        let (sum_of_rest) = array_sum_equal(arr=arr+1, size=size-1)
        return (sum=sum_of_rest)
    else:
        # next value is even
        let (sum_of_rest) = array_sum_equal(arr=arr+1, size=size-1)
        return (sum=[arr] + sum_of_rest)
    end