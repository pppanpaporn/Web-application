from secrets import token_hex

from fastapi import APIRouter, Depends, HTTPException, status, Form
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from pydantic import BaseModel
from pymongo import MongoClient
from hashlib import sha256
from datetime import datetime

router = APIRouter()

db_client = MongoClient("mongodb://localhost:27017/")
db = db_client['web-application']
user_collection = db["users"]
token_collection = db["token"]
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


def password_hash(password: str):
    return sha256(str(password).encode('utf-8')).hexdigest()


@router.post("/login")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = user_collection.find_one({
        "username": form_data.username
    })
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    hash_password = password_hash(form_data.password)
    if not hash_password == user["hash_password"]:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    token = token_hex(16)
    token_collection.insert_one({
        "username": form_data.username,
        "token": token,
        "date_time": datetime.now()
    })
    return {
        "token": token
    }


class User(BaseModel):
    firstname: str
    lastname: str


async def current_user(token: str = Depends(oauth2_scheme)):
    print(token)
    username = token_collection.find_one({
        "token": token
    })
    data = user_collection.find_one({
        "username": username["username"]
    })
    print(data["firstname"])
    print(data["lastname"])
    return {
        "username": data["username"],
        "firstname": data["firstname"],
        "lastname": data["lastname"]
    }


@router.get("/profile")
async def profile(profile_data: User = Depends(current_user)):
    return profile_data


@router.post("/logout")
async def logout(token: str = Depends(oauth2_scheme)):
    token_collection.delete_many({
        "token": token
    })
    return status.HTTP_200_OK


# @router.post("/register")
# async def register(username: str = Form(...),password: str = Form(...)):
#     user_collection.insert_one({
#         "username": username,
#         "hash_password": password_hash(password)
#     })
#     return status.HTTP_200_OK
class Username(BaseModel):
    username: str


@router.post("/checkusername")
async def checkusername(username: Username):
    use = user_collection.find_one({
        "username": username.username
    })
    if not use:
        return {
            "available": "Yes"
        }
    else:
        return {
            "available": "No"
        }


class CreateUser(BaseModel):
    username: str
    password: str
    firstname: str
    lastname: str


@router.post("/createuser")
async def create_user(data: CreateUser):
    try:
        hash = password_hash(data.password)
        user_collection.insert_one({
            "username": data.username,
            "hash_password": hash,
            "firstname": data.firstname,
            "lastname": data.lastname
        })
        return {
            "status": "complete"
        }
    except Exception as e:
        print(e.__str__())
        return {
            "status": "error",
            "description": e.__str__()
        }


@router.put("/edit_username")
async def edit_username(data: dict, token: str = Depends(oauth2_scheme)):
    print(data)
    username: str = data["username"]
    cur = token_collection.find_one({"token": token})
    cur_index: str = cur["username"]
    old = user_collection.find_one({"username": cur_index})
    new_data = {"$set": {"username": username, }}
    user_collection.update_one(old, new_data)

    old = user_collection.find_one({"token": token})
    new_data = {"$set": {"username": username, }}
    user_collection.update_one(old, new_data)
    return
