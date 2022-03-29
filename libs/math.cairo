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