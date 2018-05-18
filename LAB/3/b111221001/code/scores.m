%%% ATTENTION! Three images should be binary images. Refer to helpful
%%% method like im2bw()
% @target_image is the ground-truth image.
% #score1 is the target pixels recall.
% #score2 is the tedundancy elimination rate.
% #score* the larger, the better.
function [score, score1, score2] = scores(target_image, input_image, output_image)
    DumpPixels = input_image - target_image;
    
    TargetPixelsCount = sum(sum(target_image));
    DumpPixelsCount = sum(sum(DumpPixels));
    
    score1 = sum(sum(output_image(target_image>0)));
    score2 = sum(sum(output_image(DumpPixels>0)));
    score = score1 - score2 * TargetPixelsCount / DumpPixelsCount;
    score1 = score1 / TargetPixelsCount;
    score2 = 1 - score2 / DumpPixelsCount;
end