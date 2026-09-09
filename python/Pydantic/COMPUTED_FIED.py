#COMPUTED FIELDS
from pydantic import BaseModel,Field,computed_field

class Emp(BaseModel):
    name: str
    sal: float

    @computed_field               #pydantic decorator
    @property                     #python decoraor convert method into property   pf
    def pf(self)->float:           #  -> to defin edata type
        return self.sal * 12.5/100

    @computed_field
    @property
    def itax(self)->float:
        return self.sal*10/100

                                     #cal one field from other field pf

def display(e:Emp):
    print(e.name,e.sal,e.itax,e.pf)
info={'name':"amey",
      'sal':98000
}
e = Emp(**info)
display(e)
