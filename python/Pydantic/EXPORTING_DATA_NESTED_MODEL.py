#EXPORTING DATA  OF NESTED MODEL
# NESTED CLASS
# Address is a model inside Emp model

from pydantic import BaseModel


# create Address model
class Address(BaseModel):
    houseno: str
    city: str
    state: str


# create Employee model
class Emp(BaseModel):
    name: str
    sal: float

    # addr is a field inside Emp class
    # addr datatype is Address
    # Address class object contains houseno, city and state
    addr: Address


# function to display employee data
def print_data(e: Emp):

    print(e.name)
    print(e.sal)

    # print complete Address object
    print(e.addr)

    # accessing fields of Address object
    print(e.addr.houseno)
    print(e.addr.city)
    print(e.addr.state)


# Address information
addr_info = {
    "houseno": "24/A",
    "city": "Punewala",
    "state": "Maharashtra"
}


# create Address class object
# a is an object of Address class
a = Address(**addr_info)


# Employee information
# addr contains Address class object 'a'
emp_info = {
    "name": "AMEY",
    "sal": 99000,
    "addr": a
}


# create Emp class object
# emp_info contains name, sal and addr
e = Emp(**emp_info)
# ===============================================================================
#EXPORT DATA IN OBJ e

data = e.model_dump()
print(data)
#export in json format

data = e.model_dump_json()
print(data)

#diff j:"",d:'' j:reduce spaces

#include exclude options
data = e.model_dump(include={'name','sal'})
print(data)

data = e.model_dump(exclude={'sal','addr'})
print(data)

data = e.model_dump(exclude={'addr':'city'})
print(data)

data = e.model_dump(exclude={'addr':{'city'}, 'name':True})
print(data)


