
# Python 3: Fibonacci series up to n


def fib(n):
    a, b = 1, 1
    while a < n:
         print(a,'(',b/a,')', end=' ')
         a, b = b, a+b
    print()
fib(1000000)
