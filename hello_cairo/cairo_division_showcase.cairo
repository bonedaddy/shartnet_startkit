%builtins output

# cairo does not support integer division when working with field elements
# aka felt* types. this means that as long as your numerator is a multiple of
# the denominator division will work as expected. 
# for more information see https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element

from starkware.cairo.common.serialize import serialize_word

func main{output_ptr : felt*}():
    serialize_word(6 / 3)
    serialize_word(7 / 3)
    serialize_word(3 * (7 / 3))
    assert 7 = (3 * (7 / 3))
    return ()
end