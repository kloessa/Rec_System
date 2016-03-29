function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_items, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_items, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%
%   Input: Vector containing parameters for minimalization (params)
%          Utility matrix (Y)
%          Matrix containing 1 if and only if user read an atricle (R)
%          Number of users (num_users)
%          Number of articles (num_items)
%          Number of features (num_features) 
%   Output: Cost function (J)
%           Gradient of cost function (grad)

% Unfold the U and V matrices from params
X = reshape(params(1:num_items*num_features), num_items, num_features);
Theta = reshape(params(num_items*num_features+1:end), ...
                num_users, num_features);

% Initialize values
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% Computing costfunction and gradient
J=1/2*sum(sum((R.*(X*Theta')-R.*Y).^2))+lambda/2*(sum(sum(Theta.^2))+sum(sum(X.^2)));
X_grad=(R.*(X*Theta')-R.*Y)*Theta+lambda.*X;
Theta_grad=(R.*(X*Theta')-R.*Y)'*X+lambda.*Theta;

% Folding the gradient
grad = [X_grad(:); Theta_grad(:)];

end
