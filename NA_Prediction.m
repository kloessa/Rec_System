function NA_Prediction
% Test recommender system on test dataset

% Read train dataset. Exclude row 1 and column 1 (Header and row ID)
M=dlmread("data/train.csv",",",1,1);

% Set Regularization
lambda=8;

% Set number of features
num_features = 2;

% Create utility Matrix
[UTrain]=UtilMatrix(M);

% Read test dataset. 
Test=dlmread("data/test.csv",",");

% Train Utility Matrix
[p]=train(UTrain,num_features,lambda);

% Prediction on test data
[count]=predict(p,Test,M,UTrain);

printf("you got %i clicks with a CTR of %.5f.\n", count, count/sum(Test(:,1)==0));

end
