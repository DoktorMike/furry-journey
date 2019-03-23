
# Frequentist -------------------------------------------------------------


# predicting on fitted data
mypred <- predict(mylm5)
myobs <- mydf$mpg
qplot(mypred, myobs)

# new data
newdf <- tibble(hp=c(10, 1000), wt=c(3, 4))
predict(mylm5, newdata = newdf)


# Bayesian ----------------------------------------------------------------

mybpred <- predict(myblm5)
myobs <- mydf$mpg
qplot(mybpred[,1], myobs)

# new data
newdf <- tibble(hp=c(10, 1000), wt=c(3, 4))
predict(myblm5, newdata = newdf)


# Compare
qplot(mybpred[,1], mypred)
