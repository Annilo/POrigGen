
setwd("~/POrigGen/data/")
library(data.table)
library(dplyr)
set.seed(798) # the original lists where gotten without seed, so if one wants to replicate, just use them


dt <- fread("manifest.txt")
table(dt$Population)


dt_subs <- dt %>% 
  group_by(Population) %>% 
  sample_frac(., size = 0.8, replace = FALSE)
table(dt_subs$Population)
table(dt$Population)


write.table(dt_subs$SampleID,"samples.2561.txt",col.names = F, row.names = F, sep = "\t", quote = F)
write.table(dt$SampleID[!(dt$SampleID %in% dt_subs$SampleID)],"samples.641.test.txt",col.names = F, row.names = F, sep = "\t", quote = F)