function [ img_C ] = drawCircle( img,x0,y0,r,lineWidth,color_str)
%img_C      ����Բ��ͼ��  
%����
%img        ����ͼ��      ��ɫͼ�񣬻Ҷ�ͼ�񶼿���
%x0,y0      Բ������      ע��xΪ�������꣬yΪ��������
%r          �뾶          r>=1
%lineWidth  �߿�          lineWidthΪ������
%color_str  ��ɫ          ��ȱʡ����������'red' 'blue' 'green'             
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
        
        %����߿���ż�� 9 10 11(11��׼ȷλ��) 12 4
        if(mod(lineWidth,2)==0)
        for i=y-(lineWidth)/2:y-(lineWidth)/2+lineWidth
            for j=x-(lineWidth)/2:x-(lineWidth)/2+lineWidth
                if (i>=1&&j>=1&&i<width&&j<=height)
                    if(length(size(img))==2)%�Ҷ�ͼ
                        img_C(i,j)=max(color);
                    end;
                     if(length(size(img))==3)%��ɫͼ
                         img_C(i,j,:)=color;
                    end;
                end;
            end;
        end;
        end;
        
        if(mod(lineWidth,2)==1)
        %����߿������� 9 10 11 ,3 
        for i=y-(lineWidth-1)/2:y-(lineWidth-1)/2+lineWidth
            for j=x-(lineWidth-1)/2:x-(lineWidth-1)/2+lineWidth
                if (i>=1&&j>=1&&i<width&&j<=height)
                    if(length(size(img))==2)%�Ҷ�ͼ
                        img_C(i,j)=max(color);
                    end;
                     if(length(size(img))==3)%��ɫͼ
                         img_C(i,j,:)=color;
                    end;
                end;
            end;
        end;
        end;
        
    end;

img_C=uint8(img_C);
end

