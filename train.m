function [p]=train(UtTrain,num_features,lambda)
% Function [p]=train(UtTrain,num_features,lambda) trains recommender system on train dataset using linear regression with regularization    
% Input: Utility matrix of trainset (UtTrain)
%        Number of features for dimensionality reduction (num_features)
%        Regularization parameter (lambda)
% Output: (num_items x num_users) prediction matrix (p) 
%
%

% Exclude item and user which have most ratings from utility matrix 
UtTrain=UtTrain(2:end,2:end)';

% Create Matrix containing 1 if and only if user read an article
RTrain=0~=UtTrain;

% Useful Values
num_items= size(UtTrain, 1);
num_users = size(UtTrain, 2);

% Set Initial Parameters (U, V)
U = randn(num_items, num_features);
V = randn(num_users, num_features);

% Fold initial parameters
initial_parameters = [U(:); V(:)];

% Set options for fmincg 
options = optimset('GradObj', 'on', 'MaxIter',100);

% Minimize Costfunction
theta = fmincg (@(t)(cofiCostFunc(t, UtTrain, RTrain, num_users, num_items, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and V
U = reshape(theta(1:num_items*num_features), num_items, num_features);
V = reshape(theta(num_items*num_features+1:end), ...
                num_users, num_features);

% Prediction Matrix
p = U * V';

end
