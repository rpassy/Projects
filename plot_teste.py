
# Python 3: Fibonacci series up to n

import matplotlib
import matplotlib.pyplot as plt

def fib(n):
    a, b ,x = 1, 1, 1
    c = []
    y = []
    while a < n:
         a, b = b, a+b
         c.append(b/a)
         x = x + 1
         y.append(x) 
    return y,c



y1,c1 = fib(10000000)
ax = plt.subplot()
ax.plot(y1, c1)

ax.set(xlabel='n ', ylabel='a/b', title='Fibonacci conversion')
ax.grid()

plt.show()
