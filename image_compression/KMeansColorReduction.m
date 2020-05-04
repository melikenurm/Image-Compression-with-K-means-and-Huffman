function [outImg,palette]=KMeansColorReduction(inImgPath,noOfColors)
%Read Input Image
[ImgMat, inMap] = imread(inImgPath);
s_img = size(ImgMat);
s_map = size(inMap);

if(s_map(1) == 0)
    %sRGB Color Image
    inImg = ImgMat;
else
    %Indexed Color Image
    inImg = ind2rgb(ImgMat, inMap);
    inImg = round(inImg .* 255);
end

%K-Means
r = inImg(:,:,1);
g = inImg(:,:,2);
b = inImg(:,:,3);
inputImg = zeros((s_img(1) * s_img(2)), 3);
inputImg(:,1) = r(:);
inputImg(:,2) = g(:);
inputImg(:,3) = b(:);
inputImg = double(inputImg);
[idx, C] = kmeans(inputImg, noOfColors, 'EmptyAction', 'singleton');
palette = round(C);

%Color Mapping
idx = uint8(idx);
outImg = zeros(s_img(1),s_img(2),3);
temp = reshape(idx, [s_img(1) s_img(2)]);
for i = 1 : 1 : s_img(1)
    for j = 1 : 1 : s_img(2)
        outImg(i,j,:) = palette(temp(i,j),:);
    end
end
%Writting Output Image file
outFilename = ['_', int2str(noOfColors),'.bmp'];
%imwrite(uint8(outImg), outFilename);
