#TYPE VALIDATION

from pydantic import BaseModel
from datetime import date
from typing import List,Dict

# step 1 create base model define data types and constrains
from pydantic import BaseModel
from datetime import date
from typing import List, Dict


class Emp(BaseModel):
    name: str
    age: int
    doj: date
    married: bool
    qualification: List[str]
    contact: Dict[str, str]

def insert_data_emp(e:Emp):
    print(e.name)
    print(e.age)
    print(e.doj)
    print(e.qualification)
    print('phoneno:',e.contact["phoneno"])
    print('adr:',e.contact["adr"])
    print('email:',e.contact["email"])
    print(e.married)



info = {
    "name": "Amey",
    "age": 22,
    "doj": date(2026, 12, 23),
    "married": True,
    "qualification": ["btech CSE", "DATA ENGINEERING"],
    "contact": {
        "phoneno": "91+ 9876543210",
        "adr": "Kolhapur",
        "email": "xyz@gmail.com"
    }
}


e = Emp(**info)

print(e)

insert_data_emp(e)