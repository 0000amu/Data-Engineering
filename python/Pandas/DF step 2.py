#data frames
import pandas as pd
#csv function that reads files
df = pd.read_csv("E:/py/datasets1/empdata.csv")
print(df)

#using loc[] and iloc[] view one colm data

w = df.loc[:,'ename']
print(w)

e = df.iloc[:,2]
print(e)

r = df.loc[:,['ename','doj']]#in list
print(r)

q = df.iloc[:,[1,3]]#in list
print(q)

o = df.loc[2:3, :] #both 2 3rd
print(o)

i = df.iloc[2:3,:] #only second row
print(i)

p = df.loc[0:3 , :]
print(p)

b = df.iloc[0:3,:]
print(b)

g = df.iloc[0:3, 0 ]
print(g)

f = df.loc[0:3,['ename','sal']]
print(f)
print(df.iloc[0:3,[0,2]])

#alternate colum

print(df.loc[[0,2,4],['empid','sal']])
print(df.iloc[[0,2,4],[0,2]])

#last rows not [possible with loc
print(df.iloc[-1])

print(df.iloc[: , -1])

print(df.loc[:,'doj'])
