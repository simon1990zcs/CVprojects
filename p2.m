%read the images 
imageSet = 1;
imgs = getImgs(imageSet);

%get R matrix
[Ex2Sum, Ey2Sum, ExEySum] = getSumMatrix(imgs);
R = getRmatrix(Ex2Sum, Ey2Sum, ExEySum);

%threshold R matrix
threshold = 1.0e8;
cornerMask = uint8(R > threshold);
edgeMask = uint8(R < -threshold);
mask = cornerMask + edgeMask;


%display 
row = size(imgs, 1);
col = size(imgs, 2);

result = zeros(row, col);
for i = 1 : row
    for j = 1 : col
        result(i, j) = imgs(i, j, 1) * (1 + cornerMask(i, j, 1));
    end
end

imtool(mask(:,:,1), [0, 1]);
imtool(result, [0,255]);

