library(netglm)
# create test data #
# inspired by the example funciton in sna::netlm
ivnet1<-sna::rgraph(20,4)
ivnet2<-sna::rgraph(20,4)
dv1<-ivnet1[1,,]+4*ivnet1[2,,]+2*ivnet1[3,,] # Note that the fourth graph is unrelated
dv1 <- dv1 + rnorm(400,mean = 1, sd = 1)
dv2 <- 2*ivnet2[1,,]+3*ivnet2[2,,]+3*ivnet2[3,,]
dv2 <- dv2 + rnorm(400,mean = 1, sd = 1)
dvs <- list(dv1, dv2)
iv1 <- list(ivnet1[1,,],ivnet1[2,,],ivnet1[3,,], ivnet1[4,,])
iv2 <- list(ivnet2[1,,],ivnet2[2,,],ivnet2[3,,], ivnet2[4,,])
ivs <- list(iv1, iv2)
iv.names = c("intercept",paste0("IV",1:4))
QAP.MG(dvs, ivs, iv.names = c("intercept",paste0("IV",1:4)), samples = 3000)
