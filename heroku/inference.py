# -*- coding: utf-8 -*-
import torch
from transformers import AutoTokenizer, AutoModelForSequenceClassification, AdapterType


class NegaPogi():
    adapter_path = "./sst-2"

    model = AutoModelForSequenceClassification.from_pretrained(
        "cl-tohoku/bert-base-japanese-whole-word-masking")
    tokenizer = AutoTokenizer.from_pretrained(
        "cl-tohoku/bert-base-japanese-whole-word-masking")
    model.load_adapter(adapter_path)

    def predict(self, sentence) -> int:
        token_ids = self.tokenizer.convert_tokens_to_ids(
            self.tokenizer.tokenize(sentence))
        input_tensor = torch.tensor([token_ids])
        outputs = self.model(input_tensor, adapter_names=['sst-2'])
        result = torch.argmax(outputs[0]).item()

        return result
