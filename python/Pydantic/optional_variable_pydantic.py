#optional variables

#working with default var
from pydantic import BaseModel
from typing import List, Dict, Optional

"""
#create base model cls
class Emp(BaseModel):
    name: str
    age: int
    salary:Optional[float]   #only optional but compulsary pass the data sal in instance info{}
    married:Optional[bool]=False #optional + default 
    qualification : Optional[List[str]]=["B.Tech"]
    contact : Optional[Dict[str, str]] = None

#3
def insert_data_emp(e: Emp):
    print(e.name)
    print(e.age)
    print(e.salary)
    print(e.married)
    print(e.qualification)
    print(e.contact)
    print("inserted into db")

#2 instance the class with data
info ={"name":"Amey","age":22}
e=Emp(**info)
insert_data_emp(e)
"""


#create base model cls
class Emp(BaseModel):
    name: str
    age: int = 22 #default val age = 22 need not call the var in obj,to overrite you can call
    age2: Optional[int] #optional variable *varname must be mentioned
    age3: Optional[int]=22 #default+ optional *no need to mentioned
#3
def insert_data_emp(e: Emp):
    print(e.name)
    print(e.age)


#2 instance the class with data
info ={"name":"Amey","age2": None}
e=Emp(**info)
insert_data_emp(e)

