%����������ȡ�����������
%img1-4_dir�ֱ�������ͼƬ�Ĵ洢·����des1-4_dir�ֱ�������ͼƬ���й������Ĵ洢·��
%ÿ��ͼƬ·����ѡȡǰtrainnum��ͼƬ����ѵ����Ȼ�������testnum�����ڲ���


trainnum=500;
testnum=100;

img1_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\fire\';
des1_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\firefeature\';
fire=featurecreate(img1_dir,des1_dir);
FireLables=ones(trainnum+testnum,1);
save([des_dir,'FireLables.mat'],'FireLables');

img2_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\forest\';
des2_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\forestfeature\';
forest=featurecreate(img2_dir,des2_dir);
ForestLables=ones(trainnum+testnum,1)*2;
save([des_dir,'ForestLables.mat'],'ForestLables');

img3_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\ocean\';
des3_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\oceanfeature\';
ocean=featurecreate(img3_dir,des3_dir);
OceanLables=ones(trainnum+testnum,1)*3;
save([des_dir,'OceanLables.mat'],'OceanLables');

img4_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\snow\';
des4_dir='F:\��ҵ\������Ӿ���ҵ\ͼƬ\snowfeature\';
snow=featurecreate(img4_dir,des4_dir);
SnowLables=ones(trainnum+testnum,1)*4;
save([des_dir,'SnowLables.mat'],'SnowLables');



imageproject(trainnum,testnum,fire,FireLables,forest,ForestLables,ocean,OceanLables,snow,SnowLables);

