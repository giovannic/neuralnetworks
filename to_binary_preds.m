function [ binary_predictions ] = to_binary_preds( predictions )
%SHIT and needs to be changed

binary_predictions = [];

for i = 1:length(predictions)
   binary_predictions(:, i) = convert_sub(predictions(:, i)); 
end

end

function [new_col] = convert_sub(col)
    max_dis = max(col);
    for i = 1:length(col)
       if  col(i) == max_dis
          col(i) = 1;
       else
          col(i) = 0; 
       end
    end
    new_col = col;
end