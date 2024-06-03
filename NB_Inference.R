library(quanteda)
library(quanteda.textmodels)
library(caret)

# read data for naive bayes model
models = readRDS(file.path("data", "naive_bayes_model.rds"))

# init function
naive_bayes = function(text, check_crit=1:10){
  dfm = tokens(text, remove_punct = T, remove_symbols = T, remove_url = T, remove_separators = T) %>%
    dfm(tolower=FALSE)
  as.character(sapply(models[check_crit], function(model){
    dfm = dfm_match(dfm, features = featnames(model$x)) # match DFMs
    predict(model, newdata = dfm)
  }))
}

# inference
naive_bayes("Hier ist ein Beispieltext über ein neues Medikament.")
