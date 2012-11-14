function [ new_predictions ] = convert_preds( predictions )
%SHIT and needs to be changed

temp               = [];
new_predictions    = [];

for i = 1:length(predictions)
   temp(:, i) = convert_sub(predictions(:, i)); 
end

for i = 1:length(predictions)
 new_predictions(i, 1) = max(temp(:, i));
end

end

function [new_col] = convert_sub(col)
    max_dis = max(col);
    for i = 1:length(col)
       if  col(i) == max_dis
          col(i) = i;
       else
          col(i) = 0; 
       end
    end
    new_col = col;
end