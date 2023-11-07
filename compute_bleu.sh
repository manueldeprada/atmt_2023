bash scripts/postprocess.sh $1 $1.p en
cat $1.p | sacrebleu $2
