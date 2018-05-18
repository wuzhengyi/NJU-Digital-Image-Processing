input = im2bw(imread( '../doc/ans2_3.png' ), 0.1);
target = im2bw(imread('target.png'), 0.1);
output = im2bw(imread('output.png'), 0.1);
%output = im2bw(imread('target.png'), 0.1);


[score, score1, score2] = scores(target, input, output)
