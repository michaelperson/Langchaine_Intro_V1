# 🎓 Langchaine_Intro_V1 — Environnement "1 journée d'introduction au RAG"

> Version allégée , taillée pour une
> **seule journée d'introduction LangChain + RAG**.
> Objectif : que chaque participant ait un environnement **prêt et testé la veille**,
> pour ne pas perdre de temps de formation en installation le jour J.

Ce dossier ne contient seulement l'infrastructure (Docker) nécessaire pour construire l'image et vérifier que JupyterLab tourne.

---

## À faire, la veille de la formation  

### 1. Prérequis sur votre poste de préparation

- Docker Desktop installé et démarré (voir rappel des specs mini plus bas)
- Ce repository complet
- Une connexion internet correcte (le build télécharge ~3 Go : image Python
  slim + paquets pip + modèle `gemma3:4b`)

### 2. Construire et démarrer l'environnement

```bash
cd Langchaine_Intro_V1
docker compose up -d --build
```

Cela va :

1. Construire l'image `langchain-app` (Python 3.11 + toutes les libs RAG).
2. Démarrer Ollama et télécharger **uniquement** `gemma3:4b` (~3,3 Go).
3. Démarrer JupyterLab, exposé sur `http://localhost:8888`.

### 3. Vérifier que tout fonctionne

```bash
# Le modèle est bien présent
docker exec formation-ollama ollama list

# JupyterLab répond
curl -sS http://localhost:8888/api | head -c 200
```

Ouvrez `http://localhost:8888` dans un navigateur : JupyterLab doit s'afficher,
vide (normal, les notebooks arrivent le jour J).

---

## Rappel — Prérequis minimum sur le poste de chaque participant

(cohérent avec le message envoyé avant la formation)

| Élément | Minimum |
|---|---|
| RAM | 8 Go (16 Go conseillé si le poste tourne autre chose en parallèle) |
| Disque libre | 10 Go |
| OS | Windows 10 21H2+/11, macOS 13+, ou Linux récent |
| Virtualisation | Activée dans le BIOS (Intel VT-x / AMD-V) — nécessaire pour Docker Desktop |
| Droits admin | **Requis** pour installer Docker Desktop |
| Réseau | Accès sortant HTTPS libre (Docker Hub, PyPI, `ollama.com`) — un proxy d'entreprise avec inspection SSL est la cause n°1 de blocage, à tester la veille, pas le jour J |

---

## Structure de ce dossier

```text
Langchaine_Intro_V1/
├── README.md                      # Ce fichier
├── docker-compose.yml             # Stack allégée : Ollama (gemma3:4b) + JupyterLab
├── Dockerfile                     # Image Python 3.11 + dépendances RAG
├── requirements.txt               # Dépendances allégées (jour RAG uniquement)
├── .devcontainer/
│   └── devcontainer.json          # Option VS Code Dev Containers, ports corrigés
└── workspace/                     # Vide  
```

---
