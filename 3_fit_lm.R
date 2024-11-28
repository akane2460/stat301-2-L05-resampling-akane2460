# L05 Resampling ----
# Define and fit lm

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
lm_spec <- 
  linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression") 

# define workflows ----
lm_wflow <-
  workflow() |> 
  add_model(lm_spec) |> 
  add_recipe(kc_recipe_lm)

# fit workflows/models ----
fit_lm <- fit_resamples(lm_wflow, kc_fold)

# write out results (fitted/trained workflows) ----
save(fit_lm, file = here("data/fit_lm.rda"))
