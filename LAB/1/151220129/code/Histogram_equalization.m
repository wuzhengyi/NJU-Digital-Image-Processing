function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    
%     output = hist_RGB_equal(input_image);
    output = hist_HSV_equal(input_image);
%     output = hist_HSI_equal(input_image);


else
    %this is a gray image
    [output] = hist_equal(input_image);
end
    function [output2] = hist_equal(input_channel)
        %you should complete this sub-function
        input_channel=im2double(input_channel);

        [M,N]=size(input_channel);
        [counts,x]=imhist(input_channel);
        location=find(counts~=0);
        MinCDF=min(counts(location));
        for j=1:length(location)
            CDF=sum(counts(location(1:j)));
            P=input_channel==x(location(j));
            input_channel(P)=(CDF-MinCDF)/(M*N-MinCDF);
        end
        [output2] = input_channel;
    end
    
    function [output3] = hist_RGB_equal(input_RGB_image)
        r=input_RGB_image(:,:,1);
        v=input_RGB_image(:,:,2);
        b=input_RGB_image(:,:,3);
        r1 = hist_equal(r);
        v1 = hist_equal(v);
        b1 = hist_equal(b);
        output3 = cat(3,r1,v1,b1); 
    end

    function [output4] = hist_HSV_equal(input_HSV_image)
        hv=rgb2hsv(input_HSV_image); 
        %可以通过下面的程序看一幅图的HSV三个通道 
        H=hv(:,:,1);
        S=hv(:,:,2);
        V=hv(:,:,3);
        V1 = hist_equal(V);
        output4 = cat(3,H,S,V1);
        output4 = hsv2rgb(output4);
    end
    
    function [output5] = hist_HSI_equal(input_HSI_image)
        hv=rgb2hsi(input_HSI_image); 
        %可以通过下面的程序看一幅图的HSV三个通道 
        H=hv(:,:,1);
        S=hv(:,:,2);
        I=hv(:,:,3);
        I1 = hist_equal(I);
        output5 = cat(3,H,S,I1);
        output5 = hsi2rgb(output5);
        
        function hsi = rgb2hsi(rgb)    
            rgb = im2double(rgb);   
            r = rgb(:, :, 1);   
            g = rgb(:, :, 2);   
            b = rgb(:, :, 3);   

            % Implement the conversion equations.   
            num = 0.5*((r - g) + (r - b));   
            den = sqrt((r - g).^2 + (r - b).*(g - b));   
            theta = acos(num./(den + eps));   

            H = theta;   
            H(b > g) = 2*pi - H(b > g);   
            H = H/(2*pi);   

            num = min(min(r, g), b);   
            den = r + g + b;   
            den(den == 0) = eps;   
            S = 1 - 3.* num./den;   

            H(S == 0) = 0;   

            I = (r + g + b)/3;   

            % Combine all three results into an hsi image.   
            hsi = cat(3, H, S, I); 
        end
        
        function rgb = hsi2rgb(hsi)      
            H = hsi(:, :, 1) * 2 * pi;   
            S = hsi(:, :, 2);   
            I = hsi(:, :, 3);   
            % Implement the conversion equations.   
            R = zeros(size(hsi, 1), size(hsi, 2));   
            G = zeros(size(hsi, 1), size(hsi, 2));   
            B = zeros(size(hsi, 1), size(hsi, 2));   
            % RG sector (0 <= H < 2*pi/3).   
            idx = find( (0 <= H) & (H < 2*pi/3));   
            B(idx) = I(idx) .* (1 - S(idx));   
            R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./ cos(pi/3 - H(idx)));   
            G(idx) = 3*I(idx) - (R(idx) + B(idx));   
            % BG sector (2*pi/3 <= H < 4*pi/3).   
            idx = find( (2*pi/3 <= H) & (H < 4*pi/3) );   
            R(idx) = I(idx) .* (1 - S(idx));   
            G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ./ cos(pi - H(idx)));   
            B(idx) = 3*I(idx) - (R(idx) + G(idx));   
            % BR sector.   
            idx = find( (4*pi/3 <= H) & (H <= 2*pi));   
            G(idx) = I(idx) .* (1 - S(idx));   
            B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./cos(5*pi/3 - H(idx)));   
            R(idx) = 3*I(idx) - (G(idx) + B(idx));   
            % Combine all three results into an RGB image.  Clip to [0, 1] to   
            % compensate for floating-point arithmetic rounding effects.   
            rgb = cat(3, R, G, B);   
            rgb = max(min(rgb, 1), 0);
        end
    end
end