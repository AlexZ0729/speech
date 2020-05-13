
A Recipe for the Wall Street Journal (WSJ) corpus.

The WSJ corpus consists of about 80 hours of read sentences taken from the Wall
Street Journal. 

In these experiments we use three subsets following the Kaldi WSJ recipe:

- train: 37318 utterances, referred to as train_si284 in Kaldi
- dev: 503 utterances, referred to as dev92 in Kaldi
- test: 333 utterances, referred to as eval93 in Kaldi

## Setup
#### For the purpose of TTIC 31110...
You can find the **preprocessed** WSJ data partitions and the corresponding jsons stored on the TTIC slurm cluster at 
```
/share/data/lang/users/ttic_31110/Datasets/wsj
```
Or alternatively they can also be downloaded from here (ToDo: add link)

#### Otherwise, once downloaded, prepare the data
```
./preprocess.sh <path_to_wsj> <path_to_save_data_jsons>
```

## Train 

There is a CTC and a sequence-to-sequence with attention configuration. Before
training a model, edit the configuration file. In particular, set the
`save_path` to a location where you'd like to store the model and verify the 
paths under the `data`. Edit any other
parameters for your experiment. From the top-level directory, you can train the
model with

``` 
python train.py examples/wsj/seq2seq_config.json
```

## Score

Save the character predictions with the top-level `eval.py` script.

```
python eval.py <path_to_model> examples/wsj/data/eval_92.json --save predictions.json
```

## Results

These are the character error rates for the test results using the default config.json files.
Note this is without an external LM and with a beam size of 1. 

- Seq2Seq: 12.5 %
- CTC: 12.6 %
