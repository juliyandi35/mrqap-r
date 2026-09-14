library(asnipe)
data("individuals")
data("group_by_individual")

# Generate network
network <- get_network(gbi)

# Create a species similarity matrix
species <- array(0,dim(network))

# Create a sex similarity matrix
sex <- array(0,dim(network))

# Fill each matrix with 1 (same) or 0 (different)
for (i in 1:nrow(network)) {
  species[i,-i] <- as.numeric(inds$SPECIES[i] == inds$SPECIES[-i])
  sex[i,-i] <- as.numeric(inds$SEX[i] == inds$SEX[-i])
}

# Run mrqap.dsp
# Note randomisations are limited to 10 to reduce runtime
reg <- mrqap.dsp(network ~ species + sex, randomisations=10)

# Look at results
reg
