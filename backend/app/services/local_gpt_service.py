from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

MODEL_NAME = "microsoft/DialoGPT-small"  # 可換成 OpenChat, LLaMA-2-chat
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME, use_fast=False)
import torch
dtype = torch.float16 if torch.cuda.is_available() else torch.float32
model = AutoModelForCausalLM.from_pretrained(MODEL_NAME, torch_dtype=dtype, device_map="auto")

def generate_local_gpt_reply(content: str) -> str:
    try:
        inputs = tokenizer(content, return_tensors="pt").to(model.device)
        outputs = model.generate(**inputs, max_length=512)
        return tokenizer.decode(outputs[0], skip_special_tokens=True)
    except Exception as e:
        return f"AI 回覆失敗: {e}"


