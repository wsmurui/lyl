function [ output_args ] = error_function( lutID,error_pin,logi,error_p,port_p )

%����LUT���ʽ��LUT����������

    global count;
    
    index_port = 1;
    
    %�õ�LUT��������Ϣ
    ID = lutID(findstr(lutID,'-')+1:length(lutID));  %ͨ��LUT-1���õ�lut�ı��
    inputzero = count.lut_input_info(:,str2num(ID)+1); %lut_input_info����һ����lut�����6����Ϊ1�ĸ���
%     inputzero(error_pin) = 2;      %error���������Ķ˿ںţ����磬lut��6���ڣ������Ҿ�������4�ڽ�ȥ���Ҿ���4��Ϊ1�ĸ���Ϊ2�������Ҿ�֪����
                                    %���Ҽ�⵽2��ʱ�򣬾�˵�������������룬��Ϊ���ʲ��ܴ���1��
    
    zhan_shuzi = nan(1,100);    %����һ��nan �����飬��Ϊ��ֵ��ջ������ȴ��������ֵ
    top_shuzi = 0;              %��ֵջ�����������¼�һ����ֵ��ʱ��top_shuzhi�ͼ�һ������һ��ʱ���ͼ�һ������zhan_shuzi��top_shuzi���õ��������¼������ֵ
    zhan_fuhao = [];            %������ţ������������
%     top_fuhao = 0;
    
    is_qiufan = false;          %��⵽~����ʱ����Ҫ����ֵ������
    count_fan = 0;              %���淴���ţ���������������ջ�д��ڣ�ʱ��Ͳ��������㣬ֻ�е�count_fan=0ʱ���Ž����Ⱥ�����
    % ����ջ����ѡ˳��ʼ���㹫ʽ�еĴ�������
    for i = 1 :length(logi)  %ѭ�������߼����ʱ��ÿһ������
        switch logi(i)
            case '('    %���Ƿ�����ֱ�������count_fan��1��˵����ǰ����ջ����count_fan����������
%                 top_fuhao = top_fuhao  + 1;
                zhan_fuhao = [zhan_fuhao ,'('];
                count_fan = count_fan + 1;  %�У����������ջ
            case ')'    %���������ſ��Լ����ˣ����ε�������ջ����Ԫ�ؼ��㣬ֱ�������ǣ���ֹͣ
               % �У���Ҫ��ջ
                while true
                    if strcmp(zhan_fuhao(length(zhan_fuhao)),'(')   %����ǣ����������Ϳ���ֹͣ�ˣ�count_fan��1,
%                         top_fuhao = top_fuhao - 1 ;
                        zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        count_fan = count_fan - 1;
                        break;              %����ջ��  %break��ֹͣwhile true��ѭ��������������������
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'|')   %���л�����
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;%�������ۣ����� %������ֵջ������ֵ��������1
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;       %ͬ�ϣ����ﵯ����������һ��in_1,һ��in_2��������������������
                        if in_1 ~=2 && in_2 ~=2     %��������ֵ��С��2��Ҳ����˵���Ǽ����������ʣ�ֱ�Ӽ���Ϊһ�ĸ���
                            resu = 1-(1-in_1)*(1-in_2);
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        elseif in_1 == 2 && in_2 ~=2    %������һ����ֵΪ2ʱ��Ҳ����˵������������
                            error_p = error_p * (1 - in_2);     %�����ʼ���
                            resu = 2;               %�ý������2ֱ��ѹ����ֵջ�У���ʾ����Ľ���Ǽ�������
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        else            %����һ��Ϊ2�����
                            error_p = error_p * (1 - in_1);
                            resu = 2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        end
