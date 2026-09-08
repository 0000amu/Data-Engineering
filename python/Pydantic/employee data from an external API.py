from pydantic import BaseModel,Field,field_validator
from pydantic import EmailStr
from typing import Annotated





class Employee(BaseModel):
    name:Annotated[str,Field(min_length=3,max_length=30,title="enter name",description="enter valid name no spaces")]
    age: Annotated[int ,Field(gt=18 ,le=60)]
    salary:Annotated[float , Field(gt=20000.00,le=200000.00)]
    email:EmailStr

    # BEFORE validator for name cleaning
    @field_validator('name',mode='before')
    @classmethod
    def validate_name(cls,value):
        value = value.strip()
        value = value.title()
        return value

    @field_validator('age',mode='before')
    @classmethod
    def validate_age(cls, value):
        if isinstance(value,str):
            value = value.strip()
            return int(value)

    @field_validator('salary',mode='before')
    @classmethod
    def validate_salary(cls, value):
        if isinstance(value,str):
            value = value.strip()
            return float(value)

    @field_validator('email',mode='before')
    @classmethod
    def validate_email(cls, value):
        if isinstance(value,str):
            value = value.strip()
            value = value.lower()
            return value

    # AFTER validator for business validation
    @field_validator('salary',mode='after')
    @classmethod
    def check_salary(cls, value):
        if value < 20000 or value > 200000:

            raise TypeError('Salary must be less than 200000 ')

        return value



def insert_emp(e: Employee):
    print(e.name)
    print(e.age)
    print(e.salary)
    print(e.email)

data = {
    "name": "  amey gujar ",
    "age": " 24 ",
    "salary": "55000",
    "email": "  AMEY@GMAIL.COM "
}

e =Employee(**data)
insert_emp(e)
