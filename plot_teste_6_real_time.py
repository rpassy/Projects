import matplotlib.pyplot as plt
import time
import random
 
N=100 
ysample = random.sample(range(-50, 50), N)
 
xdata = []
ydata = []

 
axes = plt.gca()
axes.set_xlim(0, 100)
axes.set_ylim(-50, +50)
line, = axes.plot(xdata, ydata)
 
for i in range(N):
    xdata.append(i)
    ydata.append(ysample[i])
    line.set_xdata(xdata)
    line.set_ydata(ydata)
    plt.pause(1e-17)
    time.sleep(0.0001)
    plt.plot(xdata, ydata,'b') 
    
# add this if you don't want the window to disappear at the end
plt.draw()
plt.show()