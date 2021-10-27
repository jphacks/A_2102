from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from inference import NegaPogi
from scraping import scrape
from pydantic import BaseModel
import random

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


def make_score(text) -> float:
    sentence_raw = scrape(text)
    if sentence_raw > 10:
        sentence = random.sample(sentence_raw, 10)
    nega_posi_list = []
    if len(sentence_raw) == 0:
        return 0
    for word in sentence:
        nega_posi_list.append(nega_posi.predict(word))
    score = nega_posi_list.count(1) / len(nega_posi_list)
    return score


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
    score_1 = make_score(req.text1)
    score_2 = make_score(req.text2)
    return {"res": "ok", "score_1": score_1, "score_2": score_2}
