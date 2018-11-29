
# Python 3: Fibonacci series up to n

import matplotlib
import matplotlib.pyplot as plt

def fn():
    x=[1,2,3,4,5]
    y=[2,5,3,7,1]

    return x,y


print(fn())
x1,y1 = fn()


print(x1)
plot1 = plt.subplot()
plot1.plot(x1,y1)
plot1.set(xlabel='x', ylabel='y',
       title='About as simple as it gets, folks')
plot1.grid()
plt.show()


