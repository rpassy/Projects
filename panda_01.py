import pandas as pd  
import numpy as np  


d1 = pd.read_excel('servico1.xlsx') 
print(d1)
#print (d1.loc[:, ['COD', 'VALOR']])  

df = pd.DataFrame(d1, columns = ['COD','PLANO','VALOR'],)  
desc = d1["VALOR"].describe() 
print(desc)

input("Press Enter to continue...")