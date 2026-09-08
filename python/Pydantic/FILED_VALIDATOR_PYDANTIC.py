from pydantic import BaseModel, EmailStr, field_validator
#field validator work in 2 mode before mode and after mode 
"""

class Emp(BaseModel):
    name: str
    email: EmailStr

    @field_validator('email')
    @classmethod
    def validate_email(cls, value):
        valid_domains = ['microsoft.com', 'google.com','gmail.com']

        # Extract domain after @
        domain_name = value.split('@')[-1]

        if domain_name not in valid_domains:
            raise ValueError(f'Invalid email address: {value}')

        return value
    @field_validator('name')
    @classmethod
    def transform_name(cls, value):
        value = value.upper()
        return value

def display(e: Emp):
    print(e.name)
    print(e.email)


data = {
    "name": "amey",
    "email": "ameyg@gmail.com"
}

e = Emp(**data)
display(e)
"""
# check if age is betw 20 and 60
from pydantic import BaseModel, field_validator


class Emp(BaseModel):
    name: str
    age: int

    @field_validator('age') #mode='before')  #mode before then it will not convert validator will take it in form of str no conversion
    @classmethod
    def validate_age(cls, value):
        if 20 < value <= 60:
            return value
        else:
            raise ValueError('Invalid age')


def display(e: Emp):
    print(e.name)
    print(e.age)


data = {
    "name": "amey",
    "age": "22"
}

e = Emp(**data)

display(e)