# 🇺🇿 Uzbek UD Treebank Evaluation

This repository contains all code, data, and training pipelines for evaluating the **Uzbek Universal Dependencies (UD) Treebank**, introduced in our ICCCI 2025 paper:

> **“A Gold Standard Dependency Treebank for Uzbek Language”**  
> Sanatbek Matlatipov, 2025  

It includes training and evaluation scripts for **UDPipe**, **Stanza**, and **spaCy** on manually annotated Uzbek CoNLL-U treebanks.

---

## 📁 Repository Structure
uzudt-evaluations/
├── data/
│   ├── uz_ud_treebank_train.conllu
│   └── uz_ud_treebank_test.conllu
│
├── scripts/
│   ├── train_udpipe.sh
│   ├── train_stanza.py
│   ├── train_spacy.sh
│   └── evaluate.sh
│
├── models/                      # saved models after training
│
├── notebooks/
│   └── exploratory_analysis.ipynb
│
├── appendix/
│   └── code_snippets.md
│
├── README.md
├── requirements.txt
└── .gitignore


---

## ⚙️ Setup Instructions

Before running anything, set up your Python environment:

\`\`\`bash
# Clone this repository
git clone https://github.com/SanatbekMatlatipov/uzudt-evaluations.git
cd uzudt-evaluations

# Create virtual environment and activate it
python -m venv .venv
source .venv/bin/activate

# Install required packages
pip install -r requirements.txt
\`\`\`

---

## ▶️ Usage

### 🔹 UDPipe

#### Step 1. Train UDPipe model

\`\`\`bash
bash scripts/train_udpipe.sh
\`\`\`

- Trains a model on \`data/uz_ud_treebank_train.conllu\`
- Saves to \`models/uzbek_udpipe.udpipe\`

#### Step 2. Evaluate UDPipe model

\`\`\`bash
bash scripts/evaluate.sh udpipe
\`\`\`

- Parses the test set
- Runs official CoNLL-U evaluation (\`LAS\`, \`UAS\`, \`UPOS\`)

---

### 🔹 Stanza

#### Step 1. Train Stanza model

\`\`\`bash
python scripts/train_stanza.py
\`\`\`

- Trains POS tagger + dependency parser on training data
- Saves model under \`models/stanza_uzbek/\`

#### Step 2. Evaluate Stanza model

\`\`\`bash
bash scripts/evaluate.sh stanza
\`\`\`

- Loads saved model
- Evaluates on test set

---

### 🔹 spaCy

#### Step 1. Convert CoNLL-U to spaCy format

\`\`\`bash
python -m spacy convert data/uz_ud_treebank_train.conllu data/ --name uzbek_train
python -m spacy convert data/uz_ud_treebank_test.conllu data/ --name uzbek_test
\`\`\`

#### Step 2. Initialize spaCy config

\`\`\`bash
python -m spacy init config config_uzbek.cfg --lang uz --pipeline tagger,parser --force
\`\`\`

#### Step 3. Train spaCy model

\`\`\`bash
python -m spacy train config_uzbek.cfg \
  --paths.train data/uzbek_train.spacy \
  --paths.dev data/uzbek_test.spacy \
  --output models/spacy_uzbek
\`\`\`

#### Step 4. Evaluate spaCy model

\`\`\`bash
python -m spacy evaluate models/spacy_uzbek/model-best data/uzbek_test.spacy
\`\`\`

---

## 📊 Output

- Trained models are stored in \`models/\`
- Evaluation scores are printed to terminal or stored in logs if redirected
- Metrics include:
  - **LAS**: Labeled Attachment Score
  - **UAS**: Unlabeled Attachment Score
  - **UPOS**: Part-of-Speech Accuracy

---

## 📈 Results (from paper)

| Parser   | LAS (%) | UAS (%) | UPOS (%) |
|----------|---------|---------|----------|
| UDPipe   | 55.0    | 63.0    | 94.5     |
| spaCy    | 61.0    | 69.0    | 96.0     |
| Stanza   | 66.0    | 74.0    | 97.0     |

---

## 🧪 Requirements

* spacy==3.7.2
* stanza==1.6.0
* udapi==1.2.0


You can install these using:


`pip install -r requirements.txt
`

---

## 📄 License

MIT License. See \`LICENSE\` file for details.

---

## 🔖 Citation

If you use this repository or the treebank, please cite our ICCCI 2025 paper:

@inproceedings{matlatipov2025uzudt,
  title={A Gold Standard Dependency Treebank for Uzbek Language},
  author={Matlatipov, Sanatbek},
  booktitle={ICCCI 2025},
  year={2025}
}
