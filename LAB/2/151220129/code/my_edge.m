function output = my_edge(input_image)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores  
    input_image=im2double(input_image);
    [M,N]=size(input_image);
    SX = zeros(M,N);
    SY = zeros(M,N);
%     %sobel
%     high = 1.5;
%     low = 0.5;

%     %roberts
%     high = 0.5;
%     low = 0.2;

    %prewitt
    high = 0.8;
    low = 0.5;
    gray_image = zeros(M-2,N-2);
    for i=2:M-1
        for j = 2:N-1
%             gray_image(i-1,j-1) = sobel(input_image(i-1,j-1),input_image(i-1,j),input_image(i-1,j+1),input_image(i,j-1),input_image(i,j),input_image(i,j+1),input_image(i+1,j-1),input_image(i+1,j),input_image(i+1,j+1));
%             gray_image(i-1,j-1) = roberts(input_image(i-1,j-1),input_image(i-1,j),input_image(i-1,j+1),input_image(i,j-1),input_image(i,j),input_image(i,j+1),input_image(i+1,j-1),input_image(i+1,j),input_image(i+1,j+1));
            gray_image(i-1,j-1) = prewitt(input_image(i-1,j-1),input_image(i-1,j),input_image(i-1,j+1),input_image(i,j-1),input_image(i,j),input_image(i,j+1),input_image(i+1,j-1),input_image(i+1,j),input_image(i+1,j+1));
        end
    end
    
    edge_image = zeros(M-2,N-2);
    for i = 1:M-2
        for j = 1:N-2
            if gray_image(i,j) > high
                edge_image(i,j) = 1;
            elseif gray_image(i,j) < low
                edge_image(i,j) = 0;
            elseif i==1 || j ==1 || i == M-2 || j == N-2
                edge_image(i,j) = 0;
            else
                edge_image(i,j) = -1;
            end
        end
    end
    
    for i = 2:M-3
        for j = 2:N-3
            if edge_image(i,j) == -1
                if edge_image(i-1,j-1) == 1 ||edge_image(i-1,j) == 1 ||edge_image(i-1,j+1) == 1 ||edge_image(i,j-1) == 1 ||edge_image(i,j+1) == 1 ||edge_image(i+1,j-1) == 1 ||edge_image(i+1,j) == 1 ||edge_image(i+1,j+1) == 1
                    edge_image(i,j) = 1;
                else
                    edge_image(i,j) = 0;
                end
            end
        end
    end
                
    output = logical(edge_image);
    function sobel_value = sobel(v1,v2,v3,v4,v5,v6,v7,v8,v9)
        SX= -v1+v3-2*v4+2*v6-v7+v9;
        SY= v1+2*v2+v3-v7-2*v8-v9;
        sobel_value = sqrt(SX^2 + SY^2);
    function roberts_value = roberts(v1,v2,v3,v4,v5,v6,v7,v8,v9)
        SX= abs(v9-v5);
        SY= abs(v6-v8);
        roberts_value = SX + SY;
    function prewitt_value = prewitt(v1,v2,v3,v4,v5,v6,v7,v8,v9)
        SX= -v1+v3-v4+v6-v7+v9;
        SY= v1+v2+v3-v7-v8-v9;
        prewitt_value = sqrt(SX^2 + SY^2);