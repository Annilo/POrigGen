
# one need to have bcftools and plink1.9 to work through it. They can be easily installed on Unix-liky systems


## process all chromosomes

#parallel -j 8 "bash scr.chr_process.sh {}" ::: {1..22}
# if you do it on server/cluster/powerful machine

# or

for i in {1..22}; do
bash scr.chr_process.sh $i
done


### 

# concat all chromosomes to one file
bcftools concat {1..22}.subs.vcf.gz -Oz -o all_chr.vcf.gz
# query the SNP_ID SAMPLES table
bcftools query -f '%ID[\t%GT]\n' all_chr.vcf.gz -o all_chr.tsv

# get, change and attach the header
bcftools query -l all_chr.vcf.gz > header.tmp
cat header.tmp | tr "\n" "\t" | sed "s/^/ID\t/g" > header.txt

# unite all
cat header.txt all_chr.tsv > all_chr.H.tsv

# bgzip (it's from tabix/htslib)
bgzip -c all_chr.H.tsv > all_chr.H.tsv.gz