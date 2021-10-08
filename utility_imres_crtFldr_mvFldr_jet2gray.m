% This script is usefull for creating new folder, move files from one...
% folder to another and to resize images in different folder at a time

clc; clear all; close all;
words={'01','02','03','04','05','06','07','08','09','10','11','12'};
%words={'You','Car','Hello','Friend','Well','Drink','Help','Walk','Go'};
% words={'Blake','Darrell','Darrin','Kent'};
%n=72:80;
 numdir=1:100;
for ii=1:length(words)
    root= ['/mnt/HDD02/WGAN/GAIT DATA/Original/train/',words{ii},'/*.png'];
    files = dir(root);
%      data_dir=strcat(root,words{ii},'/');
%      pat=strcat(data_dir,'*.png');
%      files=dir(pat);
% 
      savedir=strcat('/mnt/HDD02/WGAN/GAIT DATA/temp_WGAN/',words{ii},'/');
     if ~exist(savedir, 'dir')
       mkdir(savedir)
     end
 
    for jj= 1:length(files)
             data_file=strcat(files(jj).folder,'/',files(jj).name);
                   % To resize image
                   %im=jet2gray(data_file);
                   %             im=imread(data_file);
                   %             im2=imresize(im,[128 128]);
                   %             save_name=strcat(savedir,files(jj).name);
                   %             imwrite(im2,save_name)
                 copyfile(data_file,savedir)
                
                 
  
     end
% end
             
%     % To create new directory
%     if~exist(savedir,'dir')
%         mkdir(savedir)
end





%{
count=35;
m=1;
  for kk=6:5:375
        count=count+1;
    for jj=m:kk-1
       data_file=strcat(files(jj).folder,'/',files(jj).name);
       %to move files, uncommnet the command below
       file_identifier=strcat('_',num2str(count),'.png');
       if contains(data_file,file_identifier)
               savedir=strcat(root,num2str(count),'/');
               % To create new directory
               if~exist(savedir,'dir')
                       mkdir(savedir)
               end
               
               movefile(data_file,savedir)
       end
       m=kk;
    end
       % To resize image
%        im=imread(data_file);
%        im2=imresize(im,[128 128]);
%        save_name=strcat(savedir,files(jj).name);
%        imwrite(im2,save_name)
  
  end
end
%}