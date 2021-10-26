import torch
from transformers import AutoTokenizer, AutoModelForSequenceClassification, AdapterType

adapter_path = "./sst-2"

model = AutoModelForSequenceClassification.from_pretrained(
    "cl-tohoku/bert-base-japanese-whole-word-masking")
tokenizer = AutoTokenizer.from_pretrained(
    "cl-tohoku/bert-base-japanese-whole-word-masking")
model.load_adapter(adapter_path)


def predict(sentence):
    token_ids = tokenizer.convert_tokens_to_ids(tokenizer.tokenize(sentence))
    input_tensor = torch.tensor([token_ids])
    outputs = model(input_tensor, adapter_names=['sst-2'])
    result = torch.argmax(outputs[0]).item()

    return 'positive' if result == 1 else 'negative'


print(predict("浅沼元晴"))
print(predict("藤原拓巳"))
print(predict("平竜也"))
print(predict("伊藤アラン"))
print(predict("齋藤リナ"))
print(predict("モデルナ"))
print(predict("ファイザー"))
