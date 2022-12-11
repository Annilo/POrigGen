# POrigGen: Framework for Predicting the Origin of individuals from Genetic data
Machine Learning course project, Institute of Computer Science of University of Tartu, fall 2022
Team: Grayson Felt; Agnes Annilo; Ami Sild; Danat Yermakovich 

Using publicly available genomes from the 1000Genomes project, we predict the Population of origin for individuals from their genetic data. 

There are three main steps:

1. Pre-processing of the original data using plink1.9 and bcftools, consisting of filtering based on train data
a) removing genetic variants with MAF < 0.05 and the ones that violate Hardy-Weinberg Equilibrium
b) sub-setting a heavily independent set of genetic variants

The scripts are available in the data folder

The data was downloaded from 1000 Genomes ftp storage
#http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/

2. Data Exploration 

Seeing is believing. The data was shaped and normalized, and then PCA and t-SNE were launched and visualized 

2. Machine Learning

The finding of the best model, PCs input, and hyperparameters was done in a CV manner with 4 folds
