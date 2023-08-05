
echo "---- Random ----"
mkdir smc_csvs
python3.9 analyze.py smc random compositional 100
python3.9 analyze.py smc random monolithic 100
mv smc_csvs random/

echo "---- Halton ----"
mkdir smc_csvs
python3.9 analyze.py smc halton compositional 100
python3.9 analyze.py smc halton monolithic 100
mv smc_csvs halton/
