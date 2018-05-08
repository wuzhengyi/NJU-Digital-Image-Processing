function output = my_edge_marr(input_image)
% input:gray image output:image edge logical
% marr
[m,n] = size(input_image);
e = false(m,n);
sigma = 2.5;
row = 2:m-1; 
col=2:n-1;
op = fspecial('log',ceil(sigma*3) * 2 + 1,sigma);

op = op - sum(op(:))/numel(op); % make the op to sum to zero
b = imfilter(input_image,op,'replicate');

thresh = 0.75 * sum(abs(b(:)),'double') / numel(b);

% Look for the zero crossings
[r,c] = find(( b(row,col) < 0 & b(row,col+1) > 0 & abs( b(row,col)-b(row,col+1) ) > thresh )...
    |(b(row,col-1) > 0 & b(row,col) < 0 & abs( b(row,col-1)-b(row,col) ) > thresh)...
    |(b(row,col) < 0 & b(row+1,col) > 0 & abs( b(row,col)-b(row+1,col) ) > thresh)...
    |(b(row-1,col) > 0 & b(row,col) < 0 & abs( b(row-1,col)-b(row,col) ) > thresh));   
e((r+1) + c*m) = 1;

% check to see if there are any points where the LoG was precisely zero:
[rz,cz] = find( b(row,col)==0 );
if ~isempty(rz)
    zero = (rz+1) + cz*m;   % Linear index for zero points
    zz = ((b(zero-1) < 0 & b(zero+1) > 0 & abs( b(zero-1)-b(zero+1) ) > 2*thresh)...
        |(b(zero-1) > 0 & b(zero+1) < 0 & abs( b(zero-1)-b(zero+1) ) > 2*thresh)...
        |(b(zero-m) < 0 & b(zero+m) > 0 & abs( b(zero-m)-b(zero+m) ) > 2*thresh)...
        |(b(zero-m) > 0 & b(zero+m) < 0 & abs( b(zero-m)-b(zero+m) ) > 2*thresh));     
    e(zero(zz)) = 1;
end
output = e;
end

