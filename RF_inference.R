library(ranger)
library(stringr)

# read data for random forest model
rflist = readRDS(file.path("data", "ranger.rds"))
signalwoerter = readRDS(file.path("data", "signal.rds"))
signalwoerter = signalwoerter[names(signalwoerter) %in% names(rflist)]

# init function
random_forest = function(text, check_crit=1:10){
  sapply(check_crit, function(k){
    words = unique(signalwoerter[[k]])
    X = t(sapply(words, function(w) str_count(text, w)))
    colnames(X) = paste0("F", seq(colnames(X)))
    c("NICHT ERFÜLLT", "ERFÜLLT")[1 + predict(rflist[[k]], data = X)$predictions]
  })
}

# inference
random_forest("Hier ist ein Beispieltext über ein neues Medikament.")
