
%%������ϵ���lut֮��Ĵ�������

global count;

error_info = 1 - zeros(1,length(input)); %%error_info������˿��Ƿ����ı�ʾ��Ϊ1��ʾ��ȷ��Ϊ0���Ǵ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
error_info(1) = 0;      %�����õ�3���������Ϊ0
                        %%%%%���������ĳ�ʼֵ��error_info(3) = 0;��ʾ��3���������
                        %%%%%error_info(4) = 0 ��ʾ��4���������
error_p = 1;            %������100%��Ҳ����1������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wrong_inoutID = '';     %����Ķ˿ںţ�N1��N2���������������ȳ�ʼ�������������ټ���

worng_num = 0;          %�������������Ϊ��֪һ��·����
final_result = {};      %���յĽ��������N23��0.4863,�������N23�����Ϊ0.4863
for i = 1:length(input)
    if error_info(i) == 0
        wrong_inoutID = input{i};       %�ҵ�����˿��ˣ�����N6
        break;
    end
end
 %%%%%%%%%%%%%%%%%%%%%%%%��ʼ�����%%%%%%%%%%%%%%%%%%%%%%%%%

for j = 1:length(count.result)
    path_info = count.result{j};            %����ÿһ��·��Ϣ��
    inputID = path_info(1:findstr(path_info,'-')-1);    %�õ�·������˿ڣ�����N1��N2
    if strcmp(inputID,wrong_inoutID)        %�Ƚϵ�ǰ·������˿��Ƿ���Ǵ��������˿�
        index_jiankuohao = findstr(path_info,'>');      %�����ŵ�����
        for k = 1:length(index_jiankuohao)-1            %ѭ������·���������ʼ���
            index_douhao = findstr(path_info(index_jiankuohao(k):length(path_info)),',') + index_jiankuohao(k) - 1;    %���ŵ�����������֮ǰ�����·����Ϣ��count.result�����ſ��õ�
            lut_name = path_info(index_jiankuohao(k)+1:index_douhao-1); %LUT��Ϣ
            error_pin = path_info(index_douhao+2:index_jiankuohao(k+1)-2); %�������LUT�ĸ��˿�
            logi  =''; %��ʼ���߼���Ϣ
            for jk = 1:length(lut_info)
                index_jiahao = findstr(lut_info{jk},'+');
                if strcmp(lut_info{jk}(1:index_jiahao(1) - 2),lut_name)
                    logi = lut_info{jk}(index_jiahao(length(index_jiahao))+2:length(lut_info{jk})); %�õ��߼���Ϣ
                    break;
                end
            end
            result_p = [];
            for pnum = 1:length(error_p)
                tempzero_p = new_error_function( lut_name,str2num(error_pin),logi,error_p(pnum) );
                result_p = [result_p tempzero_p];
            end
            error_p = result_p;
%             error_p = new_error_function( lut_name,str2num(error_pin),logi,error_p ); %���㾭��LUT��������ʣ�����error_function����
        end
%         worng_num = worng_num + length(error_p);  %����·�����ˣ��ȵ�length(error_p)�����
        output_N = path_info(index_jiankuohao(length(index_jiankuohao))+1:length(path_info)); %���յ�����˿ں�
        for resultnum = 1:length(error_p)
            worng_num = worng_num + 1;
            final_result{worng_num} = [output_N,',',num2str(error_p(resultnum))];
        end
        error_p = 1;
%         final_result{worng_num} = [output_N,',',num2str(error_p)];  %�������ս��
    end
end