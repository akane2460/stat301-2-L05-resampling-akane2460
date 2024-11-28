# L05 Resampling ----
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data----
load(here("data/kc_train.rda"))

# lm----
kc_recipe_lm <- recipe(price_log10 ~ ., data = kc_train) |> 
  update_role(price, new_role = "orig_scale") |> 
  step_rm(id, date, zipcode) |> 
  step_log(
    sqft_living, 
    sqft_lot,
    sqft_above,
    sqft_living15,
    sqft_lot15,
    base = 10
  ) |> 
  step_mutate(sqft_basement = if_else(sqft_basement == 0, 1, 0)) |> 
  step_ns(lat, deg_free = 5) |> 
  step_zv(all_predictors()) |> 
  step_normalize(all_numeric_predictors())

# kc_recipe_lm |>
#   prep() |>
#   bake(new_data = NULL) |>
#   glimpse()

# tree-based ----
kc_recipe_tree <- recipe(price_log10 ~ ., data = kc_train) |> 
  update_role(price, new_role = "orig_scale") |> 
  step_rm(id, date, zipcode) |> 
  step_log(
    sqft_living, 
    sqft_lot,
    sqft_above,
    sqft_living15,
    sqft_lot15,
    base = 10
  ) |> 
  step_mutate(sqft_basement = if_else(sqft_basement == 0, 1, 0)) |> 
  step_zv(all_predictors()) |> 
  step_normalize(all_numeric_predictors())

# kc_recipe_tree |>
#   prep() |>
#   bake(new_data = NULL) |>
#   glimpse()

# write out recipes----
save(kc_recipe_lm, file = here("data/kc_recipe_lm.rda"))
save(kc_recipe_tree, file = here("data/kc_recipe_tree.rda"))
