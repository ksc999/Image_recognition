function [ img_C ] = drawCircle( img,x0,y0,r,lineWidth,color_str)
%img_C      画了圆的图像  
%输入
%img        输入图像      彩色图像，灰度图像都可以
%x0,y0      圆心坐标      注意x为横向坐标，y为纵向坐标
%r          半径          r>=1
%lineWidth  线宽          lineWidth为正整数
%color_str  颜色          可缺省，可以输入'red' 'blue' 'green'             
imgSize=size(img);
width=imgSize(1);
height=imgSize(2);
img_C=img;
switch  color_str
    case 'red'
        color=[255,0,0];
    case 'blue'
        color=[0,0,255];
    case 'green'
         color=[0,255,0];
    case 'whilte'
        color=[255,255,255];
end;
%DRAWCIRCLE Summary of this function goes here
%   Detailed explanation goes here

    for theta=0:0.0001:2*pi
        x=round(x0+r*cos(theta));
        y=round(y0+r*sin(theta));
        
        %如果线宽是偶数 9 10 11(11是准确位置) 12 4
        if(mod(lineWidth,2)==0)
        for i=y-(lineWidth)/2:y-(lineWidth)/2+lineWidth
            for j=x-(lineWidth)/2:x-(lineWidth)/2+lineWidth
                if (i>=1&&j>=1&&i<width&&j<=height)
                    if(length(size(img))==2)%灰度图
                        img_C(i,j)=max(color);
                    end;
                     if(length(size(img))==3)%彩色图
                         img_C(i,j,:)=color;
                    end;
                end;
            end;
        end;
        end;
        
        if(mod(lineWidth,2)==1)
        %如果线宽是奇数 9 10 11 ,3 
        for i=y-(lineWidth-1)/2:y-(lineWidth-1)/2+lineWidth
            for j=x-(lineWidth-1)/2:x-(lineWidth-1)/2+lineWidth
                if (i>=1&&j>=1&&i<width&&j<=height)
                    if(length(size(img))==2)%灰度图
                        img_C(i,j)=max(color);
                    end;
                     if(length(size(img))==3)%彩色图
                         img_C(i,j,:)=color;
                    end;
                end;
            end;
        end;
        end;
        
    end;

img_C=uint8(img_C);
end

