infile=$1
infile_no_ext=$(echo $infile | rev | cut -d'.' -f2- | rev)
outfile=$infile_no_ext.p.$(echo $infile | rev | cut -d'.' -f1 | rev)
test_file=$2
test_file_ext=$(echo $test_file | rev | cut -d'.' -f1 | rev)
lang=$test_file_ext

cat $infile | perl moses_scripts/detruecase.perl | perl moses_scripts/detokenizer.perl -q -l $lang > $outfile
cat $outfile | sacrebleu $test_file