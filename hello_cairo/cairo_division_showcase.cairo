%builtins output

# cairo does not support integer division when working with field elements
# aka felt* types. this means that as long as your numerator is a multiple of
# the denominator division will work as expected. 
# for more information see https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.math_utils import as_int

func modulus{range_check_ptr}(a, b) -> (value):
    let result = a / b
    # returns 0 if result >  left_hand
    # which means left_hand is not a numerator
    # of right_hand and therefore modulus returns 1
    let is_le_felt: felt = is_le(a, b)
    if is_le_felt ==  0:
        return (value=1)
    end
    let result2 = modulus(result, b)
    return (value=result2)
end


func main{output_ptr : felt*}():
    serialize_word(6 / 3)
    serialize_word(7 / 3)
    serialize_word(3 * (7 / 3))
    assert 7 = (3 * (7 / 3))
    return ()
end

