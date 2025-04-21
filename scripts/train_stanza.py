import stanza
from stanza.models.common import pretrain

# Setup
lang = "uz"
train_file = "../data/uz_ud_treebank_train.conllu"
dev_file = "../data/uz_ud_treebank_test.conllu"
save_dir = "../models/stanza_uzbek"

print("Training Stanza model...")

stanza.download(lang, package=None, processors="tokenize,pos,lemma,depparse", verbose=True)
stanza.utils.training.run_pos.main([
    "--train_file", train_file,
    "--eval_file", dev_file,
    "--lang", lang,
    "--output_dir", save_dir,
    "--mode", "train"
])

stanza.utils.training.run_depparse.main([
    "--train_file", train_file,
    "--eval_file", dev_file,
    "--lang", lang,
    "--output_dir", save_dir,
    "--mode", "train"
])

print(f"Stanza model saved to: {save_dir}")
