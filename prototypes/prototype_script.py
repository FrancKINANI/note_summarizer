from llama_cpp import Llama

llm = Llama(
    model_path="./phi-3-mini-4k-instruct.Q4_K_M.gguf",
    n_ctx=2048,
    n_threads=4,
    verbose=False
)

response = llm.create_chat_completion(
    messages=[{"role": "user", "content": "Summarize: Machine learning is..."}]
)
print(response["choices"][0]["message"]["content"])