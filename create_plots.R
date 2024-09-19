library(jsonlite)
library(ggplot2)
library(reshape2)


# load data
eva = jsonlite::fromJSON("data/all_eval_data.json")

# decide whether data shall be restricted to best models
only_keep_best_prompt_per_model = T

# if so, do:
if(only_keep_best_prompt_per_model){
  
  # keep all results in special variable
  all_results_ALL = eva
  
  # restrict list to best cases per model
  all_results = eva[c(
    "gpt-3.5-turbo-0125_as",
    "gpt-4o_es",
    "gpt-4-turbo_as",
    "gpt-4-1106-preview_as",
    "mistral_7b_as",
    "mixtral_es",
    "mistral_er",
    "llama8_er",
    "llama70_as",
    "claude_es",
    "NB",
    "RF",
    "human_low",
    "human_high",
    "gold"
  )]
  
  # give short names
  names(all_results)[1:9] = c("gpt-3.5", "gpt-4o", "gpt-4-turbo", "gpt-4-preview", "mistral_7b", "mixtral", "mistral_large", "llama_8b", "llama_70b", "claude-3.5")
  
}else all_results = eva



# -------------------------------------------------------------------------
# Start analysis
# -------------------------------------------------------------------------


# Table for Appendix ------------------------------------------------------

all_results_ALL_performance = sapply(all_results_ALL, function(result, gold=all_results_ALL[["gold"]], n_documents=28){
  comparison = result == gold
  apply(comparison, 1, function(criterion) sum(criterion) / n_documents)
})
rownames(all_results_ALL_performance) = paste0("C", 1:10)
(appendix = t(all_results_ALL_performance))



# Overall Model Performance -----------------------------------------------

# calculate result
overall_performance = sapply(all_results, function(result, gold=all_results[["gold"]], n_crits_overall=280){
  sum(result == gold) / n_crits_overall
})

# reshape data
input_data = data.frame(model = names(all_results),
                        value = reshape2::melt(overall_performance),
                        group = c(rep("GPT", 4), rep("Mistral", 3), rep("LLaMA", 2), "Claude", rep("ML", 2), rep("Experts", 3)),
                        row.names = NULL)

# plot
ggplot(input_data[-nrow(input_data),], aes(model, value, fill=group)) +
  geom_col(color="blue3", show.legend = F) +
  geom_text(aes(label=sprintf("%.2f", value)), vjust=-0.5, color="grey30", size=4) +
  theme_classic() +
  labs(x=NULL, y=NULL) +
  scale_x_discrete(limits = names(all_results)[-nrow(input_data)]) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=12),
        axis.text.y = element_text(size=12)) + 
  scale_fill_manual(values = c("azure", "azure2", "azure3", "lightblue1", "lightblue2", "lightblue3")) +
  ylim(0, 0.9)



# Performance per Criterion -----------------------------------------------

# calculate result
performance_pc = sapply(all_results, function(result, gold=all_results[["gold"]], n_documents=28){
  comparison = result == gold
  apply(comparison, 1, function(criterion) sum(criterion) / n_documents)
})

# reshape data
input_data = reshape2::melt(performance_pc[,-ncol(performance_pc)])
input_data$Var1 = sub("Criterion", "", input_data$Var1)

# plot
ggplot(input_data, aes(x=Var2, y=Var1, fill=value)) +
  geom_tile(alpha=0.6, color="white", show.legend = TRUE) +
  geom_text(aes(label=sprintf("%.2f", value)), color="black", size=4) +
  theme_classic() +
  labs(x="Model", y="Crtirerion", fill="Accuracy") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=12),
        axis.text.y = element_text(size=12),
        legend.position = "bottom")+
  scale_fill_gradient2(low="red3", high="blue3", mid="white", midpoint = 0.5) +
  scale_y_discrete(limits = as.character(10:1)) +
  
  annotate("rect", xmin=0.5, xmax=10.5, ymin=0.5, ymax=10.5, color="grey30", fill=NA, linewidth=.7, linetype="solid") +  # LLMs
  annotate("rect", xmin=10.5, xmax=12.5, ymin=0.5, ymax=10.5, color="grey30", fill=NA, linewidth=.7, linetype="solid") +  # RF and NB
  annotate("rect", xmin=12.5, xmax=14.5, ymin=0.5, ymax=10.5, color="grey30", fill=NA, linewidth=.7, linetype="solid")  # Human Gold Standards



# Ampel-Plot --------------------------------------------------------------

lthresh = 5
hthresh = 8

# select models
models_to_compare = c("gpt-4-preview", "RF", "claude-3.5", "gold")
short_names = c("gpt-4", "RF", "claude", "experts")

# calculate result
gate_keepers = sapply(models_to_compare, function(model){
  comp = apply(all_results[[model]], 2, function(col) sum(col == "ERFÜLLT"))
  ifelse(comp<lthresh, "Low", ifelse(lthresh<=comp & comp<hthresh, "Mid", "High"))
})

# reshape data
gate_keepers = reshape2::melt(gate_keepers)
gate_keepers$Var1 = sub("utachten", "", gate_keepers$Var1)
gate_keepers$Var2 = rep(short_names, each=28)

# plot
ggplot(gate_keepers, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile(alpha=0.8, color="azure", linewidth=0.05) +
  scale_fill_manual(values=c("aquamarine3", "coral", "azure2")) +
  theme_classic() +
  labs(x = NULL, y=NULL, fill="Predicted Article Quality") +
  theme(
    axis.text.y=element_text(angle = 90, hjust = 0.5, size = 12),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    legend.position = "bottom") +
  scale_y_discrete(limits = short_names) +
  annotate("rect", xmin=0.5, xmax=28.5, ymin=3.5, ymax=4.5, color="grey2", fill=NA, linewidth=.6, linetype="dotted")



