%read the images 
imageSet = 1;
imgs = getImgs(imageSet);

%get R matrix
[Ex2Sum, Ey2Sum, ExEySum, Eo] = getSumMatrix(imgs);
R = getRmatrix(Ex2Sum, Ey2Sum, ExEySum);

%threshold R matrix
threshold = 1.0e9;
cornerMask = uint8(R > threshold);
edgeMask = uint8(R < -threshold);
mask = cornerMask + edgeMask;

%Thresholded mask
filtered_R = R .* double(cornerMask);
filtered_R = nonmax_suppression(filtered_R, Eo);
cornerMask2 = uint8(filtered_R > threshold);

%Corner feature matching


%display 
row = size(imgs, 1);
col = size(imgs, 2);

result = zeros(row, col);
for i = 1 : row
    for j = 1 : col
        result(i, j) = imgs(i, j, 1) * (1 + cornerMask2(i, j, 1));
    end
end

imtool(cornerMask(:,:,1), [0, 1]);
imtool(cornerMask2(:,:,1), [0, 1]);
imtool(result, [0,255]);

