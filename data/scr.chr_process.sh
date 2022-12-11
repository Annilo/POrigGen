
# one need to have bcftools and plink1.9 to work through it. They can be easily installed on Unix-liky systems

# one need to download original data and store them somewhere (via wget -c in shell loop for example)
# http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/
pth=/path/to/the/chromosomes


chr=$1

# subset the train samples
bcftools view -S samples.2561.txt -v snps \
  $pth/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${chr}.filtered.shapeit2-duohmm-phased.vcf.gz \
  -Oz -o $chr.tmp.vcf.gz

# find the relatively independent, "high" frequency (heavy indepdent here) set of SNPs given train data
plink --vcf $chr.tmp.vcf.gz \
  --exclude inversion.hg38.txt \
  --autosome \
  --maf 0.05 \
  --hwe 1e-6 \
  --range --indep-pairwise 50 5 0.005 \
  --out chr${chr}.indepSNP
  
# process the output list of SNPs  
cut -f1,2 -d":" chr${chr}.indepSNP.prune.in > chr${chr}.tmp
sed "s/:/\t/g" chr${chr}.tmp | sed "s/^/chr/g" > chr${chr}.tsv

# susbet this SNPs from the original data
bcftools view -R chr${chr}.tsv -v snps \
  $pth/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${chr}.filtered.shapeit2-duohmm-phased.vcf.gz \
  -Oz -o ${chr}.subs.vcf.gz

# index the file  
bcftools index -f -t ${chr}.subs.vcf.gz
