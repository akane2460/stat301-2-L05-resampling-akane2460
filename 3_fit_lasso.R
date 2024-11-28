# L05 Resampling ----
# Define and fit lasso

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/kc_fold.rda"))

# load pre-processing/feature engineering/recipe
load(here("data/kc_recipe_lm.rda"))

# model specifications ----
# A lasso regression (`linear_reg(penalty = 0.01, mixture = 1)`), with the `"glmnet"` engine, and
lasso_spec <- 
  linear_reg(penalty = 0.01, mixture = 1) |> 
  set_engine("glmnet") |> 
  set_mode("regression")

# define workflows ----
lasso_wflow <-
  workflow() |> 
  add_model(lasso_spec) |> 
  add_recipe(kc_recipe_lm)

# fit workflows/models ----
fit_lasso <- fit_resamples(lasso_wflow, kc_fold)

# write out results (fitted/trained workflows) ----
save(fit_lasso, file = here("data/fit_lasso.rda"))
