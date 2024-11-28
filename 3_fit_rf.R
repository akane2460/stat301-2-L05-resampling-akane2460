# L05 Resampling ----
# Define and fit random forest fold data

# random processes present

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/kc_fold.rda"))

# load pre-processing/feature engineering/recipe
load(here("data/kc_recipe_tree.rda"))

# model specifications ----
# A random forest (`rand_forest()`) with the `"ranger"` engine setting `min_n = 10` and `trees = 600`. We will use the default value for `mtry`.

# set seed
set.seed(201243)

rf_spec <- 
  rand_forest(trees = 600, min_n = 10) %>%
  set_engine("ranger") %>% 
  set_mode("regression")

# define workflows ----
rf_wflow <-
  workflow() |> 
  add_model(rf_spec) |> 
  add_recipe(kc_recipe_tree)

# fit workflows/models ----
fit_rf <- fit_resamples(rf_wflow, kc_fold)

# write out results (fitted/trained workflows) ----
save(fit_rf, file = here("data/fit_rf.rda"))




