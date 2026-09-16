# ============================================================
# Langchaine_Intro_V1 — Image de base : Python 3.11 slim
# ============================================================
FROM python:3.11-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# ============================================================
# Dépendances système
# - build-essential : compilation de paquets natifs (chromadb, tokenizers)
# - curl            : utilisé par le healthcheck du docker-compose
# - git             : nécessaire pour certains paquets HuggingFace
# - poppler-utils   : extraction depuis les PDF (Module 5 - ingestion)
# ============================================================
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# Dépendances Python — kit intro RAG (1 journée)
# Aucun notebook copié ici : le contenu de cours arrive le jour J
# via le volume /workspace (voir docker-compose.yml).
# ============================================================
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Pré-télécharge le modèle d'embeddings HuggingFace pendant le build
# (~90 Mo) pour que le premier notebook du jour J n'ait pas à attendre
# ce téléchargement en live devant le groupe.
RUN python -c "from langchain_huggingface import HuggingFaceEmbeddings; \
    HuggingFaceEmbeddings(model_name='sentence-transformers/all-MiniLM-L6-v2')"

# ============================================================
# Port exposé — JupyterLab uniquement (pas de Streamlit dans ce kit)
# ============================================================
EXPOSE 8888

# ============================================================
# Commande par défaut : lancement de Jupyter Lab
# --NotebookApp.token='' : pas d'authentification
#                          (acceptable en environnement local fermé de formation)
# ============================================================
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--allow-root", \
     "--no-browser", \
     "--ServerApp.token=''", \
     "--ServerApp.password=''", \
     "--ServerApp.root_dir=/workspace"]
