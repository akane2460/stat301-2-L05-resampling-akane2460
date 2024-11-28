# L05 Resampling ----
# Define and fit nn

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(kknn)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/kc_fold.rda"))

# load pre-processing/feature engineering/recipe
load(here("data/kc_recipe_lm.rda"))

# model specifications ----
# A nearest neighbor (`nearest_neighbor()`) with the `kknn` engine setting and `neighbors` set to 20.
nn_spec <- 
  nearest_neighbor(neighbors = 20) |> 
  set_engine("kknn") |> 
  set_mode("regression")

# define workflows ----
nn_wflow <-
  workflow() |> 
  add_model(nn_spec) |> 
  add_recipe(kc_recipe_lm)

# fit workflows/models ----
fit_nn <- fit_resamples(nn_wflow, kc_fold)

# write out results (fitted/trained workflows) ----
save(fit_nn, file = here("data/fit_nn.rda"))
