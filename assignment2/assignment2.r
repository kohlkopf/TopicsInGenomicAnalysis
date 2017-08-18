
library(repr)

data_csv = read.table("GacuRNAseq_Subset.csv", row.names = 1, header = T, sep = ",")

data_txt = read.table("GacuRNAseq_Subset.txt", row.names = 1, header = T, sep = "\t")

head(data_csv)
dim(data_csv)

head(data_txt)
dim(data_txt)

class(data_txt)

names(data_txt)[1:3]

unique(data_txt[,1])
unique(data_txt[,2])
unique(data_txt[,3])

class(data_txt[,1])
class(data_txt[,2])
class(data_txt[,3])

# length of a vector of all row names minus the explanatory variables (3)
length(names(data_txt)) - 3

for (i in seq(4, length(names(data_txt)))) {
    print(class(data_txt[,i]))
    }

mean(data_txt$ENSGACG00000000003)

mean(data_txt$ENSGACG00000000004)

lapply(data_txt[4:5], mean)

expr_means_100 = lapply(data_txt[4:103], mean)

mean(expr_means_100)

class(expr_means_100)

# convert the named list to a numeric vector
expr_means_100 = unlist(expr_means_100, use.names = FALSE) 

class(expr_means_100)

# pdf('hist_mean_exp.pdf')
options(repr.plot.width=4, repr.plot.height=4)
hist(expr_means_100, xlab = "mean expression level", main = "mean expression level for 100 genes")
# dev.off()

# pdf('hist_logmean_exp.pdf')
options(repr.plot.width=4, repr.plot.height=4)
hist(log(expr_means_100, 10), xlab = "log(mean expression level)", main = "Mean expression level for 100 genes")
# dev.off()

expr_means_sub = subset(expr_means_100, expr_means_100 < 500)

length(expr_means_sub)

# pdf('hist_subset_exp.pdf')
options(repr.plot.width=4, repr.plot.height=4)
hist(expr_means_sub, xlab = "mean expression level", main = "Means < 500 expression ")
# dev.off()

tapply(data_txt[,5], data_txt$Population, mean)

# all individuals
mean(data_txt[,5])
sd(data_txt[,5])

# seperate populations
tapply(data_txt[,5], data_txt$Population, sd)

rabbit_dist = rnorm(1000, 0.18092559, 0.381502256661351)

boot_dist = rnorm(1000, 9.84801214, 5.60418290498567)

all_dist = rnorm(1000, 5.014468865, 6.28797725766485)

# pdf('Gene2_Pop_NormSamp.pdf')
options(repr.plot.width=4, repr.plot.height=10)

par(mfrow = c(3,1))

hist(rabbit_dist, xlim = range(-30, 30), ylim = range(0, 350), xlab = "mean expression levels", main = "Rabbit Slough Distribution", col = "magenta4")
hist(boot_dist, xlim = range(-30, 30), ylim = range(0, 350), xlab = "mean expression levels", main = "Boot Lake Distribution", col = "green4")
hist(all_dist, xlim = range(-30, 30), ylim = range(0, 350), xlab = "mean expression levels", main = "Total Distribution", col = "blue3")
# dev.off()

three_genes = data_txt[1:6]

write.table(three_genes, 'three_genes.csv', sep = ",")

CoefVar = function(mean, sd) {
    (sd / mean)*100
}

cvs = numeric()

for (i in seq(4, length(names(data_txt)))) {
    cvs[i-3] = CoefVar(mean(data_txt[,i]), sd(data_txt[,i]))
    }

# pdf('CV_hist.pdf') 
options(repr.plot.width=3, repr.plot.height=4)
hist(cvs, main = "CV Distribution, Total Population", xlab = "coefficient of variation")
# dev.off()

# pdf('CV_boxplot.pdf')
options(repr.plot.width=3, repr.plot.height=4)
boxplot(cvs, main = "CV, Total Population", ylab = "coefficient of variation")
# dev.off()

CoefVar = function(mean, sd) {
    (sd / mean)*100
}

boot_cvs = numeric()
rabbit_cvs = numeric()

boot_data = subset(data_txt, data_txt$Population == "Boot")
rabbit_data = subset(data_txt, data_txt$Population == "RabbitSlough")

for (i in seq(4, length(names(data_txt)))) {
    boot_cvs[i-3] = CoefVar(mean(boot_data[,i]), sd(boot_data[,i]))
    }

for (i in seq(4, length(names(data_txt)))) {
    rabbit_cvs[i-3] = CoefVar(mean(rabbit_data[,i]), sd(rabbit_data[,i]))
    }

options(repr.plot.width=8, repr.plot.height=8)

par(mfrow = c(2,2))

hist(boot_cvs, main = "CV Distribution, Boot Population", xlab = "coefficient of variation", col = "red3", xlim = range(0, 250, breaks = 20))
hist(rabbit_cvs, main = "CV Distribution, Rabbit Population", xlab = "coefficient of variation", col = "blue3", xlim = range(0, 250), breaks = 20)
boxplot(boot_cvs, main = "CV, Boot Population", ylab = "coefficient of variation", col = "red3", ylim = range(0, 300))
boxplot(rabbit_cvs, main = "CV, Rabbit Population", ylab = "coefficient of variation", col = "blue3", ylim = range(0, 300))


