import pydantic
from pydantic.v1 import StrictInt




print(pydantic.__version__)
#python type validation is not strong

def insert_emp_data(name,age):
    print("my name is ",name)
    print("my age is ",age)
    print("Inserted into Db")
insert_emp_data("amey",22)

insert_emp_data("vedant",18)

#implement type validation manully

def insert_emp_data(name,age):
    if type(name)!=str:
        raise TypeError("name must be a string")
    else:
        print("my name is ",name)

    if type(age)!=int:
        raise TypeError("age must be an integer")
    else:
        print("my age is ",age)

print("Inserted into Db")

insert_emp_data("amey",22)
insert_emp_data(1888,"vedant")


def insert_emp_data(name,age):
    if type(name)!=str:
        raise TypeError("name must be a string")
    else:
        print("my name is ",name)

    if type(age)!=int:
        raise TypeError("age must be an integer")
    elif age>60 :
        raise TypeError("age must be less than 60")
    else:
        print("my age is ",age)


print("Inserted into Db")

insert_emp_data("amey",22)
insert_emp_data("vedant",61)
#type validation

# step 1=> define pydantic base model : ideal schema data type and
# constrains

from pydantic import BaseModel
class Employee(BaseModel):
    name: str
    age: StrictInt


# step 3 pass the validated model obj to func obj
def insert_emp_data(e: employee):
    print("my name is ",e.name)
    print("my age is ",e.age)
    print("Inserted into Db")


# step 2 create emp class object(base model obj) and pass data
info ={'name':"amey",'age':22}
e = Employee(**info)  # ** dictionary unpacking operator
print(e.name)
print(e.age)

from pydantic import BaseModel, StrictInt

class Employee(BaseModel):
    name: str
    age: StrictInt


# Step 3: pass the validated model object to function
def insert_emp_data(e: Employee):
    print("my name is", e.name)
    print("my age is", e.age)
    print("Inserted into DB")


# Step 2: create Employee object
info = {'name': "amey", 'age': 22}

e = Employee(**info)   # ** dictionary unpacking

print(e.name)
print(e.age)

# Pass object to function
insert_emp_data(e)
"""
from pydantic import BaseModel

class Employee(BaseModel):
    name=str
    age=StrictInt
  
def insert_data(e: Employee):
  print(e.name)
  print(e.age)
  
info = {'name': "amey", 'age': 22}

e =Employee(**info)

# Pass object to function
insert_emp_data(e)
