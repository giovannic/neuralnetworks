function [ ret ] = confusion_matrix(predictions, targets)
    ret = zeros(6);
    ret = confusionmat(predictions,targets);
end