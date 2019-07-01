
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
library(bayesplot)

myblm5 <- brm(myform5, data = mydf)
summary(myblm5)
plot(myblm5) # plot posterior distributions
plot(marginal_effects(myblm5), ask = FALSE) # plot response curves

# Adding priors
myform2 <- mpg~cyl+disp*wt+hp+drat+qsec+vs+am+gear+carb
mypriors2 <-
  set_prior("beta(1,1)", class = "b", coef = "cyl") + # Allows both positive and negative effects
  set_prior("normal(0,5)", class = "b", coef = "disp") + # Allows both positive and negative effects
  set_prior("normal(0,10)", class = "b", coef = "wt") # Only negative effects allowed

myblm2 <- brm(myform2, data=mydf, family = gaussian(), prior = mypriors2, cores = 4, chains = 4, iter = 1000)
summary(myblm2)

plot(myblm2) # Plot the parameter distributions
marginal_effects(myblm2, ask=FALSE) # Plot what happens with response when each variable in the model increase and decrease
pp_check(myblm2, nsamples = 30) # Check posterior predictive check
bayes_R2(myblm2) # Check the R2 of the model the Bayesian way

mysamples2 <- as.mcmc(myblm2) # Check correlation plots between effects of different variables
mcmc_scatter(mysamples2, pars = c("b_wt", "sigma"))
mcmc_scatter(mysamples2, pars = c("b_wt", "b_cyl"))
mcmc_scatter(mysamples2, pars = c("b_wt", "b_hp"))
mcmc_pairs(mysamples2, pars = c("b_wt", "b_hp", "b_cyl", "b_disp"))

