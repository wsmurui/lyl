clc
clear;
close all;
log_flag = 0;               % �߼���Դ��ʶ
cnt_flag = 0;               % �߼����߱�ʶ
lut_flag = 0;               % ��ʾ��LUT-������
ovf_flag = 0;               % �����ļ��ı�ʶ

lut_cnt = 0;                % LUT ��Ŀ
lut = {348,2};               %����洢LUT��Ϣ��Ԫ������
fid = fopen('c7552.txt','r');

while ~feof(fid)            %�ж��Ƿ�Ϊ�ļ�ĩβ
    tline = fgetl(fid);         %����
    
    if log_flag == 0
        if strcmp(tline, '////   ��������õ����߼���Դ������ʾ  ') == 1
            log_flag = 1;           %�ӡ�////   ��������õ����߼���Դ������ʾ ��֮������log_flag=1
        end
    else
        if strcmp(tline(1:4), 'LUT-') == 1
            lut_cnt = lut_cnt + 1;          %lut����
             
            % Read the logical data here!!!
            lut{lut_cnt,1}=tline            %��tline��ֵ���δ��뵽lut{}���Ԫ������ĵ�һ��
            
            continue;           %��������ѭ������������while
        end
    end     % ��log_flag=0��������LUT-������Ҳ�����ļ���671�а�
    
    if cnt_flag == 0
        if strcmp(tline, '////   ���������Դ���߼�����������ʾ  ') == 1
            log_flag = 0;
            lut_cnt = 0;
            cnt_flag = 1;
        end
    elseif lut_flag == 0
        if strcmp(tline(1:4), 'LUT-') == 1
            lut_flag = 1;
            lut_cnt = lut_cnt + 1;
        end
  elseif lut_flag == 1
        while ~feof(fid)
            if strcmp(tline(1:3), 'LUT') == 1
                lut_cnt = lut_cnt + 1;
                break;
            elseif strcmp(tline(1:3), 'END') == 1
                ovf_flag = 1;
                return;
            end
            
            % Read the connection data here!!!
            tline
            
            tline = fgetl(fid);
        end
    end     % if cnt_flag == 0
end