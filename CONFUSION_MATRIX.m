function [ ret ] = CONFUSION_MATRIX(predictions, targets)
    ret = zeros(6);
    ret = confusionmat(predictions,targets);
end