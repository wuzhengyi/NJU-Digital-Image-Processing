%DIP16 Assignment 3
maindir = '../image';
subdir  = dir( maindir );

for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir )
        continue;
    end

    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );
    png = dir( subdirpath )               % ���ļ������Һ�׺Ϊpng���ļ�

    for j = 1 : length( png )
%     for j=5:5
        pngpath = fullfile( maindir, subdir( i ).name, png( j ).name);
        image = imread( pngpath );
        
        bw=im2bw(image, 0.1);
        figure;imshow(image);
        processed_image = my_imageprocessing(bw); % ���һ��
        processed_image = my_imageprocessing(processed_image); % �������
        processed_image = my_imageprocessing(processed_image); % �������
        processed_image = my_imageprocessing(processed_image); % ����Ĵ�
        figure;imshow(processed_image);
%         pngname=str(j)+'-p.png';
        imwrite(processed_image,'./p.png');
    end
end
