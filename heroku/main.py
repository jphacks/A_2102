from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from scraping import get_thumbnail, scrape
from inference import NegaPogi
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


def make_sentence(text) -> list:
    sentence, site_url = scrape(text)
    return sentence, site_url


def make_score(sentence) -> float:
    if len(sentence) > 10:
        sentence = random.sample(sentence, 10)
    nega_posi_list = []
    if len(sentence) == 0:
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
    text_1 = req.text1
    text_2 = req.text2
    image_url_1 = get_thumbnail(text_1)
    image_url_2 = get_thumbnail(text_2)
    sentence_1, site_url_1 = make_sentence(text_1)
    sample_sentence_1 = random.sample(sentence_1, 3)
    score_1 = make_score(sentence_1)
    sentence_2, site_url_2 = make_sentence(text_2)
    sample_sentence_2 = random.sample(sentence_2, 3)
    score_2 = make_score(sentence_2)
    return {"res": "ok", "image_url_1": image_url_1,
            "image_url_2": image_url_2,
            "score_1": score_1,
            "score_2": score_2,
            "sentence_1": sample_sentence_1,
            "sentence_2": sample_sentence_2,
            "site_url_1": site_url_1,
            "site_url_2": site_url_2
            }
