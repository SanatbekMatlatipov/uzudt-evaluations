#!/bin/bash
# Converts data and trains a spaCy pipeline

TRAIN_CONLLU=../data/uz_ud_treebank_train.conllu
TEST_CONLLU=../data/uz_ud_treebank_test.conllu
MODEL_DIR=../models/spacy_uzbek
CONFIG=config_uzbek.cfg

# Step 1: Convert
python -m spacy convert $TRAIN_CONLLU ../data --name uzbek_train --n-sents 100
python -m spacy convert $TEST_CONLLU ../data --name uzbek_test --n-sents 100

# Step 2: Init config
python -m spacy init config $CONFIG --lang uz --pipeline tagger,parser --force

# Step 3: Train
python -m spacy train $CONFIG \
  --paths.train ../data/uzbek_train.spacy \
  --paths.dev ../data/uzbek_test.spacy \
  --output $MODEL_DIR
