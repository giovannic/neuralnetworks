function [ res ] = convet_to_bin( anntargets, emotion )
    res = [];
    for i = 1:length(anntargets)
           res = [res, anntargets(emotion, i)];  
    end
end

