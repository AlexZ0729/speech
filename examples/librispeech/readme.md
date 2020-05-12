## Setup

### If using the TTIC slurm cluster...
You can find the **preprocessed** LibriSpeech clean data partitions stored at 
```
/share/data/lang/users/ttic_31110/datasets/librispeech
```

### Otherwise, download and prepare the data

```
python download.py <path-to-data-folder>
python preprocess.py <path-to-data-folder>
```

## Train 

There is a CTC configuration file. Before
training a model, edit the configuration file. In particular, set the
`save_path` to a location where you'd like to store the model. Edit any other
parameters for your experiment. From the top-level directory, you can train the
model with

``` 
python train.py examples/timit/seq2seq_config.json
```

## Score

Save the 48 phoneme predictions with the top-level `eval.py` script.

```
python eval.py <path_to_model> examples/timit/data/timit/test.json --save predictions.json
```

To score using the reduced phoneme set (39 phonemes) run 

```
python examples/timit/score.py predictions.json 
```

## Results

TODO, awni, results are from an earlier version of the training set. Need to
update the results for the 462 speaker training set.

*NB* for best results with all models, evaluate with a batch size of 1.
Otherwise the scores can be slightly worse due to the fact that we pad the
inputs to all be the same length in a given batch.

### seq2seq

These are the dev and test results for the best sequence-to-sequence model with
attention. The configuration can be found in `seq2seq_config.json`. Note this
is without an external LM and with a beam size of 1. Also we don't use any
speaker adaptation or sophisticated features (MFCCs). Results *should* improve
with these features.

- Dev: 16.8 PER
- Test: 18.7 PER

### CTC

These are the dev and test results for the best CTC model. The configuration
can be found in `ctc_config.json`. Note this is without an external LM and with
`argmax` decoding. Also we don't use any speaker adaptation or sophisticated
features (MFCCs). Results *should* improve with these features.

- Dev: 15.4 PER
- Test: 17.6 PER
