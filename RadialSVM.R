source(file = "/Volumes/Stuff/KickstarterProjectCleanup/DataPreviousValuesOnly.R")

tic("RadialSVM")

set.seed(123)

trctrl = trainControl(method = "cv",
                      number = 10,
                      allowParallel = TRUE
)

grid = expand.grid(sigma = c(.01, .015, 0.2),
                   C = c(0.75, 0.9, 1, 1.1, 1.25))

model.svmRadial.Past = train(pledged_usd~.,
                        data = trainingnonlog,
                        method ="svmRadial",
                        trControl = trctrl,
                        preProcess = c("center", "scale"),
                        tuneGrid = grid,
                        na.action = na.omit,
                        tuneLength = 5
)

predicted.svmRadial.past.Training = predict(model.svmRadial.Past, trainingnonlog)
predicted.svmRadial.past.Testing = predict(model.svmRadial.Past, testingnonlog)
train_actuals = trainingnonlog$pledged_usd
test_actuals = testingnonlog$pledged_usd

#Model Fit for Training Data
svmRadial.past.MSE.Train=mean((predicted.svmRadial.past.Training-train_actuals)^2)
svmRadial.past.r2.Train=1-(svmRadial.past.MSE.Train/var(train_actuals))
sqrt(svmRadial.past.MSE.Train)
svmRadial.past.r2.Train

#Model Fit for Testing Data
svmRadial.past.MSE.Test=mean((predicted.svmRadial.past.Testing-test_actuals)^2)
svmRadial.past.r2.Test=1-(svmRadial.past.MSE.Test/var(test_actuals))
sqrt(svmRadial.past.MSE.Test)
svmRadial.past.r2.Test

toc(log = TRUE)

#Plots
options(scipen = 999)
source(file = "/Volumes/Stuff/FinalKickstarterStuff/DataPreviousValuesOnly.R")
plot(testingnonlog$pledged_usd, predicted.svmRadial.past.Testing, ylab="Predicted", xlab="Actuals", main="Radial SVM Model Predicted vs. Actuals")
plot(testingnonlog$pledged_usd, testingnonlog$pledged_usd-predicted.svmRadial.past.Testing, ylab="Actuals - Predicted", xlab="Actuals", main="Radial SVM Model Residuals vs. Actuals")

plot(testingnonlog$pledged_usd, main="Pledged vs Linear SVM Predicted", ylab = 'Pledged', col = 'black')
points(testingnonlog$pledged_usd, predicted.svmRadial.past.Testing, col = 'red', pch=1)
