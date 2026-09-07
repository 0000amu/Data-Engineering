#Validating email and http urls

from pydantic import BaseModel,EmailStr,AnyUrl

class Emp(BaseModel):
    name : str
    Email : EmailStr
    LinkedIn : AnyUrl

def display(e : Emp):
    print(e.name)
    print(e.Email)
    print(e.LinkedIn)


data ={'name':"amey",'Email':"ameyg7763@gmail.com",
       "LinkedIn":"https://www.linkedin.com/in/amey-gujar-120763259/",}

e = Emp(**data)
display(e)

