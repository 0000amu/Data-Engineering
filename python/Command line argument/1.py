#to display command line args save this as cmd.py
import sys
n = len(sys.argv)
args = sys.argv
print('no of command line args=',n)
print('the args are:',args)
print('the args one by one :')
for a in args:
    print(a)

#open cmd then go to your path 
#cd C:\Users\Amey\PycharmProjects\PythonProject
#then check file existance by dir
#python Command_line_pracc.py Amey 24 Pune ,run 
no of command line args= 4
the args are: ['Command_line_pracc.py', 'Amey', '24', 'Pune']
the args one by one :
Command_line_pracc.py
Amey
24
Pune