%                         top_fuhao = top_fuhao - 1; 
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'&')  %ͬ�ϣ�ֻ�Ǽ�������
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        if in_1 ~=2 && in_2 ~=2
                            resu = in_1* in_2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        elseif in_1 == 2 && in_2 ~=2
                            error_p = error_p * in_2;
                            resu = 2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        else
                            error_p = error_p * in_1;
                            resu = 2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        end
                        %������
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'^')  %ͬ�ϼ������
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        if in_1 ~=2 && in_2 ~=2
                            resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        elseif in_1 == 2 && in_2 ~=2
                            resu = 2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        else
                            resu = 2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        end
                        %
                    end
                end
            case {'&','|','^'}
                %û�У�������Ҫ��ջ�����
                if count_fan == 0 && top_shuzi>=2  %�������ֻ�е�����ջ��û�У�������count_fan=0��������ֵջ����������ֵ��������
                    if length(zhan_fuhao) >=1
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;%���ǿ�������
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        if strcmp(zhan_fuhao(length(zhan_fuhao)),'|')
                            if in_1 ~=2 && in_2 ~=2
                                resu = 1-(1-in_1)*(1-in_2);
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            elseif in_1 == 2 && in_2 ~=2
                                error_p = error_p * (1-in_2);
                                resu = 2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            else
                                error_p = error_p * (1-in_1);
                                resu = 2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            end
                        elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'&')
                            if in_1 ~=2 && in_2 ~=2
                                resu = in_1* in_2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            elseif in_1 == 2 && in_2 ~=2
                                error_p = error_p * in_2;
                                resu = 2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            else
                                error_p = error_p * in_1;
                                resu = 2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            end
                        elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'^')
                            if in_1 ~=2 && in_2 ~=2
                                resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            else
                                resu = 2;
                                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                            end
                        end
                        zhan_fuhao(length(zhan_fuhao)) = logi(i);
                    end
                else
%                     top_fuhao=top_fuhao + 1;
                    zhan_fuhao = [zhan_fuhao,logi(i)];
                end
            case '~'        %������
                is_qiufan = true;
            case {'1','2','3','4','5','6'}  %��ֵ����ֱ������ֵջ
                if str2num(logi(i)) == error_pin
                    thisnum = port_p(index_port);
                    index_port = index_port + 1;
                    top_shuzi = top_shuzi + 1;
                    if is_qiufan
                        if thisnum==2
                            zhan_shuzi(top_shuzi) = 2;
                        else
                            zhan_shuzi(top_shuzi) = 1-thisnum; 
                        end
                        is_qiufan = false;
                    else
                        zhan_shuzi(top_shuzi) = thisnum;
                    end
                else
                    if is_qiufan   %�Ƿ�Ҫ��
                        if inputzero(str2num(logi(i))) ~=2   %���������2����ֱ����ջ
                            top_shuzi = top_shuzi + 1;
                            zhan_shuzi(top_shuzi) = 1-inputzero(str2num(logi(i)));
                        else
                            top_shuzi = top_shuzi + 1;  %�������2����ʾ����ֱ��2��ջ
                            zhan_shuzi(top_shuzi) = 2;
                        end
                        is_qiufan = false;
                    else
                        top_shuzi = top_shuzi + 1;
                        zhan_shuzi(top_shuzi) = inputzero(str2num(logi(i)));
                    end
                end
        end
    end
    
    if top_shuzi == 2       %ջ���滹������ֵ��  %��������ջ���滹����û�����㣬������һ�Ρ�
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'|')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            if in_1 ~=2 && in_2 ~=2
                resu = 1-(1-in_1)*(1-in_2);
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            elseif in_1 == 2 && in_2 ~=2
                error_p = error_p * (1 - in_2);
                resu = 2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            else
                error_p = error_p * (1 - in_1);
                resu = 2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            end
        end
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'&')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            if in_1 ~=2 && in_2 ~=2
                resu = in_1* in_2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            elseif in_1 == 2 && in_2 ~=2
                error_p = error_p * in_2;
                resu = 2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            else
                error_p = error_p * in_1;
                resu = 2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            end
        end
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'^')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            if in_1 ~=2 && in_2 ~=2
                resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            else
                resu = 2;
                top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
            end
        end
    end
    
%     if top_shuzi==0
%         p_out = 0;
%     else
%         p_out = zhan_shuzi(top_shuzi);
%     end
    output_args = error_p;  %���ս�����ȥ��������

end

