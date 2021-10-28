# -*- coding: utf-8 -*-
"""Scraping.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1TEVr9GmVm3odGl7ed_TaA8NSDQw_8xNF
"""

import json
import requests
import re
from bs4 import BeautifulSoup


def scrape(search_word) -> list:

    comp_search_word = search_word + "比較"

    pages_num = 3

    # Googleから検索結果ページを取得する
    url = f'https://www.google.co.jp/search?hl=ja&num={pages_num}&q={comp_search_word}'
    request = requests.get(url)

    # Googleのページ解析を行う
    soup = BeautifulSoup(request.text, "html.parser")
    search_site_list = soup.select('div.kCrYT > a')

    # 正規表現：日本語
    nihongo = re.compile('[ぁ-んァ-ン一-龥ー、。「」（）！？・…”’【】『』\-0-9^kcal$]+')
    nandemo = re.compile('.+')

    sentence_list = []

    # ページ解析と結果の出力
    for site in search_site_list:
        site_url_raw = site['href'].replace('/url?q=', '')
        site_url = site_url_raw[:site_url_raw.find("&sa")]
        html = requests.get(site_url).content
        site_soup = BeautifulSoup(html, 'html.parser')

        body = site_soup.find('main-content')
        if body is None:
            body = site_soup.find('main')
        if body is None:
            body = site_soup.find('body')

        the_contents_of_body_without_body_tags = body.findChildren(
            recursive=False)
        contents = []
        for i in range(len(the_contents_of_body_without_body_tags)):
            contents.extend(re.findall(nandemo, str(
                the_contents_of_body_without_body_tags[i])))

        pattern = re.compile(r'、|。')
        contents = [i for i in contents if pattern.search(i)]

        the_contents_of_body_without_body_tags.clear()
        for i in range(len(contents)):
            the_contents_of_body_without_body_tags.append(contents[i])

        contents.clear()

        for i in range(len(the_contents_of_body_without_body_tags)):
            contents.extend(re.findall(nihongo, str(
                the_contents_of_body_without_body_tags[i])))

        contents = [i for i in contents if 4 < len(i) < 30]

        the_contents_of_body_without_body_tags.clear()
        the_contents_of_body_without_body_tags = "".join(contents)

        contents.clear()
        contents = the_contents_of_body_without_body_tags.split('。')

        dst_content = [s for s in contents if not re.match(
            '.*\d{5,}.*', s) and search_word in s]

        sentence_list.extend(dst_content)

    return sentence_list


def get_thumbnail(word) -> str:
    try:
        url = f'https://ja.wikipedia.org/api/rest_v1/page/summary/{word}'
        response = requests.get(url)
        jsonData = response.json()
        img_source = jsonData['thumbnail']['source']
    except:
        return ""

    return img_source
