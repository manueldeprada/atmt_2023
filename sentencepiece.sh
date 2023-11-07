# cat data/en-fr/raw/train.* > data/en-fr/raw/train.all
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:assignments/03/sentencepiece-0.1.99-Linux/lib
export PATH=$PATH:assignments/03/sentencepiece-0.1.99-Linux/bin
# spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all --vocab_size=8000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all_2k --vocab_size=2000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
# spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all_4k --vocab_size=4000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all_8k --vocab_size=8000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1 
# spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all_16k --vocab_size=16000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
# spm_train --input=data/en-fr/raw/train.all --model_prefix=sp_all_32k --vocab_size=32000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
# spm_train --input=data/en-fr/raw/train.en --model_prefix=sp_en --vocab_size=4000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
# spm_train --input=data/en-fr/raw/train.fr --model_prefix=sp_fr --vocab_size=4000 --model_type=bpe --character_coverage=1.0 --pad_id=0 --eos_id=1 --unk_id=2 --bos_id=-1
# mkdir data/en-fr/sp_all
mkdir data/en-fr/sp_all_2k
# mkdir data/en-fr/sp_all_4k
mkdir data/en-fr/sp_all_8k
# mkdir data/en-fr/sp_all_16k
# mkdir data/en-fr/sp_all_32k

# mv sp_all* data/en-fr/sp_all
mv sp_all_2k* data/en-fr/sp_all_2k
# mv sp_all_4k* data/en-fr/sp_all_4k
mv sp_all_8k* data/en-fr/sp_all_8k
# mv sp_all_16k* data/en-fr/sp_all_16k
# mv sp_all_32k* data/en-fr/sp_all_32k

# mv data/en-fr/sp_all/sp_all.model data/en-fr/sp_all/en.model
mv data/en-fr/sp_all_2k/sp_all_2k.model data/en-fr/sp_all_2k/en.model
# mv data/en-fr/sp_all_4k/sp_all_4k.model data/en-fr/sp_all_4k/en.model
mv data/en-fr/sp_all_8k/sp_all_8k.model data/en-fr/sp_all_8k/en.model
# mv data/en-fr/sp_all_16k/sp_all_16k.model data/en-fr/sp_all_16k/en.model
# mv data/en-fr/sp_all_32k/sp_all_32k.model data/en-fr/sp_all_32k/en.model

# cp data/en-fr/sp_all/en.model data/en-fr/sp_all/fr.model
cp data/en-fr/sp_all_2k/en.model data/en-fr/sp_all_2k/fr.model
# cp data/en-fr/sp_all_4k/en.model data/en-fr/sp_all_4k/fr.model
cp data/en-fr/sp_all_8k/en.model data/en-fr/sp_all_8k/fr.model
# cp data/en-fr/sp_all_16k/en.model data/en-fr/sp_all_16k/fr.model
# cp data/en-fr/sp_all_32k/en.model data/en-fr/sp_all_32k/fr.model

# mv data/en-fr/sp_all/sp_all.vocab data/en-fr/sp_all/en.vocab
mv data/en-fr/sp_all_2k/sp_all_2k.vocab data/en-fr/sp_all_2k/en.vocab
# mv data/en-fr/sp_all_4k/sp_all_4k.vocab data/en-fr/sp_all_4k/en.vocab
mv data/en-fr/sp_all_8k/sp_all_8k.vocab data/en-fr/sp_all_8k/en.vocab
# mv data/en-fr/sp_all_16k/sp_all_16k.vocab data/en-fr/sp_all_16k/en.vocab
# mv data/en-fr/sp_all_32k/sp_all_32k.vocab data/en-fr/sp_all_32k/en.vocab

# cp data/en-fr/sp_all/en.vocab data/en-fr/sp_all/fr.vocab
cp data/en-fr/sp_all_2k/en.vocab data/en-fr/sp_all_2k/fr.vocab
# cp data/en-fr/sp_all_4k/en.vocab data/en-fr/sp_all_4k/fr.vocab
cp data/en-fr/sp_all_8k/en.vocab data/en-fr/sp_all_8k/fr.vocab
# cp data/en-fr/sp_all_16k/en.vocab data/en-fr/sp_all_16k/fr.vocab
# cp data/en-fr/sp_all_32k/en.vocab data/en-fr/sp_all_32k/fr.vocab

# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all/train.en.txt
# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all/train.fr.txt
# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all/valid.en.txt
# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all/valid.fr.txt
# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all/test.en.txt
# spm_encode --model=data/en-fr/sp_all/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all/test.fr.txt

