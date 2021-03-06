
# Python 3: Fibonacci series up to n

import matplotlib
import matplotlib.pyplot as plt

def fib(n):
    a, b ,x = 1, 1, 1
    
    while a < n:
         print(x , b/a,"\n",end='')
         a, b = b, a+b
         c = b/a
         x = x + 1
    print()
    return x
    return c

fib(1000000)

fig, ax = plt.subplots()
ax.plot(x, fib(100))

ax.set(xlabel='n ', ylabel='a/b', title='Fibonacci conversion')
ax.grid()

ax.show()
