warning off
clc, close all, clear all
imagen=imread('TEST_10.JPG');
%imshow(imagen);
title('PROJECT FOR BLIND')
if size(imagen,3)==3
    imagen=rgb2gray(imagen);
    
end

threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
imagen = bwareaopen(imagen,30);
imshow(imagen);
word=[ ];
re=imagen;
fid = fopen('OUTPUT.txt', 'wt');
load templates
global templates
num_letras=size(templates,2);
while 1    
    [fl, re]=lines(re);
    imgn=fl;
    
    [L, Ne] = bwlabel(imgn);
    for n=1:Ne
        [r,c] = find(L==n);
        n1=imgn(min(r):max(r),min(c):max(c));
        img_r=imresize(n1,[42 24]);
        %imshow(fl);pause(0.5)  
        letter=read_letter(img_r,num_letras);
        word=[word letter];
        %fprintf('number:%d,char =%s',n,letter);
    end
    fprintf(fid,'%s\n',word);
    word=[ ];
    if isempty(re)
        break
    end
end
fclose(fid);
winopen('OUTPUT.txt')
clear all