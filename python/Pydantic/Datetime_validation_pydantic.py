#date validations
"""
from pydantic import BaseModel
from datetime import date
from datetime import time

# step 1 create base model define data types and constrains

class Event(BaseModel):
    title : str
    dt : date

#step 3 pass the base model obj to function
def display(e:Event):
    print("event :",e.title)
    print("date={}/{}/{}".format(e.dt.day,e.dt.month,e.dt.year))




# Step 2: create an obj to  BaseModel object cls pass and data this obj
#d={"title":"tommarow python cls", "dt":date(2026,9,7)}
e=Event(title="tommarow python cls", dt=date(2026,9,7))
#e = Event(**d)

display(e)

"""
#datetime validations

from pydantic import BaseModel
from datetime import datetime

# step 1 create base model define data types and constrains

class Event(BaseModel):
    title : str
    dt : datetime

#step 3 pass the base model obj to function
def display(e:Event):
    print("event :",e.title)
    print("On={}/{}/{}".format(e.dt.day,e.dt.month,e.dt.year))
    print('At={}:{}:{}'.format(e.dt.hour,e.dt.minute,e.dt.second))



# Step 2: create an obj to  BaseModel object cls pass and data this obj
#d={"title":"tommarow python cls", "dt":datetime(2026,9,7,10,30,15)}
d={"title":"todays python cls", "dt":datetime.today()}

#e=Event(title="tommarow python cls", dt=date(2026,9,7))

e = Event(**d)

display(e)
