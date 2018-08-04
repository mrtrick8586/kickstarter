source(file = "/Volumes/Stuff/KickstarterProjectCleanup/DataPreviousValuesOnly.R")

tic("Liquid SVM")

set.seed(123)

leastsquaresSVM.past = lsSVM(pledged_usd~.,
                             trainingnonlog,
                             do.select = TRUE,
                             partition_choice = 5,
                             grid_choice = 2,
                             folds = 10,
                             cell = 5,
                             d=1,
                             clipping = 0,
                             threads=4)

results.SVM.testing.past = predict(leastsquaresSVM.past, testingnonlog)
results_SVM.training.past = predict(leastsquaresSVM.past, trainingnonlog)
test_actuals=testingnonlog$pledged_usd
train_actuals = trainingnonlog$pledged_usd

#Model Fit for Training Data
leastsquaresSVM.MSE.Train.past=mean((results_SVM.training.past-train_actuals)^2)
leastsquaresSVM.r2.Train.past=1-(leastsquaresSVM.MSE.Train.past/var(train_actuals))
sqrt(leastsquaresSVM.MSE.Train.past)
leastsquaresSVM.r2.Train.past

#Model Fit for Testing Data
leastsquaresSVM.MSE.Test.past=mean((results.SVM.testing.past-test_actuals)^2)
leastsquaresSVM.r2.Test.past=1-(leastsquaresSVM.MSE.Test.past/var(test_actuals))
sqrt(leastsquaresSVM.MSE.Test.past)
leastsquaresSVM.r2.Test.past

toc.liquid.svm = toc(log = TRUE)

options(scipen = 999)

plot(testingnonlog$pledged_usd, results.SVM.testing.past, ylab="Predicted", xlab="Actuals", main="LS SVM Model Predicted vs. Actuals")
plot(testingnonlog$pledged_usd, testingnonlog$pledged_usd-results.SVM.testing.past, ylab="Actuals - Predicted", xlab="Actuals", main="LS SVM Model Residuals vs. Actuals")
plot(results.SVM.testing.past, testingnonlog$pledged_usd-results.SVM.testing.past, ylab="Residuals", xlab="Fitted", main="LS SVM Model Residuals vs. Fitted")

plot(testingnonlog$pledged_usd, main="Pledged vs LS SVM Predicted", ylab = 'Pledged')
points(testingnonlog$pledged_usd, results.SVM.testing.past, col = 'red', pch=1)
