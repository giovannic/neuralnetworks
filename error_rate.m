function [ ret ] = error_rate( predictions, targets )
    ret = length(predictions(predictions ~= targets))/length(y);
end