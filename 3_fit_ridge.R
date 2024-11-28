# L05 Resampling ----
# Define and fit ridge

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
# A ridge regression (`linear_reg(penalty = 0.01, mixture = 0)`), with the `"glmnet"` engine,
ridge_spec <- 
  linear_reg(penalty = 0.01, mixture = 0) %>% 
  set_engine("glmnet") %>% 
  set_mode("regression")

# define workflows ----
ridge_wflow <-
  workflow() |> 
  add_model(ridge_spec) |> 
  add_recipe(kc_recipe_lm)

# fit workflows/models ----
fit_ridge <- fit_resamples(ridge_wflow, kc_fold)

# write out results (fitted/trained workflows) ----
save(fit_ridge, file = here("data/fit_ridge.rda"))

