from tkinter import *
from tkinter import scrolledtext

window = Tk()
window.title("Welcome to LikeGeeks app")
window.geometry('350x350')
txt = scrolledtext.ScrolledText(window,width=40,height=10)
txt.grid(column=0,row=0)

selected = IntVar()
rad1 = Radiobutton(window,text='First', value=1, variable=selected)
rad2 = Radiobutton(window,text='Second', value=2, variable=selected)
rad3 = Radiobutton(window,text='Third', value=3, variable=selected)

def clicked():
   print(selected.get(),txt.get('1.0', END))
   Label(window, text=txt.get('1.0', END),justify=LEFT,font=('arial', 24, 'normal'), fg="dark green").grid(column=0, row=6, rowspan=5, sticky=W)
   
btn = Button(window, text="Click", command=clicked)
rad1.grid(column=0, row=1, sticky=W)
rad2.grid(column=0, row=2, sticky=W)
rad3.grid(column=0, row=3, sticky=W)
btn.grid(column=0, row=4, sticky=W)

window.mainloop()
