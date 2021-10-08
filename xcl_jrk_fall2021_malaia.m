clc; clear all; close all;

numdir=1:100;
native_xcl=cell(100,2);
native_jrk=cell(100,2);
native_vel=cell(100,2);

for ii=1:length(numdir)
   root= ['/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/all_data_env/',num2str(numdir(ii)),'/*.mat'];
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
%              im=im2double(rgb2gray(imread(data_file)));
%              im2=imresize(im,[128 128]);
            load (data_file);
            %[upper_env, lower_env]=env_up_low(data_file);
            
             vel_up(jj,:)=(pix_to_vel(upper_env));
              mean_vel_up(jj)=mean(pix_to_vel(upper_env));
              vel_dwn(jj,:)=pix_to_vel(lower_env);
             mean_vel_dwn(jj)=mean(pix_to_vel(lower_env));
             
             xcl_up(jj,:)=diff(pix_to_vel(upper_env));
             mean_xcl_up(jj)=mean(xcl_up(jj,:));
             
             jrk_up(jj,:)=diff(xcl_up(jj,:));
             mean_jrk_up(jj)=mean(jrk_up(jj,:));
             
             xcl_dwn(jj,:)=(diff(pix_to_vel(lower_env)));
             mean_xcl_dwn(jj)=mean(xcl_dwn(jj,:));
             
             jrk_dwn(jj,:)=diff(xcl_dwn(jj,:));
             mean_jrk_dwn(jj)=mean(jrk_dwn(jj,:));
     end
     native_vel{ii,1}=vel_up;
     native_vel{ii,2}=vel_dwn;
     native_xcl{ii,1}=xcl_up;
     native_xcl{ii,2}=xcl_dwn;
     
     native_jrk{ii,1}=jrk_up;
     native_jrk{ii,2}=jrk_dwn;
     clear xcl_up xcl_dwn jrk_up jrk_dwn
     
%      imit_mean_vel_up(ii,:)=mean(mean_vel_up);
%      imit_mean_vel_dwn(ii,:)=mean(mean_vel_dwn);
%   
%           imit_std_vel_up(ii,:)=std(mean_vel_up);
%      imit_std_vel_dwn(ii,:)=std(mean_vel_dwn);
%      
%      imit_mean_xcl_up(ii,:)=mean(mean_xcl_up);
%      imit_mean_xcl_dwn(ii,:)=mean(mean_xcl_dwn);
%      
%       imit_std_xcl_up(ii,:)=std(mean_xcl_up);
%      imit_std_xcl_dwn(ii,:)=std(mean_xcl_dwn);
%      
%      imit_mean_jrk_up(ii,:)=mean(mean_jrk_up);
%      imit_mean_jrk_dwn(ii,:)=mean(mean_jrk_dwn);
%      
%      imit_std_jrk_up(ii,:)=std(mean_jrk_up);
%      imit_std_jrk_dwn(ii,:)=std(mean_jrk_dwn);
     
     
end


%{
One_hand=[3,4,9,24,32,40,45,65,69,71,98,99,100,2,8,12,15,18,19,20,21,27,28,29,36,39,42,48,52,53,59,63,66,93,14,43,46,82,1,5,6,22,49,50,57,61,64,91];

 for nn=1:length(One_hand)
         hand1_vel(nn)=tot_mean_jrk_up(One_hand(nn));
         hand1_std(nn)= tot_std_jrk_up(One_hand(nn));
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

%% Two handed

two_hand=[11,26,47,58,60,68,76,78,89,95,7,18,25,34,37,38,55,56,67,70,77,79,84,86,87,88,94,97,81,92,10,13,16,17,23,30,31,33,35,44,51,54,62,72,73,74,75,80,83,85,90,96];
 for mm=1:length(two_hand)
         two_hand_vel(mm)=tot_mean_jrk_up(two_hand(mm));
          two_hand_std(mm)=tot_std_jrk_up(two_hand(mm));
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
%}
