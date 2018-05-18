%in this function, you should finish the image processing function to
%extract the longitude and latitude lines using any mothods you consider 
%appropriate.
%please output the image only contains the longitude and latitude lines 
%and the backgroud.
function output = my_imageprocessing(input_image)
    [m,n]=size(input_image);
    src=input_image;
    kernel1=[   1,1,1;
                1,-2,1;
                1,1,1];
    ans1 = conv2(src,kernel1,'same');
    kernel2=[   1,1,1;
                1,-4,1;
                1,1,1];
    ans2 = conv2(src,kernel2,'same');
    kernel3=[ -1,-1,-1,-1,-1;
              -1,2,2,2,-1;
              -1,2,-2,2,-1;
              -1,2,2,2,-1;
              -1,-1,-1,-1,-1];
    ans3=conv2(src,kernel3,'same');
    ans = zeros(m,n);
    for i=1:m
        for j=1:n
            if((ans1(i,j)==0 && ans2(i,j)~=0) || (ans1(i,j)~=0 && ans2(i,j)==0))
%             if(src(i,j)==1 && ((ans3(i,j)==0 && ans2(i,j)~=0) || (ans3(i,j)~=0 && ans2(i,j)==0)))
%             if(src(i,j)==1 && ans3(i,j)==0)
                ans(i,j)=1;       
            end
        end
    end

    output=ans;
end