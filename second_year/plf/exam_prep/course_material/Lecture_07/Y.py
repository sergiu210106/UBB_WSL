def fact(n):
    if n==0:
        return 1
    else:
        return n*fact(n-1)
print(fact(10))

















# exit()
fact = lambda n: 1 if n==0 else n*fact(n-1)
print(fact(10))
















# exit()
def fact_nr(f):
    def inner(n):
        if n==0:
            return 1
        else:
            return n*f(n-1)
    return inner

print('-', fact_nr(fact_nr)(0))
print('-', fact_nr(fact_nr(fact_nr))(1))
print('-', fact_nr(fact_nr(fact_nr(fact_nr)))(2))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))(3))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))(4))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))(5))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))))(6))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))))))(7))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))))))))(8))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))))))))))(9))
print('-', fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr(fact_nr))))))))))))))))))(10))







# exit()
def Y(f):
    def inner(c):
        def aux(x):
            return c(c)(x)
        return f(aux)
    return inner(inner)

fact = Y(fact_nr)

print(fact(10)) # 3828800





def fact_nr(f):
    return lambda n: 1 if n==0 else n*f(n-1)


# exit()
fact_nr = lambda f: lambda n: 1 if n==0 else n*f(n-1)

Y = lambda f: (lambda c: f(lambda x: c(c)(x)))(lambda c: f(lambda x: c(c)(x)))

fact = Y(fact_nr)

print(fact(10)) # 3828800











# exit()
print(
    (lambda f:
        (lambda c:
            f(lambda x: c(c)(x))
        )
        (lambda c:
            f(lambda x: c(c)(x))
        )
    )
    (lambda f:
        lambda n: 1 if n==0 else n*f(n-1)
    )
    (10)
    ) # 3828800


