#working with default var
from pydantic import BaseModel
from typing import List, Dict

#create base model cls
class Emp(BaseModel):
    name: str
    age: int
    salary:float=45000
    married: bool=True
    education: bool=True
    qualification : List[str] =["B.Tech"]
    contact : Dict[str, str] = None

#3
def insert_data_emp(e: Emp):
    print(e.name)
    print(e.age)
    print(e.salary)
    print(e.married)
    print(e.education)
    print(e.qualification)
    print(e.contact)
    print("inserted into db")

#2 instance the class with data
info ={"name":"Amey","age":22}
e=Emp(**info)
insert_data_emp(e)

