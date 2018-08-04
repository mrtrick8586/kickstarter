source(file = "/Volumes/Stuff/KickstarterProjectCleanup/DataPreviousValuesOnly.R")

###Linear Kernal SVM Model###Already Ran This
model.svmLinear.past = train(pledged_usd~.,
                               data = trainingnonlog,
                               method ="svmLinear",
                               trControl = trctrl,
                               preProcess = c("center", "scale"),
                               tuneGrid = grid,
                               na.action = na.omit,
                               tuneLength = 5
                             )

predicted.svmLinear.past.Training = predict(model.svmLinear.past, trainingnonlog)
predicted.svmLinear.past.Testing = predict(model.svmLinear.past, testingnonlog)
train_actuals = trainingnonlog$pledged_usd
test_actuals = testingnonlog$pledged_usd

#Model Fit for Training Data
svmLinear.past.MSE.Train=mean((predicted.svmLinear.past.Training-train_actuals)^2)
svmLinear.past.r2.Train=1-(svmLinear.past.MSE.Train/var(train_actuals))
sqrt(svmLinear.past.MSE.Train)
svmLinear.past.r2.Train

#Model Fit for Testing Data
svmLinear.past.MSE.Test=mean((predicted.svmLinear.past.Testing-test_actuals)^2)
svmLinear.past.r2.Test=1-(svmLinear.past.MSE.Test/var(test_actuals))
sqrt(svmLinear.past.MSE.Test)
svmLinear.past.r2.Test

#Plots
options(scipen = 999)
source(file = "/Volumes/Stuff/KickstarterProjectCleanup/DataPreviousValuesOnly.R")
plot(testingnonlog$pledged_usd, predicted.svmLinear.past.Testing, ylab="Predicted", xlab="Actuals", main="Linear SVM Model Predicted vs. Actuals")
plot(testingnonlog$pledged_usd, testingnonlog$pledged_usd-predicted.svmLinear.past.Testing, ylab="Actuals - Predicted", xlab="Actuals", main="Linear SVM Model Residuals vs. Actuals")
plot(predicted.svmLinear.past.Testing, testingnonlog$pledged_usd-predicted.svmLinear.past.Testing, ylab="Residuals", xlab="Fitted", main="Linear SVM Model Residuals vs. Fitted")

plot(testingnonlog$pledged_usd, main="Pledged vs Linear SVM Predicted", ylab = 'Pledged', col = 'black')
points(testingnonlog$pledged_usd, predicted.svmLinear.past.Testing, col = 'red', pch=1)
