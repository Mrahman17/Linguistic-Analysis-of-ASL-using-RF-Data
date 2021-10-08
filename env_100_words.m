% This script is usefull for creating new folder, move files from one...
% folder to another and to resize images in different folder at a time

%clc; clear all; close all;
%words={'Breath','Car','Come','Drink','Earthquake','Engineer','Friend','Go','Health','Hello','Help','Hospital','Knife','Lawyer','Mountain','Push','Walk','Well','Write','You'};
words={'You','Car','Hello','Friend','Well','Drink','Help','Walk','Go'};
% words={'Blake','Darrell','Darrin','Kent'};
%n=72:80;
numdir=1:100;

for ii=1:length(numdir)
    root= ['/mnt/HDD02/WGAN/pix2pix_dataset/Native/GAN_train/',num2str(numdir(ii)),'/*.png'];
    files = dir(root);
%      data_dir=strcat(root,words{ii},'/');
%      pat=strcat(data_dir,'*.png');
%      files=dir(pat);
% 
%       savedir=strcat('/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/all_data_env/',num2str(numdir(ii)),'/');
%      if ~exist(savedir, 'dir')
%        mkdir(savedir)
%     end
     for jj= 1:length(files)
             data_file=strcat(files(jj).folder,'/',files(jj).name);
           %  load (data_file);
             im=im2double(rgb2gray(imread(data_file)));
             im_hght=size(im,1);
             %img_matrix = im2double(rgb2gray(imread(fIn)));
             img_matrix=im;
             img_matrix(img_matrix<0.0589) = 0;
             total_pow = (sum(img_matrix));
             t_power1(jj,:)=sum(total_pow);
%           

             [upper_env, lower_env]=env_up_low(data_file);
             all_up(jj,:)=mean(pix_to_vel(upper_env,im_hght));
             all_dwn(jj,:)=mean(pix_to_vel(lower_env,im_hght));



%              [upper_env, lower_env]=env_up_low(data_file);
            %save_name=strcat(savedir,files(jj).name);
 %            pks = findpeaks(-1*upper_env);
%           
   %           len(jj)=length(pks);
         % vel_up(jj,:)=(pix_to_vel(upper_env));
          %vel_dwn(jj)=mean(pix_to_vel_lower(lower_env));
%           xcl_up(jj)=mean(diff(vel_up));
%            xcl_dwn(jj)=mean(diff(vel_dwn));
%            
%                upper_env2(jj,:)=upper_env;
%                lower_env2(jj,:)=lower_env;
%            

%             save_name=strcat(savedir,files(jj).name(1:end-4),'.mat');
            %imwrite(im2,save_name)
%             save(save_name,'upper_env','lower_env');
             %copyfile(data_file,savedir)
         
     end
      %peak_100(ii)=mode(len);
   % STD_peak_100(ii)=round(std(len));
    % STD_xcl_dwn(ii)=std(vel_dwn);
%      total_xcl_up(ii)=mean(xcl_up);
%       total_xcl_dwn(ii)=mean(xcl_dwn);
%       total_env_up(ii,:)=mean(upper_env2);
%       std_env_up(ii,:)=std(upper_env2);
%       total_env_dwn(ii,:)=mean(lower_env2);
%       std_env_dwn(ii,:)=std(lower_env2);
     % total_vel_dwn(ii)=mean(vel_dwn);
     up_val(ii,:)=mean(all_up);
     std_up_val(ii,:)=std(all_up);
     
      dwn_val(ii,:)=mean(all_dwn);
     std_dwn_val(ii,:)=std(all_dwn);
     t_power(ii,:)=mean(t_power1);
end


% %% this is for Movement type
% total_vel_cntrl=total_vel_up;
%  id=1:100;
%  cr=[8,11,15,16,18,23,28,32,35,37,39,42,46,51,57,62,64,65,77,81,83,84,90,93,95,97,100];
%  for mm=1:length(cr)
%          curvy(mm)=total_vel_cntrl(cr(mm));
%  end
%  fat_crv=zeros(1,73);
%  fat_crv(1:27)=curvy;
%  
% 
% idx=ismember(1:numel(total_vel_cntrl),cr); % idx is logical indices
% total_vel_cntrl(idx) = 0;
% B=total_vel_cntrl(total_vel_cntrl~=0);
% figure; plot(B); hold on; plot(fat_crv); grid on; grid minor;


