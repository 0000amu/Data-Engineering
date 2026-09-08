from typing import Annotated
"""
from pydantic import BaseModel
from pydantic import Stringint,Strictfloat,strictstr
from pydantic import Annatated

from Datetime_validation_pydantic import display
from demo import age


class Emp(BaseModel):
    name: str
    age : Strictint
    salary: StringFloat

def display(e:Emp):
    print(e.name,e.age,e.salary)


e = Emp(name ="amey",age=21,salary="30000?)


display(e)


# strict inside feild class annotation 
#Strict Validations inside Field class

from pydantic import BaseModel, Field
from typing import Annotated



class Emp(BaseModel):
    age: Annotated[int, Field(strict=True,ge=20, le=60, title='Enter Age',
                              description='Enter Age between 20 and 60'
                              ,examples=[20,25,56,59])]

    salary: Annotated[float, Field(strict=True,default=50000.57,description='Enter Salary of employee')]

def display(e: Emp):
    print(e.age)
    print(e.salary)

e = Emp(age = 20)
display(e)
"""



