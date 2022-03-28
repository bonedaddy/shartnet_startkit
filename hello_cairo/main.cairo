# instructs the compiler that we will use the "output" builtin
# for more information on builtins see https://www.cairo-lang.org/docs/how_cairo_works/builtins.html#builtins


# the output builtin is how cairo is connected to the outside word
# note that once you declare htis builtin, the syntax of the main function
# changed to `main{output_ptr: felt*}`
#
# the syntax `{output_ptr: felt*}` declares an implicit argument whic
# adds both an argument, and return value.
#
# for information on implicit arguments see
%builtins output

from starkware.cairo.common.serialize import serialize_word

func main{output_ptr: felt*}():
    serialize_word(420)
    serialize_word(69)
    return ()
end