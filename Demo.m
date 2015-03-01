% This Matlab code demonstrates the method for simultaneous segmentation
% and bias field (intensity inhomogeneity) estimation in the following
% paper 
%      C. Li, R. Huang, Z. Ding, C. Gatenby, D. N. Metaxas, and J. C. Gore, 
%      "A Level Set Method for Image Segmentation in the Presence of Intensity
%      Inhomogeneities with Application to MRI", IEEE Trans. Image Processing, vol. 20 (7), pp. 2007-2016, 2011
% Author: Chunming Li, all rights researved
% E-mail: lchunming@gmail.com   or   li_chunming@hotmail.com
% URL: http://www.engr.uconn.edu/~cmli/

close all;
clear all;
Img=imread('./pictures/1_2.bmp');
Img=double(Img(:,:,1));
A=255;
Img=A*Img/max(Img(:)); % rescale the image intensities
nu=0.001*A^2; % coefficient of arc length term

sigma = 4; % scale parameter that specifies the size of the neighborhood
iter_outer=400; 
iter_inner=10;   % inner iteration for level set evolution

timestep=.1;
mu=1;  % coefficient for distance regularization term (regularize the level set function)

c0=1;
figure(1);
imagesc(Img,[0, 255]); colormap(gray); axis off; axis equal

% initialize level set function
initialLSF = c0*ones(size(Img));
initialLSF(30:70,60:90) = -c0;
u=initialLSF;

hold on;
contour(u,[0 0],'r');
title('Initial contour');

figure(2);
imagesc(Img,[0, 255]); colormap(gray); axis off; axis equal
hold on;
contour(u,[0 0],'r');
title('Initial contour');

epsilon=1;
b=ones(size(Img));  %%% initialize bias field


K=fspecial('gaussian',round(2*sigma)*2+1,sigma); % Gaussian kernel
KI=conv2(Img,K,'same');
KONE=conv2(ones(size(Img)),K,'same');

[row,col]=size(Img);
N=row*col;

for n=1:iter_outer
    [u, b, C]= lse_bfe(u,Img, b, K,KONE, nu,timestep,mu,epsilon, iter_inner);

    if mod(n,2)==0
        pause(0.001);
        imagesc(Img,[0, 255]); colormap(gray); axis off; axis equal;
        hold on;
        contour(u,[0 0],'r');
        iterNum=[num2str(n), ' iterations'];
        title(iterNum);
        hold off;
    end
   
end

Img_corrected=Img./b;

figure(3); imagesc(b);  colormap(gray); axis off; axis equal;
title('Bias field');

figure(4);
imagesc(Img_corrected); colormap(gray); axis off; axis equal;
title('Bias corrected image');


