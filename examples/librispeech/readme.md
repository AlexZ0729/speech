## Setup

#### If using the TTIC slurm cluster...
You can find the **preprocessed** LibriSpeech clean data partitions and the corresponding jsons stored at 
```
/share/data/lang/users/ttic_31110/datasets/librispeech
```

#### Otherwise, download and prepare the data

```
python download.py <path-to-data-folder>
python preprocess.py <path-to-data-folder>
```

## Train 

There is a CTC configuration file. Before
training a model, edit the configuration file. In particular, set the
`save_path` to a location where you'd like to store the model and verify the paths under the `data`. Edit any other
parameters for your experiment. From the top-level directory, you can train the
model with

``` 
python train.py examples/librispeech/ctc_config.json
```

## Score

Save the character predictions with the top-level `eval.py` script.

```
python eval.py <path_to_model> examples/librispeech/data/test-clean.json --save predictions.json
```

## Results

The default CTC config gives a character error rate of **14.6%** on the test set.
Note this is without an external LM and with `argmax` decoding. 
