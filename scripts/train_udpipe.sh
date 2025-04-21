#!/bin/bash
# Trains a UDPipe model on the Uzbek treebank

MODEL_DIR=../models
DATA_DIR=../data
UDPIPE_MODEL=$MODEL_DIR/uzbek_udpipe.udpipe

mkdir -p $MODEL_DIR

echo "Training UDPipe..."
udpipe --train=$UDPIPE_MODEL --tokenizer=none --tagger --parser \
  $DATA_DIR/uz_ud_treebank_train.conllu
echo "Model saved to $UDPIPE_MODEL"
