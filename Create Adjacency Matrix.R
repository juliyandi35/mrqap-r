# install dan load library
library(igraph)

# membuat graf
g <- graph( edges=c(1,2, 2,3, 3,4, 4,5), n=5, directed=F)
plot(g)

# membuat adjacency matrix
adj_matrix <- get.adjacency(g)
adj_matrix <- as.matrix(adj_matrix)
print(adj_matrix)

# Load required library
library(igraph)

# Set seed for reproducibility
set.seed(123)

# Create a data frame with random numbers between 5 and 10 for columns X1, X2 and X3
df <- data.frame(X1 = round(runif(10, 5, 10),0),
                 X2 = round(runif(10, 5, 10),0),
                 X3 = round(runif(10, 5, 10),0))

# Create an empty adjacency matrix
adj_matrix <- matrix(0, nrow = ncol(df), ncol = ncol(df))

# Fill the adjacency matrix based on the values in the data frame
for (i in 1:(ncol(df) - 1)) {
  for (j in (i + 1):ncol(df)) {
    adj_matrix[i, j] <- ifelse(df[i] != df[j], 1, 0)
    adj_matrix[j, i] <- adj_matrix[i, j]
  }
}

# Create the adjacency matrix
g <- graph_from_adjacency_matrix(adj_matrix, mode = 'undirected')

# Print the adjacency matrix
as_adjacency_matrix(g, sparse = FALSE)
plot()