clear all; clc; close all; warning off;

load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/imit_all_HOD.mat';
% load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/nrgy_with_std.mat';
% load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/Imitation_power_vel.mat';
load '/mnt/HDD02/WGAN/old_backup/110Signs/Original_data/native_all_HOD.mat';
imit_power=total_power';
fluent_power=whole_nrg;

native_feature=cat(2,fluent_power,tot_mean_vel_up,tot_std_vel_up,tot_mean_xcl_up,tot_std_xcl_up,tot_mean_jrk_up,tot_std_jrk_up,...
        tot_mean_vel_dwn,tot_std_vel_dwn,tot_mean_xcl_dwn,tot_std_xcl_dwn,tot_mean_jrk_dwn,tot_std_jrk_dwn);
 
imit_feature=cat(2,imit_power,imit_mean_vel_up,imit_std_vel_up,imit_mean_xcl_up,imit_std_xcl_up,imit_mean_jrk_up,imit_std_jrk_up,...
        imit_mean_vel_dwn,imit_std_vel_dwn,imit_mean_xcl_dwn,imit_std_xcl_dwn,imit_mean_jrk_dwn,imit_std_jrk_dwn);

all_ftr=cat(1,native_feature,imit_feature);


%% Labeling Imitation vs Fluent
sign_label=cell(200,1);
 for nn=1:length(sign_label)
         if nn<=100
            sign_label{nn,1}='Fluent';
         else
                 sign_label{nn,1}='Imit';
         end
      
 end
 
 %% Fluent One vs two handed
 



One_hand=[3,4,9,24,32,40,45,65,69,71,98,99,100,2,8,12,15,18,19,20,21,27,28,29,36,39,42,48,52,53,59,63,66,93,14,43,46,82,1,5,6,22,49,50,57,61,64,91];

 for mm=1:length(One_hand)
         handed(mm,:)=imit_feature(One_hand(mm),:);
         hand_label{mm,1}='One_handed';
 end


two_hand=[11,26,47,58,60,68,76,78,89,95,7,18,25,34,37,38,55,56,67,70,77,79,84,86,87,88,94,97,81,92,10,13,16,17,23,30,31,33,35,44,51,54,62,72,73,74,75,80,83,85,90,96];
 for nn=1:length(two_hand)
         handed(48+nn,:)=imit_feature(two_hand(nn),:);
         hand_label{48+nn,1}='Two_handed';
 end
%  one_two=cat(1,hand1,hand2);
%  for jj=49:100
%          hand_label{jj,1}='hand2';
%  end
         
 
meas=handed;
species=hand_label;


figure;
rng('default') % for reproducibility
Y = tsne(meas,'Algorithm','exact','Distance','mahalanobis');
subplot(2,2,1)
gscatter(Y(:,1),Y(:,2),species)
title('Mahalanobis')

rng('default') % for fair comparison
Y = tsne(meas,'Algorithm','exact','Distance','cosine');
subplot(2,2,2)

gscatter(Y(:,1),Y(:,2),species)
title('Cosine')

rng('default') % for fair comparison
Y = tsne(meas,'Algorithm','exact','Distance','chebychev');
subplot(2,2,3)
gscatter(Y(:,1),Y(:,2),species)
title('Chebychev')

rng('default') % for fair comparison
Y = tsne(meas,'Algorithm','exact','Distance','euclidean');
subplot(2,2,4)
gscatter(Y(:,1),Y(:,2),species)
title('Euclidean')

for jj=14:34
        hand1_label{jj,1}='Stroke 2';
end

