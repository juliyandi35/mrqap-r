library(asnipe)
library(network)
library(readxl)
library(sna)
data <- read_excel("Dataset.xlsx",sheet = "Data")
data <- as.data.frame(data)
names(data)
Descriptive <- data.frame(Min = sapply(data[,c(3:7,13,19,25,31,36)],min),
                          Mean = sapply(data[,c(3:7,13,19,25,31,36)],mean),
                          Max = sapply(data[,c(3:7,13,19,25,31,36)],max),
                          SD = sapply(data[,c(3:7,13,19,25,31,36)],sd))
Descriptive

graph <- read_excel("Dataset.xlsx",sheet = "Adjacency Matrix")
graph <- as.matrix(graph)
rownames(graph) <- graph[,1]
graph <- graph[,-1]
colnames(graph) <- NULL

# Generate network#NULL# Generate network# Gedatanerate network
network <- get_network(graph)

# Create similarity matrix
JobDesign <- array(0,dim(network))
Training <- array(0,dim(network))
Incentive <- array(0,dim(network))
RID <- array(0,dim(network))
Performance <- array(0,dim(network))

# Fill each matrix with 1 (same) or 0 (different)
for (i in 1:nrow(network)) {
  JobDesign[i,-i] <- as.numeric(data$JobDesign[i] == data$JobDesign[-i])
  Training[i,-i] <- as.numeric(data$Training[i] == data$Training[-i])
  Incentive[i,-i] <- as.numeric(data$Incentive[i] == data$Incentive[-i])
  RID[i,-i] <- as.numeric(data$RID[i] == data$RID[-i])
  Performance[i,-i] <- as.numeric(data$Performance[i] == data$Performance[-i])
}

gcor(Performance,JobDesign)
gcor(Performance,Training)
gcor(Performance,Incentive)
gcor(Performance,RID)

# Perform network randomisation
# Note randomisations are limited to 10 to reduce runtime
set.seed(123)
networks_rand <- network_permutation(graph, association_matrix=network, permutations=10)

# Run mrqap.custom.null
# Note randomisations are limited to 10 to reduce runtime
reg <- mrqap.custom.null(Performance ~ JobDesign + Training + Incentive + 
                    RID, random.y=networks_rand)

# Look at results
reg
