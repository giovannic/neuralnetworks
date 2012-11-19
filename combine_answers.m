function [ output_args ] = combine_answers( preds )
output_args = [];

for i = 1:length(preds)
    [x, y] = max(preds(:, i));
    output_args = [output_args, y];
end

end

