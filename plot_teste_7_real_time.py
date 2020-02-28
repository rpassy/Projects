import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter,
                               AutoMinorLocator)
from numpy import sum
from scipy.fftpack import fft
from operator import add
fig, ax = plt.subplots()

# Number of sample points
N = 1024
# sample spacing
T = 1.0 / 1000.0

x = []
y = []
y_old = range(N)
xf = []
yf = []
ywf = []
ywe = []
fy_old = range(N)
fy_old = 100
def gera():
    for i in range(0,N):
        x.append(i*T)
        y.append(np.sin(10.0 * 2.0*np.pi*i*T) + 0.5*np.sin(80.0 * 2.0*np.pi*i*T) + 10*np.random.rand())
    return x,y


def gerafft():
    from scipy.signal import hamming
    yf = fft(y_old)
    w = np.kaiser(N,14)
    # w = np.blackman(N)
    # w = np.hamming(N)
    # w = np.hanning(N)
    # w = np.bartlett(N)
    yw = y_old*w
    ywf = fft(y_old*w)
    xf = np.linspace(0.0, np.floor(1.0/(2.0*T)), np.floor(N/2))
    even_index = [i for i in range(0,N,2)]
    ywe = yw[even_index]
    return xf,yf,ywf


gera()




plt.subplot(2, 1, 1)




for i in range(0,4):
    x = []
    y = []
    gera()
    y_old = [x * (i) for x in y_old]
    y_old = sum([y,y_old], axis=0)
    y_old = [x / (1+i) for x in y_old]

    xf = []
    yf = []
    xf,yf,ywf = gerafft()
    #fy_old = [x * (i) for x in fy_old]
    #fy_old = sum([yf,fy_old], axis=0)
    #fy_old = [x / (1+i) for x in fy_old]
    fy_old = np.minimum(abs(yf),abs(fy_old))


    plt.clf()
    plt.cla()  
   
    plt.subplot(2, 1, 1)
    axes = plt.gca()
    axes.set_xlim(0, 1)
    axes.set_ylim(0, 10)
    axes.spines['bottom'].set_color('green')
    axes.spines['top'].set_color('green') 
    axes.spines['right'].set_color('green')
    axes.spines['left'].set_color('green')
    fig.patch.set_facecolor('xkcd:black')
    axes.set_facecolor('xkcd:black')
    
    axes.tick_params(direction='in', which='major',length=5, width=0.5, colors='g',grid_color='g', grid_alpha=0.4)
    axes.tick_params(direction='in', which='minor',length=3, width=0.5, colors='g')
    axes.xaxis.set_minor_locator(AutoMinorLocator(5))
    axes.set_xlabel("x-label", color="red")
    plt.grid()
    
    plt.plot(x, y_old,color='blue',linewidth=0.5) 
    plt.subplot(2, 1, 2)
    axes2 = plt.gca()
    axes2.set_xlim(0, N/2)
    axes2.set_ylim(0.0001, 10)
    axes2.spines['bottom'].set_color('green')
    axes2.spines['top'].set_color('green') 
    axes2.spines['right'].set_color('green')
    axes2.spines['left'].set_color('green')
    axes2.set_facecolor('xkcd:black')
    plt.grid(b=True, which='both', axis='both',color='g', linestyle=':', linewidth=0.2)
    axes2.tick_params(direction='in', which='major',length=5, width=0.5, colors='g')
    axes2.tick_params(direction='in', which='minor',length=3, width=0.5, colors='g')
    axes2.xaxis.set_minor_locator(AutoMinorLocator(5))
    plt.semilogy(xf[1:N//2], 2.0/N * np.abs(yf[1:N//2]), '-r',linewidth=0.5)
    #plt.semilogy(xf[1:N//2], 2.0/N * np.abs(ywf[1:N//2]), color='black',linewidth=0.5)
    plt.semilogy(xf[1:N//2], 2.0/N * np.abs(fy_old[1:N//2]), color='green',linewidth=0.5)
    plt.draw()
    plt.pause(0.001)
    


    
# add this if you don't want the window to disappear at the end
plt.draw()
plt.show()
