
echo "---- Random ----"
mkdir random
for i in {1..10}
do
   echo "Iteration ${i}"
   mkdir falsify_csvs
   python3.9 analyze.py falsify random compositional 5
   python3.9 analyze.py falsify random monolithic
   mv falsify_csvs falsify_csvs_${i}
   mv falsify_csvs_${i} random/
done


echo "---- Halton ----"
mkdir halton
for i in {1..10}
do
   echo "Iteration ${i}"
   mkdir falsify_csvs
   python3.9 analyze.py falsify halton compositional 5
   python3.9 analyze.py falsify halton monolithic
   mv falsify_csvs falsify_csvs_${i}
   mv falsify_csvs_${i} halton/
done
