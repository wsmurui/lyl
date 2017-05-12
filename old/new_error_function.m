function [ output_args ] = new_error_function( lutID,error_pin,logi,error_p )
%NEW_ERROR_FUNCTION Summary of this function goes here
%�����ж��Ƿ���Ҫ��֧������з�֧���͵�error fuction������м���
%   Detailed explanation goes here
global count;
    
%%%���ȶ�LUT���߼����ʽ�����logi =
%%%((~A6&A2)|(A6&((A2&~A5)|A3)))�����6��2������������ô�ֿ���������������ֵ�����5,3����������ֻ��һ����
    port_num = findstr(logi,num2str(error_pin));
    port_p = nan(1,length(port_num));
    if length(port_num) == 0         %%û�ҵ����ڣ��������
        disp('����˿ڴ���û�в���LUT������');
        return;
    end
    
    if length(port_num) == 1        %%ֻ���������ֻ��һ����Ҳ��������˵��5,3�ڣ��Ϳ���ֱ����֮ǰ���㷨��
        port_p(1) = 2;
        output_args = error_function( lutID,error_pin,logi,error_p,port_p );
        return;
    end
    
    %%%%%%���������Ǵ�������������
    ID = lutID(findstr(lutID,'-')+1:length(lutID));  %ͨ��LUT-1���õ�lut�ı��
    inputzero = count.lut_input_info(:,str2num(ID)+1);
    p_01 = inputzero(error_pin);       %%֮ǰ�������01����
    port_p = zeros(1,length(port_num));  %% ���������6�ڣ���ô�Ҿ�ֻ��Ҫ����һ��6�ڸ�ֵ������6�ڸ�ֵ01���ʣ�Ȼ�����ԭ��������Ϳ�����
                                         %Ҫ�ֿ����㣬�Ҿͷֱ��õڶ���6�ڸ�ֵ����һ��6������01���ʾͿ����ˡ�
    pout_error = nan(1,length(port_num));  %����������������ʵľ���
    for i=1:length(port_num)
        port_p(i) = p_01;
    end
    for i=1:length(port_num)    %�ֱ���ÿ���ڵ���2��ѭ��
        temp_port = port_p;
        temp_port(i) = 2;
        pout_error(i) = error_function( lutID,error_pin,logi,error_p,temp_port ); %����ԭ����
    end
    output_args = pout_error;  %�������һ���������ˡ�


end

