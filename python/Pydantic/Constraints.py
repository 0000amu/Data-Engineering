#Applying constraints on var using field cls
from pydantic import BaseModel, Field
from typing import List

class Emp(BaseModel):
    name: str = Field(max_length=15)
    age: int = Field(ge=20, le=60)
    sal: float = Field(gt=30000.00)
    qualification: List[str] = Field(max_length=2)


def display(e: Emp):
    print(e.name)
    print(e.age)
    print(e.sal)
    print(e.qualification)


data = {
    "name": "AMey",
    "age": 21,
    "sal": 30001.00,
    "qualification": ["B.tech", "M.tech"]
}

e = Emp(**data)
display(e)

