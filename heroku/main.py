from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Test(BaseModel):
    Text1: str
    Text2: str


@app.get("/")
def read_root():
    return {"Welcome": "Welcomeだよ！！"}


@app.post("/test/")
def test(req: Test):
    new_str = req.Text1 + req.Text2
    return {"res": "ok", "text": new_str}
