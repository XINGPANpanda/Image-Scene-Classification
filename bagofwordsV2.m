function dicdescrip=bagofwordsV2(img1_dir,des_dir,words_num)
% img1_dir��ͼ���ļ���·��
% des_dir��ͼ�������Ӵ洢·��
% words_num���Ӿ��ʵ�ĵ����������Ǿ������������
% ���dicdescrip�Ƕ�ά����������ͼ�������������Ӿ���������ֵ��ÿ��ͼ����ÿ���Ӿ����ʳ��ֵĴ���
% �����������Ϊdicdescrip.mat��·���������Ӵ洢·����ͬ
%%
%�ⲿ�ֶ�ȡ·��������ͼ��,����sift������

error=0;
patch_size=20;
grid_spacing=20;
% words_num=50;                                                      %������������
% img1_dir='F:\��ҵ\������Ӿ���ҵ\��ά��ֽɭ��ͼƬ��ͳһ��ʽ��\';
% des_dir='F:\��ҵ\����\SIFT������\';
img_path_list = dir(strcat(img1_dir,'*.jpg'));                      %��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);                                    %��ȡͼ��������
if img_num > 0 
   for j = 1:img_num 
       image_name = img_path_list(j).name;% ͼ����
       I1=imreadbw([img1_dir image_name]) ;
%       I1_rgb = imread([img1_dir image_name]) ; 
       I1=imresize(I1, [240 320]);                             %ͳһͼ���С
%       fprintf('%d %d %s\n',k,j,strcat(img1_dir,image_name));
       try
%        [frames1,descr1,gss1,dogss1 ] = do_sift( I1, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ;
         [sift_arr, grid_x, grid_y] = dense_sift(I1, patch_size, grid_spacing);
         save([des_dir,'sift',num2str(j),'.mat'],'sift_arr');
       catch
         error=error+1;
       continue
       end
    end
end

%%
%��һ�����ڹ����Ӿ��ʵ�
descriptor=load([des_dir,'sift',num2str(1),'.mat']);
alldescrip=descriptor.sift_arr;
des_size=zeros(img_num);
des_size(1)=size(descriptor.sift_arr,2);
for k=2:img_num
    descriptor=load([des_dir,'sift',num2str(k),'.mat']);
    des_size(k)=size(descriptor.sift_arr,2);
    alldescrip=cat(2,alldescrip,descriptor.sift_arr);
end
alldescrip=alldescrip';
[idx,C]=kmeans(alldescrip,words_num);


%%
%��һ�ΰ�ͼ�����Ӿ��ʵ��ʾ
dicdescrip=zeros(img_num,words_num);
for k=1:length(idx)
    
    if k<=des_size(1)
       dicdescrip(1,idx(k))=dicdescrip(1,idx(k))+1;
    end
    
    for n=1:img_num-1
        if k<=sum(des_size(1:n+1))&&k>sum(des_size(1:n))
           dicdescrip(n+1,idx(k))=dicdescrip(n+1,idx(k))+1;
        end
    end
end
for m=1:img_num
    dicdescrip(m,:)=dicdescrip(m,:)/max(dicdescrip(m,:));
end
save([des_dir,'dicdescrip.mat'],'dicdescrip');
