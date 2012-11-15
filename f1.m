function [ ret ] = f1( predictions, targets )
    cm = confusion_matrix(predictions, targets);

    %recall rates, precision rates & f1
    recall_rates = zeros(6,1);
    precision_rates = zeros(6,1);
    ret = zeros(6,1);
    for emotion = 1:6,
        recall_rates(emotion) = cm(emotion,emotion) / sum(cm(emotion,:)) * 100;
        precision_rates(emotion) = cm(emotion,emotion) / sum(cm(:,emotion)) * 100;
        ret(emotion) = 2 * precision_rates(emotion) * recall_rates(emotion) / (precision_rates(emotion) + recall_rates(emotion));
    end
end