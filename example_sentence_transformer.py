from sentence_transformers import SentenceTransformer


# model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
model = SentenceTransformer("mixedbread-ai/mxbai-embed-large-v1")
# query_embedding = model.encode("What are Pandas?", prompt_name="query")
# or
query_embedding = model.encode("What are Pandas?", prompt="Represent this sentence for searching relevant passages: ")
document_embeddings = model.encode([
    "Pandas is a software library written for the Python programming language for data manipulation and analysis.",
    "Pandas are a species of bear native to South Central China. They are also known as the giant panda or simply panda.",
    "Koala bears are not actually bears, they are marsupials native to Australia.",
])

print("query_embedding", query_embedding)
print("document_embeddings", document_embeddings)

similarity = model.similarity(query_embedding, document_embeddings)
print(similarity)
