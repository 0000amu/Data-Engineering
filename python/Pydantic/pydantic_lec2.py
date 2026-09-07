#dictionary unpacking\\
"""
def myfunc(**x):
    for k,v in x.items():
        print(k,v)

#pass a dictionary
dt ={"name":"amey","age":22,"city":"pune"}#dictionary thrn uonacked unpacking parameter
#key word argumanert sept2
myfunc(name = "amey" ,age,22,city ="pune")#pass data in form og kryworf sdrgumnets

#validate student rolwll no and ddate using pydantic



from pydantic import BaseModel
# step 1 create base model define data types and constrains
class Subjects(BaseModel):
    name: str
    roll_no: int

#step 3 pass the base model obj to function
def insert_student_info(s: Subjects):
    print("Student name is", s.name)
    print("Student roll_no is", s.roll_no)


    print("Inserted into DB")

#step 3 create the obj to pass in basemodel , pass the data to this obj
# passing the data in dictionary
info = {
    'name': "Amey",
    'roll_no': 22
}
#passing the data in another way : key words arguments
#

#pass the data
s=Subjects(**info)   #kand word s=Subject(name ="amey" ,roll_no =41 )

#step 4 call the function
insert_student_info(s)

from pydantic import BaseModel

# Step 1: Create BaseModel
class Subjects(BaseModel):
    name: str
    roll_no: int


# Step 2: Pass BaseModel object to function
class Myclass:
    def insert_student_info(self, s: Subjects):
        print("Student name is", s.name)
        print("Student roll_no is", s.roll_no)


# Step 3: Create Pydantic object
s = Subjects(name="amey", roll_no=41)

# Step 4: Create Myclass object
m = Myclass()

# Step 5: Call the correct method
m.insert_student_info(s)
"""

from pydantic import BaseModel


# Step 1: Pydantic BaseModel
class Subjects(BaseModel):
    name: str
    roll_no: int


# Step 2: Class with constructor
class Myclass:

    def __init__(self, college_name):
        self.college_name = college_name

    def insert_student_info(self, s: Subjects):
        print("College name is", self.college_name)
        print("Student name is", s.name)
        print("Student roll_no is", s.roll_no)


# Step 3: Create Pydantic object
s = Subjects(name="Amey", roll_no=41)


# Step 4: Create Myclass object
m = Myclass("DYP")


# Step 5: Call method
m.insert_student_info(s)

