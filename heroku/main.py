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


def make_score(text) -> float:
    sentence, site_url = scrape(text)
    if len(sentence) > 10:
        sentence = random.sample(sentence, 10)
    nega_posi_list = []
    if len(sentence) == 0:
        return 0
    for word in sentence:
        nega_posi_list.append(nega_posi.predict(word))
    score = nega_posi_list.count(1) / len(nega_posi_list)
    display_sentence = random.sample(sentence, 3)
    return score, display_sentence, site_url


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
    score_1, sentence_1, site_url_1 = make_score(text_1)
    score_2, sentence_2, site_url_2 = make_score(text_2)
    return {"res": "ok", "image_url_1": image_url_1,
            "image_url_2": image_url_2,
            "score_1": score_1,
            "score_2": score_2,
            "sentence_1": sentence_1,
            "sentence_2": sentence_2,
            "site_url_1": site_url_1,
            "site_url_2": site_url_2
            }
