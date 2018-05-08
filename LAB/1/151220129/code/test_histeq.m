%test histeq
I = imread('../asset/image/color.jpg');
[J] = Histogram_equalization(I);
figure, imshow(I)
figure, imshow(J)