#data frames
import pandas as pd
#csv function that reads files
df = pd.read_csv("E:/py/datasets1/empdata.csv")
print(df)

print(df.shape)
#print('rows= ', r,'cls = ',c)

print(df.head())
print(df.head(3))
print(df.tail(3))
print(df.tail(2))
print(df[2:4][['ename','doj']])   #one more square bracket
print(df[:][['ename','doj']])


print(df['sal'].max())
print(df['sal'].min())
print(df['sal'].mean())
print(df['sal'].median())

print(df['sal'].sum())

print(df.describe())
