
# Frequentist -------------------------------------------------------------


# first naive model
myform <- mpg~cyl+hp
mylm <- lm(myform, data = mydf)
summary(mylm)


# second naive model
myform2 <- mpg~cyl+wt
mylm2 <- lm(myform2, data = mydf)
summary(mylm2)


# third model - best one so far
myform3 <- mpg~wt*hp
mylm3 <- lm(myform3, data = mydf)
summary(mylm3)


# fourth model with all variables -shit
myform4 <- mpg~.-car
mylm4 <- lm(myform4, data = mydf)
summary(mylm4)


# model with 1/hp
myform5 <- mpg~I(1/hp)*I(1/wt)
mylm5 <- lm(myform5, data = mydf)
summary(mylm5)
plot(mylm5)



# Bayesian ----------------------------------------------------------------

library(brms)

myblm5 <- brm(myform5, data = mydf)
summary(myblm5)
plot(myblm5) # plot posterior distributions
plot(marginal_effects(myblm5), ask = FALSE) # plot response curves
