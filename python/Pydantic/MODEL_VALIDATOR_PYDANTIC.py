#MODEL VALIDATOR:mvalidate multiple fields

from pydantic import BaseModel,model_validator

class Emp(BaseModel):
    name:str
    age:int
    phone:str

    @model_validator(mode='after')
    def validate_phone(self):
        #if age > 50 then provide phn no is complusary
        if self.age>50  and self.phone == '':  #empty string''
            raise ValueError('phone number must be given')
        else:
            return self  #return emp cls obj that return data

def insert_data(e: Emp):
    print(e.name)
    print(e.age)
    print(e.phone)


e = Emp(name='Amey',age=45,phone='')  #45 no error ,if 55 then value error give
insert_data(e)
