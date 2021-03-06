% Reading the data from file. textscan allows us to read data in specific
% format
fid = fopen('machine.data.txt', 'r');
C = textscan(fid, '%s%s%u%u%u%u%u%u%u%u', 'Delimiter', ',');

X = [C{3}, C{4}, C{5}, C{6}, C{7}, C{8}];
y = [C{9}];
X = double(X);
y = double(y);
% Now that we have the data, in matrices X - predictive attributes, y -
% goal field

% This is to randomly bifurcate the data into a training set and a test
% set. As instructed, we split the data 50-50 into training, test sets
% p = randperm(209)
% train = p(1:100);
% test =  p(101:end);

test = [108,23,13,73,130,169,184,4,76,179,45,6,193,8,44,200,207,102,203,173,84,3,140,141,68,38,187,150,98,156,117,29,136,209,90,125,89,80,53,16,175,115,111,164,40,9,83,60,42,126,163,132,147,198,199,120,131,181,186,77,161,62,32,11,92,127,172,34,124,165,166,133,171,202,138,70,28,142,109,188,71,31,22,101,86,144,205,139,35,118,5,39,116,52,81,190,137,129,43,106,204,72,26,112,182,94,189,180,93;];
train = [192,54,59,51,10,97,55,143,146,110,65,66,185,1,128,47,67,49,159,197,99,107,95,58,114,12,149,148,123,134,82,157,17,88,25,48,158,119,20,19,194,104,56,195,74,75,96,176,162,183,69,151,14,174,18,113,167,2,168,46,160,152,170,196,21,91,37,201,121,208,78,61,206,103,15,30,41,178,155,87,153,24,154,27,100,145,191,122,36,7,85,64,63,105,57,177,135,79,50,33;];
% We now have a training set of size 100, which is convenient for
% performing 10-fold cross-validation and a test data set of 109 samples.

% LEAST SQUARE REGRESSION

Xtrain = X(train,:,:,:,:,:);
Xtest =  X(test,:,:,:,:,:);
ytrain = y(train);
ytest = y(test);

% Calculate the model parameter for a Least Square Regression 
b1 = (Xtrain'*Xtrain)\(Xtrain'*ytrain);

% Calculating the mean square error for training set and test set based on
% prediction from Least Square Regression model
trainMseLSE = mean((ytrain - Xtrain*b1).^2)
testMseLSE = mean((ytest - Xtest*b1).^2)

% RIDGE REGRESSION

% Cross validation is required here to estimate the value of lambda, the
% ridge regression parameter

% Dividing the training set into 10 equal folds, and selecting the sets for
% each cross-validation iteration
x = ones(10,1)'*10;
B = mat2cell(train,1,x);
i = nchoosek(1:10, 9);

% A set of 50 points in the log space (-10, 10) is chosen for lambda
lambdas = logspace(-10,10);
NL = length(lambdas);

cvMse = zeros(NL,1);

for k=1:NL,
    mse = 0;
    lambda = lambdas(k);
    for j=1:size(i,1),
        cvtrainind = cell2mat(B(i(j,:)));
        cvtestind = B{setdiff(1:10, i(j,:))};
        % The training and test sets for each cross-validation iteration is
        % constructed here
        Xtrain = X(cvtrainind,:,:,:,:,:);
        Xtest = X(cvtestind,:,:,:,:,:);
        ytrain = y(cvtrainind);
        ytest = y(cvtestind);
        % The regression model is calculated for each value of lambda
        b2 = (Xtrain'*Xtrain+lambda*eye(6))\(Xtrain'*ytrain);
        % The mean square error for each cross-validation error is averaged
        mse = mse + mean((ytest-Xtest*b2).^2);
    end
    cvMse(k) = mse/size(i,1);
end

% Now that we have the cross-validation mse for each value of lambda, we
% will select the lamdba with the least cvMse
[cvMsemin I] = min(cvMse);

figure(1)
plot(log(lambdas), cvMse)
title('MSE (cross-validation) for different \lambda')
xlabel('log-lambda')
ylabel('Mean Square Error (Cross Validation)')

%Required Lambda is 
lambda_opt = lambdas(I);
b2 = (Xtrain'*Xtrain+lambda_opt*eye(6))\(Xtrain'*ytrain);
% Calculate the training and test error based on the optimal value of
% lambda for the Ridge Regression model
lambda_opt
trainMseRidge = mean((ytrain - Xtrain*b2).^2)
testMseRidge = mean((ytest - Xtest*b2).^2)



