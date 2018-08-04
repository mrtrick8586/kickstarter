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

## Prerequisites for running code
```
library(corrplot)
library(randomForest)
library(Tree)
library(MASS)
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
```
### Recommendations
When running the linear svm, radial svm, or the least squares svm you can change the parameters for the function registering the cores. Those parameters are found in the libraries.R file. It is recommended to specify the amoundt of cpu cores your system has. You can edit the line below from the libraries.R file, to generate multiple R sessions, which then runs your code in parallel.

```
  registerDoParallel(cores=4)
```

When running the least squares svm a package called liquidSVM is used. This package provides for using the same parallel processing from the doParallel package with the addition of being able to do GPU computing if you have supported hardware. There is documentation provided by the liquidSVM developers on how to install liquidSVM with support for GPU computing. In our project, GPU computing was used with Ubuntu 18.04 and CUDA 9.2. When running the code, there may be a gpu = 1 flag for the liquidSVM package, but there is no need to change that, because the package will ignore it if you don't have supported hardware. It is recommended that you have an Nvidia card that supports CUDA in order to take full advantage of the GPU computing features of liquidSVM.

## Authors

Brian Sizemore
Patrick Landis

## Acknowledgments

Thank you to Frank and Sam for teaching us the material needed to do this high level analysis.
