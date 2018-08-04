# kickstarter
Class project to predict the amount raised by kickstarter projects

## Getting Started
Depending on where you start with your analysis and usage of this code there are a few steps to get the code running.

### Starting with the 'Kickstarter Scrape.R' file. 
1) Save the file 18K_Projects.csv from the shared drive or download the data from https://www.kaggle.com/tayoaki/kickstarter-dataset
2) Edit the 'Kickstarter Scrape.R' to point to the correct csv on your local machine.

### If you're wanting to run the models only
1) Save kickstarteranalysis.rda from the private shared drive. This file already has the data from the scrape and text mining.
2) Edit any file locations within data_preprocess.r and DataPreviousValuesOnly.R to point to the correct kickstarteranalysis.rda or folder where the preprocessing saves data to. 
3) The models should run after that.

#### Prerequisites for running code

library(corrplot)
library(randomForest)
library(Tree)
Library(MASS)
library(sqldf)
library(tidyverse)
library(liquidSVM)
library(caret)
library(tictoc)
library(doParallel)
library(rvest)
library(purrr)
library(tm)
library(syuzhet)
library(SnowballC)

## Authors

Brian Sizemore
Patrick Landis

## Acknowledgments

Thank you to Frank and Sam for teaching us the material needed to do this high level analysis.
