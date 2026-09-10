
import argparse

parser = argparse.ArgumentParser(description='find power val of num')

parser.add_argument('nums',nargs='+')

args = parser.parse_args()

for x in args.nums:
    print(x)

===========================================================================================================


C:\Users\Amey\PycharmProjects\PythonProject>python Command_line_pracc.py 1 amey 99000.00
1
amey
99000.00

C:\Users\Amey\PycharmProjects\PythonProject>python Command_line_pracc.py -h
usage: Command_line_pracc.py [-h] nums [nums ...]

find power val of num

positional arguments:
  nums

options:
  -h, --help  show this help message and exit

C:\Users\Amey\PycharmProjects\PythonProject>
