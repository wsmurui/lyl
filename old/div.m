%% ���ļ��ֳ������֣�ÿ���ֱַ����Ԫ�������У�ÿһ��Ϊ����һ��Ԫ��
function [ part1 ] = div( tline1,tline2,fid)

part1={};%����һ��Ԫ������
i=1;
while ~feof(fid)&&tline1<=tline2 % �ж��Ƿ�Ϊ�ļ�ĩβ 
    
        tline=fgetl(fid); % ���ļ�����
        part1{i}=tline;%�Ѹ��д���������
   tline1= tline1+1;
    i=i+1;
end
%û�йر��ļ�����Ҫ���ⲿ�Լ��ر