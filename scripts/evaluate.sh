#!/bin/bash
# Evaluates model predictions using conll18_ud_eval.py

EVAL_SCRIPT=../appendix/conll18_ud_eval.py
GOLD=../data/uz_ud_treebank_test.conllu

if [ "$1" == "udpipe" ]; then
  echo "Evaluating UDPipe..."
  udpipe --tag --parse ../models/uzbek_udpipe.udpipe $GOLD > output_udpipe.conllu
  python $EVAL_SCRIPT $GOLD output_udpipe.conllu

elif [ "$1" == "stanza" ]; then
  echo "Evaluating Stanza..."
  python evaluate_stanza.py

elif [ "$1" == "spacy" ]; then
  echo "Evaluating spaCy..."
  python -m spacy evaluate ../models/spacy_uzbek/model-best ../data/uzbek_test.spacy

else
  echo "Usage: bash evaluate.sh [udpipe|stanza|spacy]"
fi
