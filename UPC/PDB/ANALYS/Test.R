### B_factor ###

# Charger les données UPC
directories_UPC <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/PDB/ANALYS"
setwd(directories_UPC)
data_UPC <- read.table("all_mean.txt", header = FALSE, col.names = c("B_factor"))

# Charger les données UPNC
directories_UPNC <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPNC/PDB/ANALYS"
setwd(directories_UPNC)
data_UPNC <- read.table("alla_mean.txt", header = FALSE, col.names = c("B_factor"))

# Trouver les limites communes pour les deux jeux de données
xlim <- range(c(data_UPC$B_factor, data_UPNC$B_factor))

# Définir la plage (range) à une limite de 1500 sur l'axe y
ylim_all <- c(0, 1500)

# Histogramme UPC
par(mfrow = c(1,2))
hist(data_UPC$B_factor, main = "Histogramme des B-factors normalisé des UPC",
     xlab = "B-factor normalisé", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

# Histogramme UPNC
hist(data_UPNC$B_factor, main = "Histogramme des B-factors normalisé des UPNC",
     xlab = "B-factor normalisé", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

## test de Mann-Whitney ##

col_UPC <- data_UPC$B_factor
col_UPNC <- data_UPNC$B_factor

res_test <- wilcox.test(col_UPC, col_UPNC)

print(res_test)
#W = 2789302, p-value = 2.326e-05

#Statistique W : 
#La statistique W (W = 2789302) est la somme des rangs attribués aux observations du groupe le plus petit.
#Plus la valeur de W est élevée, plus il est probable que les deux échantillons diffèrent. 
#Cependant, il est souvent difficile d'interpréter cette valeur en soi.

#P-valeur : 
#La p-valeur est très faible (p-value = 2.326e-05). Cela suggère que vous avez des preuves statistiquement 
#significatives pour rejeter l'hypothèse nulle selon laquelle il n'y a pas de différence entre les deux groupes.
#En d'autres termes, il semble y avoir une différence significative entre les groupes UPC et UPNC.


#En conclusion, les résultats du test suggèrent qu'il existe une différence significative entre les deux groupes (UPC et UPNC)
#On peut rejeter l'hypothèse nulle d'absence de différence et conclure qu'il y a une différence significative entre les deux groupes.


#B_factor pas très élevé (proche de 0), il n'y a donc pas une grande flexibilité présente chez les UPC et les UPNC.

#Nous allons maintenant poursuivre l'analyse sur les différents groupes des UPC pour si des différences de flexibilité sont observées.


directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/PDB/ANALYS"
setwd(directories)

# dataframe
classbf <- read.table("bfact_class.txt", header = FALSE)
colnames(classbf) <- c("B_factor", "CLASS")

## Scatter plots - variables ##
grps <- as.factor(classbf$CLASS)
classbf <- classbf[,-2]
as.data.frame(classbf)
par(mfrow = c(1,1))
plot(classbf, col = grps , main="Scatter plots des variables", oma=c(3,3,3,12), pch=20)
par(xpd = TRUE)
legend("bottomright", title = "CLASS", legend = levels(grps), col = c(1,2,3), cex = 0.8, pch = c(20,20,20))


## B_factor depending on the classes ##

# Charger le package ggplot2
library(ggplot2)

# Charger le dataframe classbf
classbf <- read.table("bfact_class.txt", header = FALSE)
colnames(classbf) <- c("B_factor", "CLASS")

# Trouver la plage (range) commune des valeurs sur l'axe y
y_range <- range(classbf$B_factor)

# Définir la plage (range) à une limite de 250 sur l'axe y
y_range_all <- c(y_range[1], 225)

# Histogramme en fonction des groupes avec facet_wrap
ggplot(classbf, aes(x = B_factor, fill = CLASS)) +
  geom_histogram(position = "identity", bins = 20, alpha = 0.7, color = "black") +
  labs(title = "Distribution des B_factor des UPC en fonction des CLASS", x = "B_factor", y = "Fréquence") +
  theme_minimal() +
  facet_wrap(~CLASS, scales = "free_y") +
  ylim(y_range_all) +
  theme(
    plot.title = element_text(size = 17),  # Ajuster la taille du titre du graphique principal
    strip.text = element_text(size = 14)   # Ajuster la taille des titres des facettes
  )


# Calculer la valeur moyenne pour chaque groupe
moyennes_par_groupe <- aggregate(B_factor ~ CLASS, data = classbf, FUN = mean)

# Afficher les résultats
print(moyennes_par_groupe)

# Utiliser la fonction table pour obtenir le nombre d'éléments par classe
nombre_elements_par_classe <- table(classbf$CLASS)

# Afficher le résultat
print(nombre_elements_par_classe)


### pLLDT ###

# charger les données UPC
directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ALPHADB/ANALYS"
setwd(directories)
datafold_UPC <- read.table("allb_mean.txt", header = FALSE, col.names = c("pLDDT"))

# charger les données UPNC
directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPNC/ALPHADB/ANALYS"
setwd(directories)
datafold_UPNC <- read.table("allc_mean.txt", header = FALSE, col.names = c("pLDDT"))

# Trouver les limites communes pour les deux jeux de données
xlim <- range(c(datafold_UPC$pLDDT, datafold_UPNC$pLDDT))

# Définir la plage (range) à une limite de 1500 sur l'axe y
ylim_all <- c(0, 2000)

# histogramme UPC
par(mfrow = c(1,2))
hist(datafold_UPC$pLDDT, main = "Histogramme des pLDDT des UPC",
     xlab = "pLDDT", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

# histogramme UPNC
hist(datafold_UPNC$pLDDT, main = "Histogramme des pLDDT des UPNC",
     xlab = "pLDDT", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

## test de Wilcoxon-Mann-Whitney ##

colfold_UPC <- datafold_UPC$pLDDT
colfold_UPNC <- datafold_UPNC$pLDDT

# test de Mann-Whitney
resfold_test <- wilcox.test(colfold_UPC, colfold_UPNC)

print(resfold_test)
#W = 2664565, p-value = 0.01533

#On peut conclure qu'il existe une différence statistiquement significative 
#entre les groupes


## Pie_chart ##

## UPC
nb_values_sup_90 <- sum(datafold_UPC$pLDDT > 90)
percent_sup_90 <- round((nb_values_sup_90 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Very high :", percent_sup_90, "%"))

nb_values_sup_70 <- sum(datafold_UPC$pLDDT > 70 & datafold_UPC$pLDDT < 90)
percent_sup_70 <- round((nb_values_sup_70 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("High :", percent_sup_70, "%"))

nb_values_sup_50 <- sum(datafold_UPC$pLDDT > 50 & datafold_UPC$pLDDT < 70)
percent_sup_50 <- round((nb_values_sup_50 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Low :", percent_sup_50, "%"))

nb_values_inf_50 <- sum(datafold_UPC$pLDDT < 50)
percent_inf_50 <- round((nb_values_inf_50 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Very low :", percent_inf_50))

# Vecteur des valeurs
values <- c("Very high" = percent_sup_90, "High" = percent_sup_70, "Low" = percent_sup_50, "Very low" = percent_inf_50)

# Couleurs pour le camembert
colors <- c("#1F78B4", "#A6CEE3", "#FFD92F", "#FF7F00")

# Nom des portions
labels <- names(values)

# Créer un diagramme en camembert avec une taille plus grande
par(mfrow = c(1,1))
par(mar = c(5, 0, 4, 2))  # Ajuster les marges pour éviter le chevauchement avec le titre
pie(values, labels = labels, col = colors, main = "Distribution des UPC (%) en fonction du score de confiance : pLDDT", cex = 1.4, radius = 1, cex.main = 2)

legend_labels <- paste(labels, ": ", values, "%")

# Ajouter une légende
legend("topright", legend = legend_labels, fill = colors, cex = 1,7, bty = "n")  # bty = "n" pour supprimer la boîte autour de la légende


## UPNC
nb_values_sup_90 <- sum(datafold_UPNC$pLDDT > 90)
percent_sup_90 <- round((nb_values_sup_90 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Very high :", percent_sup_90, "%"))

nb_values_sup_70 <- sum(datafold_UPNC$pLDDT > 70 & datafold_UPNC$pLDDT < 90)
percent_sup_70 <- round((nb_values_sup_70 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("High :", percent_sup_70, "%"))

nb_values_sup_50 <- sum(datafold_UPNC$pLDDT > 50 & datafold_UPNC$pLDDT < 70)
percent_sup_50 <- round((nb_values_sup_50 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Low :", percent_sup_50, "%"))

nb_values_inf_50 <- sum(datafold_UPNC$pLDDT < 50)
percent_inf_50 <- round((nb_values_inf_50 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Very low :", percent_inf_50))

# Vecteur des valeurs
values <- c("Very high" = percent_sup_90, "High" = percent_sup_70, "Low" = percent_sup_50, "Very low" = percent_inf_50)

# Couleurs pour le camembert
colors <- c("#1F78B4", "#A6CEE3", "#FFD92F", "#FF7F00")

# Nom des portions
labels <- names(values)

# Créer un diagramme en camembert avec une taille plus grande
par(mfrow = c(1,1))
par(mar = c(5, 0, 4, 2))  # Ajuster les marges pour éviter le chevauchement avec le titre
pie(values, labels = labels, col = colors, main = "Distribution des UPNC (%) en fonction du score de confiance : pLDDT", cex = 1.4, radius = 1, cex.main = 2)

legend_labels <- paste(labels, ": ", values, "%")

# Ajouter une légende
legend("topright", legend = legend_labels, fill = colors, cex = 1,7, bty = "n")  # bty = "n" pour supprimer la boîte autour de la légende

## pLDDT depending on the classes ##

directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ALPHADB/ANALYS"
setwd(directories)

# Charger le package ggplot2
library(ggplot2)

# Charger le dataframe classbf
classbf <- read.table("pLDDT_class.txt", header = FALSE)
colnames(classbf) <- c("pLDDT", "CLASS")

# Charger le package ggplot2
library(ggplot2)

ggplot(classbf, aes(x = pLDDT, fill = CLASS)) +
  geom_histogram(position = "identity", bins = 20, alpha = 0.7, color = "black") +
  labs(title = "Distribution des pLDDT des UPC en fonction des CLASS", x = "pLDDT", y = "Fréquence") +
  theme_minimal() +
  facet_wrap(~CLASS, scales = "free_y") +
  coord_cartesian(ylim = c(0, 500)) +
  theme(
    plot.title = element_text(size = 17),  # Ajuster la taille du titre du graphique principal
    strip.text = element_text(size = 14)   # Ajuster la taille des titres des facettes
  )


# Calculer la valeur moyenne pour chaque groupe
moyennes_par_groupe <- aggregate(pLDDT ~ CLASS, data = classbf, FUN = mean)

# Afficher les résultats
print(moyennes_par_groupe)


### ESMATLAS - pLDDT ###

# UPs > 400 non-recoverable

# charger les données UPC
directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ESMATLAS/ANALYS"
setwd(directories)
datafold_UPC <- read.table("alld_mean.txt", header = FALSE, col.names = c("pLDDT"))

# charger les données UPNC
directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPNC/ESMATLAS/ANALYS"
setwd(directories)
datafold_UPNC <- read.table("alle_mean.txt", header = FALSE, col.names = c("pLDDT"))

# Trouver les limites communes pour les deux jeux de données
xlim <- range(c(datafold_UPC$pLDDT, datafold_UPNC$pLDDT))

# Définir la plage (range) à une limite de 1500 sur l'axe y
ylim_all <- c(0, 800)

# histogramme UPC
par(mfrow = c(1,2))
hist(datafold_UPC$pLDDT, main = "Histogramme des pLDDT des UPC",
     xlab = "pLDDT", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

# histogramme UPNC
hist(datafold_UPNC$pLDDT, main = "Histogramme des pLDDT des UPNC",
     xlab = "pLDDT", ylab = "Fréquence", col = "lightblue", border = "black", xlim = xlim, ylim = ylim_all)

## test de Mann-Whitney ##

colfold_UPC <- datafold_UPC$pLDDT
colfold_UPNC <- datafold_UPNC$pLDDT

# test de Mann-Whitney
resfold_test <- wilcox.test(colfold_UPC, colfold_UPNC)

print(resfold_test)
#W = 1900331, p-value < 2.2e-16

#On peut conclure qu'il existe une différence statistiquement significative 
#entre les groupes


## Pie_chart ##

## UPC
nb_values_sup_90 <- sum(datafold_UPC$pLDDT > 0.9)
percent_sup_90 <- round((nb_values_sup_90 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Very high :", percent_sup_90, "%"))

nb_values_sup_70 <- sum(datafold_UPC$pLDDT > 0.7 & datafold_UPC$pLDDT < 0.9)
percent_sup_70 <- round((nb_values_sup_70 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("High :", percent_sup_70, "%"))

nb_values_sup_50 <- sum(datafold_UPC$pLDDT > 0.5 & datafold_UPC$pLDDT < 0.7)
percent_sup_50 <- round((nb_values_sup_50 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Low :", percent_sup_50, "%"))

nb_values_inf_50 <- sum(datafold_UPC$pLDDT < 0.5)
percent_inf_50 <- round((nb_values_inf_50 / length(datafold_UPC$pLDDT))*100, 2)
print(paste("Very low :", percent_inf_50))

# Vecteur des valeurs
values <- c("Very high" = percent_sup_90, "High" = percent_sup_70, "Low" = percent_sup_50, "Very low" = percent_inf_50)

# Couleurs pour le camembert
colors <- c("#1F78B4", "#A6CEE3", "#FFD92F", "#FF7F00")

# Nom des portions
labels <- names(values)

# Créer un diagramme en camembert avec une taille plus grande
par(mfrow = c(1,1))
par(mar = c(5, 0, 4, 2))  # Ajuster les marges pour éviter le chevauchement avec le titre
pie(values, labels = labels, col = colors, main = "Distribution des UPC (%) en fonction du score de confiance : pLDDT", cex = 1.4, radius = 1, cex.main = 2)

legend_labels <- paste(labels, ": ", values, "%")

# Ajouter une légende
legend("topright", legend = legend_labels, fill = colors, cex = 1,7, bty = "n")  # bty = "n" pour supprimer la boîte autour de la légende


## UPNC
nb_values_sup_90 <- sum(datafold_UPNC$pLDDT > 0.9)
percent_sup_90 <- round((nb_values_sup_90 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Very high :", percent_sup_90, "%"))

nb_values_sup_70 <- sum(datafold_UPNC$pLDDT > 0.7 & datafold_UPNC$pLDDT < 0.9)
percent_sup_70 <- round((nb_values_sup_70 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("High :", percent_sup_70, "%"))

nb_values_sup_50 <- sum(datafold_UPNC$pLDDT > 0.5 & datafold_UPNC$pLDDT < 0.7)
percent_sup_50 <- round((nb_values_sup_50 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Low :", percent_sup_50, "%"))

nb_values_inf_50 <- sum(datafold_UPNC$pLDDT < 0.5)
percent_inf_50 <- round((nb_values_inf_50 / length(datafold_UPNC$pLDDT))*100, 2)
print(paste("Very low :", percent_inf_50))

# Vecteur des valeurs
values <- c("Very high" = percent_sup_90, "High" = percent_sup_70, "Low" = percent_sup_50, "Very low" = percent_inf_50)

# Couleurs pour le camembert
colors <- c("#1F78B4", "#A6CEE3", "#FFD92F", "#FF7F00")

# Nom des portions
labels <- names(values)

# Créer un diagramme en camembert avec une taille plus grande
par(mfrow = c(1,1))
par(mar = c(5, 0, 4, 2))  # Ajuster les marges pour éviter le chevauchement avec le titre
pie(values, labels = labels, col = colors, main = "Distribution des UPNC (%) en fonction du score de confiance : pLDDT", cex = 1.4, radius = 1, cex.main = 2)

legend_labels <- paste(labels, ": ", values, "%")

# Ajouter une légende
legend("topright", legend = legend_labels, fill = colors, cex = 1,7, bty = "n")  # bty = "n" pour supprimer la boîte autour de la légende


## ESMATLAS - pLDDT depending on the classes ##

directories <- "/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ESMATLAS/ANALYS"
setwd(directories)

# Charger le package ggplot2
library(ggplot2)

# Charger le dataframe classbf
classbf <- read.table("pLDDT_class.txt", header = FALSE)
colnames(classbf) <- c("pLDDT", "CLASS")

# Charger le package ggplot2
library(ggplot2)

ggplot(classbf, aes(x = pLDDT, fill = CLASS)) +
  geom_histogram(position = "identity", bins = 20, alpha = 0.7, color = "black") +
  labs(title = "Distribution des pLDDT des UPC en fonction des CLASS", x = "pLDDT", y = "Fréquence") +
  theme_minimal() +
  facet_wrap(~CLASS, scales = "free_y") +
  coord_cartesian(ylim = c(0, 300)) +
  theme(
    plot.title = element_text(size = 17),  # Ajuster la taille du titre du graphique principal
    strip.text = element_text(size = 14)   # Ajuster la taille des titres des facettes
  )


# Calculer la valeur moyenne pour chaque groupe
moyennes_par_groupe <- aggregate(pLDDT ~ CLASS, data = classbf, FUN = mean)

# Afficher les résultats
print(moyennes_par_groupe)
