clear all;
imImgPath='C:\Users\Melike Nur Mermer\Desktop\testresim\biber.bmp';
img=imread(imImgPath);
cbsize=32;
[imgr,codebook]=KMeansColorReduction(imImgPath,cbsize);
[satir,sutun]=size(imgr);
sutun=sutun/3;
alphabet={};
for i=1:cbsize
    alphabet{i}=num2str(i);
end
frek=zeros(1,cbsize);
prob=zeros(1,cbsize);
frektop=satir*sutun;
imgmat=zeros(satir,sutun);
for k=1:cbsize
    for i=1:satir
        for j=1:sutun
        if imgr(i,j,1)==codebook(k,1) && imgr(i,j,2)==codebook(k,2) && imgr(i,j,3)==codebook(k,3)
            frek(k)=frek(k)+1;
            imgmat(i,j)=k;
        end
        end
    end
end
for i=1:cbsize
    prob(i)=frek(i)/frektop;
end
[hufftree,tab]=hufftree(alphabet,prob);
imgdizi={};
a=1;
for i=1:satir
    for j=1:sutun
    imgdizi{a}=num2str(imgmat(i,j));
    a=a+1;
    end
end
code=huffencode(imgdizi,tab);
compu=length(code);
decoded=huffdecode(code,hufftree);
a=1;
for i=1:satir
    for j=1:sutun
    imgmatdecomp(i,j)=str2num(decoded{a});
    a=a+1;
    end
end
for k=1:cbsize
    for i=1:satir
        for j=1:sutun
        if imgmat(i,j)==k
            imgdecomp(i,j,1)=codebook(k,1);
            imgdecomp(i,j,2)=codebook(k,2);
            imgdecomp(i,j,3)=codebook(k,3);            
        end
        end
    end
end
compratio=compu/(frektop*24);
compbasari=(1-compratio)*100;
for i=1:satir
    for j=1:sutun
    decompkare(i,j)=double(imgdecomp(i,j))^2;
    squaredErrorImage(i,j) = (double(img(i,j)) - double(imgdecomp(i,j)))^ 2;
    end
end
mse = sum(sum(squaredErrorImage))/(satir*sutun);
rmse = sqrt(mse);
snr = sqrt((sum(sum(decompkare)))/(sum(sum(squaredErrorImage))));
peaksnr=10*log10(((cbsize-1)^2)/mse);
imshow(uint8(imgdecomp));
dosyaismi=['goruntu_',int2str(cbsize),'.bmp'];
imwrite(uint8(imgdecomp), dosyaismi);