%% Box plot with error bar as STD
%{
% Separate the one hand vs two hand velocity

One_hand=[3,4,9,24,32,40,45,65,69,71,98,99,100,2,8,12,15,18,19,20,21,27,28,29,36,39,42,48,52,53,59,63,66,93,14,43,46,82,1,5,6,22,49,50,57,61,64,91];

 for nn=1:length(One_hand)
         hand1_vel(nn)=up_val(One_hand(nn));
         hand1_std(nn)= std_up_val(One_hand(nn));
 end
 
 srk2_vel=mean(hand1_vel(1:13))
 srk2_std=mean(hand1_std(1:13))
 
  srk3_vel=mean(hand1_vel(14:34))
 srk3_std=mean(hand1_std(14:34))
 
  srk4_vel=mean(hand1_vel(35:48))
 srk4_std=mean(hand1_std(35:48))
 
 mean_vel_1hnd=mean(hand1_vel)
 mean_std_1hnd=mean(hand1_std)
 loyolagreen = 1/255*[0,104,87];
 loyolagray = 1/255*[150,90,0];
 figure; plot(hand1_vel,'-b*','LineWidth',1); xlabel('Words'); ylabel('Average Velocity (m/s)'); title('One handed Signs');
hold on
for ii=1: length(One_hand)
errorbar(ii,hand1_vel(ii),-hand1_std(ii),hand1_std(ii),'-s','LineWidth',0.7,'Color','blue','MarkerSize',7,...
'MarkerEdgeColor','blue','MarkerFaceColor','blue') 
end
grid on; grid minor; xlim([0 50]); legend('Average velocity', 'Standard deviation');
 

% Indices of symmetric/asymmetric
 %cr=[7,10,13,16,17,18,23,25,26,30,31,33,34,35,37,38,44,47,51,54,55,56,58,60,62,67,68,70,72,73,74,75,76,77,78,79,80,81,83,84,85,86,87,88,89,90,92,94,95,96,97];
two_hand=[11,26,47,58,60,68,76,78,89,95,7,18,25,34,37,38,55,56,67,70,77,79,84,86,87,88,94,97,81,92,10,13,16,17,23,30,31,33,35,44,51,54,62,72,73,74,75,80,83,85,90,96];
 for mm=1:length(two_hand)
         two_hand_vel(mm)=up_val(two_hand(mm));
          two_hand_std(mm)=std_up_val(two_hand(mm));
 end
 
figure; plot(two_hand_vel,'--ko','LineWidth',1); xlabel('Words'); ylabel('Average Velocity (m/s)'); title('Two handed Signs');
hold on
for ii=1: length(two_hand)
errorbar(ii,two_hand_vel(ii),-two_hand_std(ii),two_hand_std(ii),'--s','LineWidth',0.7,'Color','black','MarkerSize',7,...
'MarkerEdgeColor','black','MarkerFaceColor','black') 
end
grid on; grid minor; xlim([0 54]); legend('Average velocity', 'Standard deviation');
 


 two_srk2_vel=mean(two_hand_vel(1:10))
 two_srk2_std=mean(two_hand_std(1:10))
 
  two_srk3_vel=mean(two_hand_vel(11:28))
 two_srk3_std=mean(two_hand_std(11:28))
 
  two_srk4_vel=mean(two_hand_vel(29:52))
 two_srk4_std=mean(two_hand_std(29:52))

 mean_vel_2hnd=mean(two_hand_vel)
 mean_std_2hnd=mean(two_hand_std)
 

%% one_handed vs Two handed Energy
%load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/nrgy_with_std.mat';
total_vel_cntrl=t_power;
%std_total_power=std_nrg;
id=1:100;

One_hand=[3,4,9,24,32,40,45,65,69,71,98,99,100,2,8,12,15,18,19,20,21,27,28,29,36,39,42,48,52,53,59,63,66,93,14,43,46,82,1,5,6,22,49,50,57,61,64,91];

 for nn=1:length(One_hand)
         hand1(nn)=total_vel_cntrl(One_hand(nn));
 end
 

two_hand=[11,26,47,58,60,68,76,78,89,95,7,18,25,34,37,38,55,56,67,70,77,79,84,86,87,88,94,97,81,92,10,13,16,17,23,30,31,33,35,44,51,54,62,72,73,74,75,80,83,85,90,96];
 for mm=1:length(two_hand)
         curvy(mm)=total_vel_cntrl(two_hand(mm));
 end
 

% idx=ismember(1:numel(total_vel_cntrl),cr2hand); % idx is logical indices
% total_vel_cntrl(idx) = 0;
% B=total_vel_cntrl(total_vel_cntrl~=0); % One handed only
figure; plot(hand1/15080,'-b*','LineWidth',0.1); hold on; plot(curvy/15080,'--ko','LineWidth',0.1); grid on; grid minor; legend('One Handed','Two Handed'); xlabel('Words'); ylabel('Normalized Average Energy'); 





%% Energy Plot
%
load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/nrgy_with_std.mat';
total_vel_cntrl=whole_nrg;
std_total_power=std_nrg;
id=1:100;
 % Indices of symmetric/asymmetric
 cr=[7,10,11,13,16,17,18,23,25,26,30,31,33,34,35,37,38,44,47,51,54,55,56,58,60,62,67,68,70,72,73,74,75,76,77,78,79,80,81,83,84,85,86,87,88,89,90,92,94,95,96,97];

 for mm=1:length(cr)
         curvy(mm)=total_vel_cntrl(cr(mm));
 end
 

idx=ismember(1:numel(total_vel_cntrl),cr); % idx is logical indices
total_vel_cntrl(idx) = 0;
B=total_vel_cntrl(total_vel_cntrl~=0); % One handed only
figure; scatter( 1:48, B/1800,'b*','LineWidth',1); hold on; scatter(1:52,curvy/1800,'ko','LineWidth',1); grid on; grid minor; legend('One Handed','Two Handed'); xlabel('Words'); ylabel('Normalized Average Energy'); 
hold off;
%}

