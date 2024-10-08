# Beyond Fact-Checking: Harnessing AI for News Quality Assessment

This repository contains the scripts and data used for the research paper titled "Beyond Fact-Checking: Harnessing AI for News Quality Assessment". The research explores the potential of machine learning (ML) and large language models (LLMs) for the semi-automated quality assessment of scientific news articles.

## About this Research

Reliable scientific information is crucial for forming public opinion and making economic, social, or health-related decisions. This study explores the potential of ML models including LLMs to automate the quality assessment of various types of articles, aiming to assist editors and laypersons in evaluating the quality of scientific information. The ML models (Random Forest and Naïve Bayes) are trained on 240 pairs of medical articles and expert assessments of these articles that were provided by the German [*Medien-Doktor* (MD)](https://medien-doktor.de/) project. This data includes evaluations based on ten specific quality criteria for good medical reporting. The LLMs are prompted with the article to be evaluated and the ten MD quality criteria, respectively. The analysis reveals that most models nearly reach the accuracy of human expert reviews. Notably, our Random Forest classifier is competitive with even the most advanced LLMs. Our results demonstrate the usefulness of automated quality assessment tools in the domain of science communication. The detailed results and figures are available in the research paper.

## Repository Structure

The repository is organized as follows:

```{kotlin}
Beyond-Fact-Checking/
│
├── data/
│   └── all_eval_data.json
|   └── criteria.csv
|   └── naive_bayes_model.rds
|   └── prompts.csv
|   └── ranger.rds
|   └── signal.rds
|   └── raw_texts.csv
│
├── .gitignore
├── Claude_inference.ipynb
├── GPT_inference.ipynb
├── LLaMA_inference.ipynb
├── Mistral_inference.ipynb
├── NB_inference.R
├── README.md
├── RF_inference.R
├── create_plots.R
```

## Folders and Files

- data/: Contains the data files used in the analysis. The folder contains the evalatuations of all models and the human experts for each of the 28 test articles.
- `data/all_eval_data.json`: JSON file that contains all the predictions from all models. Our results are based on this data.
- `data/criteria.csv`: The MD criteria that the LLMs get to see in the prompt.
- `data/naive_bayes_model.rds`: R-Object containing the NB models.
- `data/prompts.csv`: File that shows the wording of the different prompt techniques tested.
- `data/ranger.rds`: R-Object containing the RF models.
- `data/signal.rds`: R-Object containing signal words for the RF models.
- `data/raw_texts.csv`: CSV file containing the documents to be evaluated.
- `Claude_inference.ipynb`: Jupyter Notebook that was used to obtain the predicition of Claude 3.5-Sonnet. 
- `GPT_inference.ipynb`: Jupyter Notebook that was used to obtain the predicition of the GPT models GPT-4o, GPT-4-1106-preview, GPT-4-turbo, and GPT-3.5.-turbo-0125. 
- `LLaMA_inference.ipynb`: Jupyter Notebook used to obtain the predictions of LLaMA-3-8B and LLaMA-3-70B.
- `Mistral_inference.ipynb`: Jupyter Notebook for running inference using the Mistral models open-mistral-7b, open-mixtral-8x22b, and mistral-large-latest.
- `NB_inference.R`: R script for running inference using the Naïve Bayes Model.
- `RF_inference.R`: R script for running inference using the Random Forest Classifier.
- `create_plots.R`: R script for creating the plots presented in the paper.

**Please note:** To use the LLM inference scripts, you will need to pass an OpenAI, Mistral, or Groq API key, respectively.

## Usage
To reproduce the analysis, follow these steps:

**1. Clone the repository:**
```{bash}
git clone https://github.com/Piece-Of-Schmidt/Beyond-Fact-Checking.git
cd Beyond-Fact-Checking
```

**2. Set up your environment:**
- Ensure you have Jupyter Notebook installed for running the `.ipynb` files.
- For the `.R` script, make sure you have R installed along with the required packages.

**3. Run the inference notebooks:**
- Open each of the `.ipynb` files in a Jupyter Notebook and run the cells to perform inference using the respective models. You will need to pass an OpenAI, Mistral, or Groq API key, respectively.
- To perform inference using the ML models, open each of the `.R` files in RStudio and run the code.

**4. Generate plots:**
- Run the `create_plots.R` script in an R environment to generate the visualizations used in the research paper.


## Contributors

- Tobias Schmidt (Institute and School of Journalism, Chair of Economic Policy Journalism, TU Dortmund University, Germany)
- Jonas Rieger (Department of Statistics, TU Dortmund University, Germany)
- Jörg Rahnenführer (Department of Statistics, TU Dortmund University, Germany)
- Astrid Viciano (Institute and School of Journalism, Chair of Science Journalism, TU Dortmund University, Germany)
- Holger Wormer (Institute and School of Journalism, Chair of Science Journalism, TU Dortmund University, Germany)

## Acknowledgments

This work was partly funded by the "Innovationsfonds" of the German Science Journalists' Association (Wissenschaftspressekonferenz). The presented analyses were aided by resources made available by the project "Trustworthy Performance Evaluation of Large Language Models" of the Research Center Trustworthy Data Science and Security.

## Contribution

Please let us know if you feel that there is anything missing that we could add. For bug reports, comments and questions please use the [issue tracker](https://github.com/Piece-Of-Schmidt/Beyond-Fact-Checking/issues).

