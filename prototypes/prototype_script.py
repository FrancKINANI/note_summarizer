from llama_cpp import Llama
import os

llm = Llama(
    model_path="../assets/models/Phi-3-mini-4k-instruct-q4.gguf",
    n_ctx=2048,
    n_threads= min(4, os.cpu_count() or 4),
    verbose=False
)

response = llm.create_chat_completion(
    messages=[{"role": "user", "content": "Summarize: Machine learning is..."}]
)
print(response["choices"][0]["message"]["content"])