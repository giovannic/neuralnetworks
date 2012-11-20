function [ ret ] = CREATE_POSNEG( emotions, emotion )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ret = [];
for i = 1:length(emotions)
     if emotions(i) == emotion
         ret = [ret, 1];
     else
         ret = [ret, 0];
     end
end

end

