#meta data

from pydantic import BaseModel,Field
from typing import Annotated

class Emp(BaseModel):
    name: Annotated[str,Field(max_length=15, title="enter name of employee", description="name should be less than 15 characters",
    examples = ["ashok","vijaykumar"])]

    age : Annotated[int,Field(ge=20,le=60,title="enter age",description="Age should be between 20 and 60",)]

    salary : Annotated[float , Field(title="enter salary",description="enter salary here",)]

def display(e: Emp):
    print(e.name)
    print(e.age)
    print(e.salary)
#display in fast api or python framework it will not displayed

data ={ 'name':"amey",
        'age':20,
        'salary':99000}

e = Emp(**data)

display(e)


#default value  data

from pydantic import BaseModel,Field
from typing import Annotated

class Emp(BaseModel):
    name: Annotated[str,Field(max_length=15, title="enter name of employee", description="name should be less than 15 characters",
    examples = ["ashok","vijaykumar"])]

    age : Annotated[int,Field(ge=20,le=60,default=(30),title="enter age",description="Age should be between 20 and 60",)]

    salary : Annotated[float , Field(default=30000.00, title="enter salary",description="enter salary here",)]]

def display(e: Emp):
    print(e.name)
    print(e.age)
    print(e.salary)
#display in fast api or python framework it will not displayed

data ={ 'name':"amey",
        'age':20,
        }

e = Emp(**data)

display(e)