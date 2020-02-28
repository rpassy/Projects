from scipy.fftpack import fft
import numpy as np
import matplotlib.pyplot as plt
import time
# Number of sample points
N = 1024
# sample spacing
T = 1.0 / 1000.0

x = []
y = []
xf = []
yf = []
ywf = []
ywe = []
fy_old = []

def gera():
    for i in range(0,N):
        x.append(i*T)
        y.append(np.sin(100.0 * 2.0*np.pi*i*T) + 0.5*np.sin(180.0 * 2.0*np.pi*i*T) + 0.5*np.random.rand())
    return x,y



def gerafft():
    from scipy.signal import hamming
    yf = fft(y)
    w = np.kaiser(N,14)
    # w = np.blackman(N)
    # w = np.hamming(N)
    # w = np.hanning(N)
    # w = np.bartlett(N)
    yw = y*w
    ywf = fft(y*w)
    xf = np.linspace(0.0, np.floor(1.0/(2.0*T)), np.floor(N/2))
    even_index = [i for i in range(0,N,2)]
    ywe = yw[even_index]
    return xf,yf,ywf


gera()
xf,yf,ywf = gerafft()
print(len(xf))
print(len(yf))


plt.subplot(2, 1, 1)
plt.plot(x[1:N//1],y[1:N//1],color='black', linestyle='solid',linewidth=1)
# plt.plot(x[1:N//1],yw[1:N//1],color='red', linestyle='solid',linewidth=1)
plt.grid()
plt.subplot(2, 1, 2)
plt.semilogy(xf[1:N//2], 2.0/N * np.abs(yf[1:N//2]), '-b',linewidth=1)
plt.semilogy(xf[1:N//2], 2.0/N * np.abs(ywf[1:N//2]), '-r',linewidth=1)
plt.legend(['FFT', 'FFT w. window'])
plt.grid()
plt.draw()

plt.show()
    

