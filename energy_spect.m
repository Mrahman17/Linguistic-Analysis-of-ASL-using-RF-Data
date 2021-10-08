function total_pow =energy_spect(fIn)
% clc; clear all; close all;
% fIn='D:\png_img\asl.png';
 im=im2double(rgb2gray(imread(fIn)));
 im2=imresize(im,[128 128]);
%img_matrix = im2double(rgb2gray(imread(fIn)));
img_matrix=im2;
img_matrix(img_matrix<0.0589) = 0;
total_pow = sum(img_matrix);