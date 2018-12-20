from scipy.fftpack import fft
import numpy as np
# Number of sample points
N = 4096
# sample spacing
T = 1.0 / 10000.0
x = np.linspace(0.0, N*T, N)
y = np.sin(100.0 * 2.0*np.pi*x) + 0.5*np.sin(180.0 * 2.0*np.pi*x) + 1*np.random.rand()
yf = fft(y)
from scipy.signal import blackman
w = np.kaiser(N,14)
# w = np.blackman(N)
# w = np.hamming(N)
# w = np.hanning(N)
# w = np.bartlett(N)
ywf = fft(y*w)
xf = np.linspace(0.0, np.floor(1.0/(2.0*T)), np.floor(N/2))
import matplotlib.pyplot as plt
plt.subplot(2, 1, 1)
plt.plot(x[1:N//10],y[1:N//10],color='black', linestyle='solid',linewidth=1)
plt.grid()

plt.subplot(2, 1, 2)
plt.semilogy(xf[1:N//2], 2.0/N * np.abs(yf[1:N//2]), '-b',linewidth=1)
plt.semilogy(xf[1:N//2], 2.0/N * np.abs(ywf[1:N//2]), '-r',linewidth=1)
plt.legend(['FFT', 'FFT w. window'])
plt.grid()

plt.show()
