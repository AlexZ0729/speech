The data is mapped from 61 to 48 phonemes for training. For final test set
evaluation the 48 phonemes are again mapped to 39. The phoneme mapping is the
standard recipe, the map used here is taken from the [Kaldi TIMIT recipe].

## Setup
#### For the purpose of TTIC 31110...
You can find the **preprocessed** TIMIT data partitions and the corresponding jsons stored on the TTIC slurm cluster at 
```
/share/data/lang/users/ttic_31110/Datasets/timit
```
Or alternatively the dataset can also be found [here](https://forms.gle/EGuaYYW72bzs4KbK8)

NOTE: you will have to modify the paths in the data jsons accordingly.

#### Otherwise, once downloaded, prepare the data

```
./data_prep.sh <path_to_timit>
```

This script will convert the `.flac` to `.wav` files and store them in the same
location. You'll need write access to directory where timit is stored. It will
then symlink the timit directory to `./data`. There should be three data json
files in `data/timit`:

- `train.json`: 3696 utterances from 462 speakers
- `dev.json`: 400 utterances from 50 held-out speakers
- `test.json`: 192 utterances from 24 speakers, the standard TIMIT test set

## Train 

There is a CTC and a sequence-to-sequence with attention configuration. Before
training a model, edit the configuration file. In particular, set the
`save_path` to a location where you'd like to store the model and verify the paths 
under the `data`. Edit any other
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

These are the phone error rates for the test results using the default config.json files.
Note this is without an external LM and with a beam size of 1. 

- Seq2Seq: 28%
- CTC: 23.6 %

## Leaderboard

| Paper | Test PER | Model | Features | Notes|
|---|---|---|---|---|
| [Speech Recognition with Deep Recurrent Neural Networks](https://arxiv.org/abs/1303.5778) | 17.7 | Transducer | MFCC + deltas | 3-layer bidirectional LSTM, beam search decoder, no external LM, pretrained CTC encoder  |
| [Attention-Based Models for Speech Recognition](https://arxiv.org/abs/1506.07503) | 17.6 | Seq2seq | MFCC + deltas | 3-layer bidirectional GRU, beam search decoder, no external LM |

[Kaldi TIMIT recipe]: https://github.com/kaldi-asr/kaldi/blob/master/egs/timit/s5/conf/phones.60-48-39.map
[LDC93S1]: https://catalog.ldc.upenn.edu/ldc93s1
