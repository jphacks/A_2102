from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from inference import NegaPogi
from scraping import scrape
from pydantic import BaseModel

app = FastAPI()

nega_posi = NegaPogi()

origins = [
    "https://jphacks.github.io/A_2102",
    "http://localhost",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class ReqText(BaseModel):
    text1: str
    text2: str


@app.get("/")
def read_root():
    return {"Welcome": "Welcomeだよ！！"}


@app.post("/test/")
def test(req: ReqText):
    new_str = req.text1 + req.text2
    return {"res": "ok", "text": new_str}


@app.post("/comparison/")
def comparison(req: ReqText):
    sentence_1 = scrape(req.text1)
    nega_posi_list_1 = []
    for word in sentence_1:
        nega_posi_list_1.append(nega_posi.predict(word))
    score_1 = nega_posi_list_1.count('positive') / len(nega_posi_list_1)
    sentence_2 = scrape(req.text2)
    nega_posi_list_2 = []
    for word in sentence_2:
        nega_posi_list_2.append(nega_posi.predict(word))
    score_2 = nega_posi_list_2.count('positive') / len(nega_posi_list_2)
    return {"res": "ok", "score_1": score_1, "score_2": score_2}
