import random
import matplotlib
import tkinter as Tk
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

fig, ax = plt.subplots()
plt.subplots_adjust(left= 0.5, bottom=0.5)

y_values = [random.randrange(0, 40, 1) for _ in range(40)]
x_values = [i for i in range(40)]

l, = plt.plot(x_values, y_values)
plt.axis([0, 10, 0, 40])





#plt.show()

matplotlib.use('TkAgg')

root = Tk.Tk()
root.wm_title("Embedding in TK")

canvas = FigureCanvasTkAgg(fig, master=root)
#canvas.show()
canvas.get_tk_widget().pack(side=Tk.TOP, fill=Tk.BOTH, expand=1)

Tk.mainloop()
