function [ res ] = find_ann_emotion( anntargets, emotion )
    res = anntargets(emotion, :);
end

