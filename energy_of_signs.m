% This script is usefull for creating new folder, move files from one...
% folder to another and to resize images in different folder at a time
%{
clc; clear all; close all;
% %words={'Breath','Car','Come','Drink','Earthquake','Engineer','Friend','Go','Health','Hello','Help','Hospital','Knife','Lawyer','Mountain','Push','Walk','Well','Write','You'};
% words={'You','Car','Hello','Friend','Well','Drink','Help','Walk','Go'};
% % words={'Blake','Darrell','Darrin','Kent'};
% %n=72:80;
numdir=1:100;

for ii=1:length(numdir)
    root= ['/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/Imitation/Train/',num2str(numdir(ii)),'/*.png'];
    files = dir(root);
%      data_dir=strcat(root,words{ii},'/');
%      pat=strcat(data_dir,'*.png');
%      files=dir(pat);
% 
%       savedir=strcat('/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/GAN_train/',num2str(numdir(ii)),'/');
%      if ~exist(savedir, 'dir')
%        mkdir(savedir)
%     end
     for jj= 1:length(files)
             data_file=strcat(files(jj).folder,'/',files(jj).name);
             im=im2double(rgb2gray(imread(data_file)));
             im2=imresize(im,[128 128]);
             im_hght=size(im2,2);
             %img_matrix = im2double(rgb2gray(imread(fIn)));
             img_matrix=im2;
             img_matrix(img_matrix<0.0589) = 0;
             total_pow = (sum(img_matrix));
             t_power(jj)=sum(total_pow);
              
             [upper_env, lower_env]=env_up_low(data_file);
             all_up(jj,:)=mean(pix_to_vel(upper_env,im_hght));
             all_dwn(jj,:)=mean(pix_to_vel(lower_env,im_hght));
%             


            %save_name=strcat(savedir,files(jj).name(1:end-4),'.mat');
            %imwrite(im2,save_name)
            %save(save_name,'upper_env','lower_env');
             %copyfile(data_file,savedir)
         
     end
     
        up_val(ii,:)=mean(all_up);
     std_up_val(ii,:)=std(all_up);
     
      dwn_val(ii,:)=mean(all_dwn);
     std_dwn_val(ii,:)=std(all_dwn);
     
     total_power(ii)=mean(t_power);
     std_total_power(ii)=std(t_power);
  
end
%}
%% This is for Onehanded/Two handed
%load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/nrgy_with_std.mat';
load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/Imitation_power_vel.mat';
total_vel_cntrl=total_power';

 



id=1:100;
 % Indices of one handed
 cr=[3,4,9,24,32,40,45,65,69,71,98,99,100,2,8,12,15,18,19,20,21,27,28,29,36,39,42,48,52,53,59,63,66,93,14,43,46,82,1,5,6,22,49,50,57,61,64,91];

 for mm=1:length(cr)
         curvy(mm)=total_vel_cntrl(cr(mm));
 end
 

idx=ismember(1:numel(total_vel_cntrl),cr); % idx is logical indices
total_vel_cntrl(idx) = 0;
B=total_vel_cntrl(total_vel_cntrl~=0); % Two handed only
figure; scatter(1:52, B/2200,'ok'); hold on; scatter(1:48,curvy'/2200,'*b'); grid on; grid minor; 
legend('Two Handed','One Handed'); xlabel('Words'); ylabel('Normalized Average Energy'); 
xlim([0 54]);

% 
% 
% one_handed_idx= find(idx==0);
% lbl=vect2str(one_handed_idx,'formatstring', '%5.0f');
% figure; plot(curvy,'g','LineWidth',2); grid on; grid minor;
% [h,ext]=labelpoints(1:51,curvy,cr);
% 
% figure; plot(B,'g','LineWidth',2); grid on; grid minor; title('Single handed')
% [h,ext]=labelpoints(1:49,B,one_handed_idx);
% 
% load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/std_total_power.mat'
% 
%  for mm=1:length(cr)
%          std_curvy(mm)=std_total_power(cr(mm));
%  end
%  
% 
% idx2=ismember(1:numel(std_total_power),cr); % idx is logical indices
% std_total_power(idx2) = 0;
% B2=std_total_power(std_total_power~=0); % One handed only
% 
% x = 1:numel(std_curvy);
% figure;
% curve1 = curvy + std_curvy;
% curve2 = curvy - std_curvy;
% x2 = [x, fliplr(x)];
% 
% inBetween = [curve1, fliplr(curve2)];
% fill(x2, inBetween/2200, 'b','FaceAlpha',0.3,'LineStyle','none');
% hold on;
% plot(x, curvy/2200, '-bo', 'LineWidth', 1); grid minor;
% legend('+/- 1 STD for Two Handed sign','Normalized Energy for Two Handed sign'); 
% xlabel('Words');ylabel('Normalized Average Energy');
% 
% hold on
% x = 1:numel(B2);
% figure;
% curve1 = B + B2;
% curve2 = B - B2;
% x2 = [x, fliplr(x)];
% 
% inBetween = [curve1, fliplr(curve2)];
% fill(x2, inBetween/2200, 'r','FaceAlpha',0.3,'LineStyle','none');
% hold on;
% plot(x, B/2200, '-r*', 'LineWidth', 1);
% grid minor
% legend( '+/- 1 STD for one Handed sign','Normalized Energy for One Handed sign');
% xlabel('Words');ylabel('Normalized Average Energy');


% %%Velocity plotting
% load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/std_vel_up_dwn.mat';
% load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/up_Dwn_vel_100signs.mat'
% figure; plot(upper_radial_vel,'-g*','LineWidth',1); xlabel('Words'); ylabel('Average Velocity (m/s)'); 
% 
% x = 1:numel(upper_radial_vel);
% hold on
% 
% for ii=1: 100
% errorbar(ii,upper_radial_vel(ii),-STD_upper_radial_vel(ii),STD_upper_radial_vel(ii),'-s','LineWidth',0.7,'Color','blue','MarkerSize',7,...
% 'MarkerEdgeColor','blue','MarkerFaceColor','blue') 
% end
% grid on; grid minor; xlim([0 102]); legend('Average velocity', 'standard deviation');