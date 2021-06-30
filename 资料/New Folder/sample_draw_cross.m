clc
clear all
img=imread('jet2.bmp');
subplot(1,2,1);
imshow(img);
subplot(1,2,2);
cImg=drawCircle(img,50,512,100,2,'red');
imshow(cImg);

