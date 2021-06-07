import datetime
import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from pymongo import MongoClient
import auth

app = FastAPI(
    title="Web-Application"
)

app.include_router(auth.router)
# app.include_router(data_transmission.router)
# app.include_router(authen.router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*']
)


@app.get("/")
def test_connection():
    print("HAVE NEW CONNECTION.....................................................................")


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8001)
