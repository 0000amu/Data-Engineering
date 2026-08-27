#data frames
import pandas as pd
#csv function that reads files
df = pd.read_csv("E:/py/datasets1/empdata.csv")
print(df)

df = pd.read_excel('E:/py/datasets1/empdata.xlsx',"Sheet1")
print(df)

df = pd.read_table('E:/py/datasets1/textdata.txt',
                   names =('A','B','C','person'),sep='\s+'                   )
print(df)

# python dictionary

empdata = {"empid": [1001, 1002, 1003, 1004, 1005, 1006],
"ename": ["Ganesh Rao", "Anil Kumar", "Gaurav Gupta", "Hema Chandra", "Laxmi Prasanna", "Anant Nag"],
"sal": [10000, 23000.50, 18000.33, 16500.50, 12000.75, 9999.99],
"doj": ["10-10-2000", "3-20-2002", "3-3-2002", "9-10-2000", "10-8-2000", "9-9-1999"]}

df = pd.DataFrame(empdata)
print(df)


# python list of tuples

empdata = [(1001, 'Ganesh Rao', 10000.00, '10-10-2000'),
(1002, 'Anil Kumar', 23000.50, '3-20-2002'),
(1003, 'Gaurav Gupta', 18000.33, '03-03-2002'),
(1004, 'Hema Chandra', 16500.50, '10-09-2000'),
(1005, 'Laxmi Prasanna', 12000.75, '08-10-2000'),
(1006, 'Anant Nag', 9999.99, '09-09-1999')]

df = pd.DataFrame(empdata,
                  columns =['empid','ename','sal','doj']
                  )
print(df)

