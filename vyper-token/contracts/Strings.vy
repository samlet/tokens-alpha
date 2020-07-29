@external
@view
def foo(a: String[5], b: String[5], c: String[5]) -> String[100]:
    return concat(a, " ", b, " ", c, "!")

