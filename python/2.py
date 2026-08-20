# 1. Create Person class and an object to it.

class person:
    def __init__(self):           #instance variable
        self.name = "amey"
        self.age = 22
        self.sex = "male"

    def return_name(self):
        return self.name,self.age,self.sex      #instance methode

obj = person()
print(obj.return_name())
# 2. Create Person class with parameterized constructor.
class person:
    def __init__(self,name,age,sex):
        self.name = name
        self.age = age
        self.sex = sex

    def talk(self):
        print('Hi, iam ', self.name)

        print('My age is ', self.age)
obj = person("Amey", 22, "male")
obj.talk()

#3. Create Student class with roll number, name and marks in 3 subjects. Display the total marks and
#percentage of marks. Use default constructor.



class student:
    def __init__(self):
        self.roll_number = 22
        self.name = "amey"
        self.marks = [90,90,95]

    def display(self):
        total = sum(self.marks)
        percentage = total/len(self.marks)
        print("total marks are:",total)
        print("percentage of marks are:" "%.1f%%"  % percentage)
obj = student()
obj.display()

# 4. Rewrite the above program with parameterized constructor.

class student:
    def __init__(self,roll_number,name,marks):
        self.roll_number = roll_number
        self.name = name
        self.marks = marks

    def display(self):
        total = sum(self.marks)
        percentage = total/len(self.marks)
        print("total marks are:",total)
        print("percentage of marks are:" "%.1f%%" % percentage)
obj = student(21,"amey",[70.80,90])
obj.display()
# 5. Demonstrate class variables and class methods.

class student:
        x = 10

        @classmethod
        def display(cls):
            cls.x += 1


obj = student()
obj.display()
print(obj.x)

6. Create getter and setter methods for a Manager class with name and salary instance variables.

class manager:
    def setname(self):
        self.name = "amey"

    def getname(self):
        return self.name

    def setsalary(self,salary):
        self.salary = salary

    def getsalary(self):
        return self.salary

    def display(self):
        return self.name,self.salary
obj = manager()
obj.setname()
obj.setsalary(99000)
obj.display()

print(obj.getname())
print(obj.getsalary())

7. Create a static method that counts the number of instances (objects) of a class.

class demo_static:
    n = 0
    def __init__(self):
        demo_static.n+=1
    @staticmethod
    def display():
        print('No. of instances created: ', demo_static.n)

obj = demo_static()
obj1 = demo_static()
obj2 = demo_static()
obj3 = demo_static()

demo_static.display()

#8. Create Dob inner class in Student outer class.
class student:
    def __init__(self):
        self.name = "amey"
    def display(self):
        print('Hi, iam ', self.name)
    class bob:
        def __init__(self):
            self.dd = 2
            self.mm = 10
            self.yy = 2004

        def display(self):
            print('My Date of Birth is {}/{}/{}'.format(self.dd,self.mm,self.yy))

s = student()
s.display()

b=student().bob()
b.display()
#9.  Using name mangling, access the private variable from outside of Bank class.
class bank:
    def __init__(self):
        self.account_no= 20932189371
        self.account_name= "amey gujjar"
        self.phone= 7227282929
        # self.loan=0
        self.__loan = 0.0

    def display(self):
        print('account_no=',self.account_no)
        print('account_name=',self.account_name)
        print('phone=',self.phone)


c = bank()
c.display()
print(c._bank__loan)





