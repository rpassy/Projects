import numpy,math 
import scipy.optimize as optimization
from scipy import misc
import matplotlib.pyplot as plt

# Generate artificial data = straight line with a=0 and b=1
# plus some noise.
xdata = numpy.array([1000,1100,1200,1300,1400,1500,1600,1700,1800,1900])
ydata = numpy.array([16.2,11.0,8.3,5.8,4.8,5.1,6.4,8.9,11.5,15.7])
# Initial guess.
x0    = numpy.array([0.0, 0.0, 0.0, 0.0, 0.0])
sigma = numpy.array([1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0])


def func(x, a, b, c, d, e):
    return a + b*x + c*x*x + d/x + e/(x*x)


print(optimization.curve_fit(func, xdata, ydata, x0, sigma))
print(func)
N = 100
x = numpy.linspace(1000,2000,N)  
p,m = optimization.curve_fit(func, xdata, ydata, x0, sigma)
print(p)
a,b,c,d,e=p
y = a + b*x + c*x*x + d/x + e/(x*x)
z = b + 2*c*x - d/(x*x) - 2*e/(x*x*x)
plt.subplot(2, 1, 1)
plt.plot(xdata, ydata, 'ro')
plt.plot(x, y, 'g+')
plt.ylabel("Delay [ps]")
plt.legend(['Group Delay', 'Fit'])

plt.subplot(2, 1, 2)
plt.plot(x, z, 'b--')
plt.ylabel("Dispersion [ps/km*nm]")
plt.xlabel("Wavelength [nm]")
plt.legend(['Dispersion'])

plt.grid()
plt.draw()
plt.show()