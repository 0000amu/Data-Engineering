#parser is module in python is usefull to develop user friendly program using command line argument \
#parser module automatically generate help and usage message when user gives the program invalid argument

#parser pasing command line arguments

import argparse
#create parser argument clss
parser = argparse.ArgumentParser(description='this program display the square value')

# add one more argument with name num and type as integer
parser.add_argument("num",type=int, help="pls input integer type no")

#retrieve the argument passed to program
args = parser.parse_args()

#find squ num
result = args.num*2

print(result)

#cd C:\Users\Amey\PycharmProjects\PythonProject
#Command_line_pracc.py
#python Command_line_pracc.py 4
#output 16
