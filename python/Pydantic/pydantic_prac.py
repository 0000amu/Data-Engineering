import pydantic
from pydantic import BaseModel

"""
class Product(BaseModel):
    name: str
    price: float
    quantity: int
    tags: list[str]


def insert_product_details(p: Product):
    print("product name is", p.name)
    print("price of product is", p.price)
    print("quantity is", p.quantity)
    print("tags are", p.tags)
    print("Inserted into DB")


info = {
    'name': "Amey",
    'price': 9999,
    'quantity': "2",
    'tags': ['de', 'da']
}

p = Product(**info)

print(p)

insert_product_details(p)


from pydantic import BaseModel


class Student(BaseModel):
    name: str
    marks: list[int]
    subjects: list[str]


def insert_student_details(s: Student):
    print("Student name is", s.name)
    print("Marks are", s.marks)
    print("Subjects are", s.subjects)
    print("Inserted into DB")


info = {
    'name': "Amey",
    'marks': [2, 3],
    'subjects': ['English', 'Maths']
}

s = Student(**info)

print(s)

insert_student_details(s)
"""

from pydantic import BaseModel


class Subjects(BaseModel):
    name: str
    marks: int


class Student(BaseModel):
    student_name: str
    age: int
    subjects: list[Subjects]


def insert_student_info(s: Student):
    print("Student name is", s.student_name)
    print("Student age is", s.age)

    for sub in s.subjects:
        print("Student subject is", sub.name)
        print("Student marks are", sub.marks)

    print("Inserted into DB")


info = {
    'student_name': "Amey",
    'age': 22,
    'subjects': [
        {"name": "English", "marks": 80},
        {"name": "Maths", "marks": 90}
    ]
}

s = Student(**info)

print(s)

insert_student_info(s)