spm_encode --model=data/en-fr/sp_all_2k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all_2k/train.en.txt
spm_encode --model=data/en-fr/sp_all_2k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all_2k/train.fr.txt
spm_encode --model=data/en-fr/sp_all_2k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all_2k/valid.en.txt
spm_encode --model=data/en-fr/sp_all_2k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all_2k/valid.fr.txt
spm_encode --model=data/en-fr/sp_all_2k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all_2k/test.en.txt
spm_encode --model=data/en-fr/sp_all_2k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all_2k/test.fr.txt

# spm_encode --model=data/en-fr/sp_all_4k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all_4k/train.en.txt
# spm_encode --model=data/en-fr/sp_all_4k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all_4k/train.fr.txt
# spm_encode --model=data/en-fr/sp_all_4k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all_4k/valid.en.txt
# spm_encode --model=data/en-fr/sp_all_4k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all_4k/valid.fr.txt
# spm_encode --model=data/en-fr/sp_all_4k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all_4k/test.en.txt
# spm_encode --model=data/en-fr/sp_all_4k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all_4k/test.fr.txt

spm_encode --model=data/en-fr/sp_all_8k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all_8k/train.en.txt
spm_encode --model=data/en-fr/sp_all_8k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all_8k/train.fr.txt
spm_encode --model=data/en-fr/sp_all_8k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all_8k/valid.en.txt
spm_encode --model=data/en-fr/sp_all_8k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all_8k/valid.fr.txt
spm_encode --model=data/en-fr/sp_all_8k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all_8k/test.en.txt
spm_encode --model=data/en-fr/sp_all_8k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all_8k/test.fr.txt

# spm_encode --model=data/en-fr/sp_all_16k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all_16k/train.en.txt
# spm_encode --model=data/en-fr/sp_all_16k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all_16k/train.fr.txt
# spm_encode --model=data/en-fr/sp_all_16k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all_16k/valid.en.txt
# spm_encode --model=data/en-fr/sp_all_16k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all_16k/valid.fr.txt
# spm_encode --model=data/en-fr/sp_all_16k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all_16k/test.en.txt
# spm_encode --model=data/en-fr/sp_all_16k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all_16k/test.fr.txt

# spm_encode --model=data/en-fr/sp_all_32k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp_all_32k/train.en.txt
# spm_encode --model=data/en-fr/sp_all_32k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp_all_32k/train.fr.txt
# spm_encode --model=data/en-fr/sp_all_32k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp_all_32k/valid.en.txt
# spm_encode --model=data/en-fr/sp_all_32k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp_all_32k/valid.fr.txt
# spm_encode --model=data/en-fr/sp_all_32k/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp_all_32k/test.en.txt
# spm_encode --model=data/en-fr/sp_all_32k/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp_all_32k/test.fr.txt

# mkdir data/en-fr/sp
# mv sp_en* data/en-fr/sp
# mv sp_fr* data/en-fr/sp
# mv data/en-fr/sp/sp_en.model data/en-fr/sp/en.model
# mv data/en-fr/sp/sp_fr.model data/en-fr/sp/fr.model
# mv data/en-fr/sp/sp_en.vocab data/en-fr/sp/en.vocab
# mv data/en-fr/sp/sp_fr.vocab data/en-fr/sp/fr.vocab
# spm_encode --model=data/en-fr/sp/en.model --output_format=id --extra_options=eos < data/en-fr/raw/train.en > data/en-fr/sp/train.en.txt
# spm_encode --model=data/en-fr/sp/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/train.fr > data/en-fr/sp/train.fr.txt
# spm_encode --model=data/en-fr/sp/en.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.en > data/en-fr/sp/valid.en.txt
# spm_encode --model=data/en-fr/sp/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/valid.fr > data/en-fr/sp/valid.fr.txt
# spm_encode --model=data/en-fr/sp/en.model --output_format=id --extra_options=eos < data/en-fr/raw/test.en > data/en-fr/sp/test.en.txt
# spm_encode --model=data/en-fr/sp/fr.model --output_format=id --extra_options=eos < data/en-fr/raw/test.fr > data/en-fr/sp/test.fr.txt
# ls data/en-fr/sp/*.txt | xargs -L 1 -d '\n' python text2bin.py
# ls data/en-fr/sp_all/*.txt | xargs -L 1 -d '\n' python text2bin.py
ls data/en-fr/sp_all_2k/*.txt | xargs -L 1 -d '\n' python text2bin.py
# ls data/en-fr/sp_all_4k/*.txt | xargs -L 1 -d '\n' python text2bin.py
ls data/en-fr/sp_all_8k/*.txt | xargs -L 1 -d '\n' python text2bin.py
# ls data/en-fr/sp_all_16k/*.txt | xargs -L 1 -d '\n' python text2bin.py
# ls data/en-fr/sp_all_32k/*.txt | xargs -L 1 -d '\n' python text2bin.py