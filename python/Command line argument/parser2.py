import argparse
parser = argparse.ArgumentParser(description='this program calculate sum of two numbers')

parser.add_argument('num1',type=float,help='first number')
parser.add_argument('num2',type=float,help='second number')

args = parser.parse_args()

result = args.num1 + args.num2
print(result)

=========================================================================================
C:\Users\Amey\PycharmProjects\PythonProject>python Command_line_pracc.py 2 4
6.0


C:\Users\Amey\PycharmProjects\PythonProject>[main 2026-09-10T08:05:06.956Z] update#setState checking for updates
[main 2026-09-10T08:05:10.526Z] update#setState idle
python Command_line_pracc.py 15.5 15
30.5
========================================================================================
C:\Users\Amey\PycharmProjects\PythonProject>python Command_line_pracc.py -h
usage: Command_line_pracc.py [-h] num1 num2

this program calculate sum of two numbers

positional arguments:
  num1        first number
  num2        second number

options:
  -h, --help  show this help message and exit
===========================================================================================
