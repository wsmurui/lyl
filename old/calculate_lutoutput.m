function [ p_out ] = calculate_lutoutput( inputzero, logi )
%CALCULATE_LUTOUTPUT 
%����LUT��6�����룬����lut�����01����
%   �˴���ʾ��ϸ˵��
    zhan_shuzi = nan(1,100);    %����һ��nan �����飬��Ϊջ
    top_shuzi = 0;
    zhan_fuhao = [];
%     top_fuhao = 0;
    
    is_qiufan = false;
    count_fan = 0;
    % ����ջ����ѡ˳��ʼ���㹫ʽ�еĴ�������
    for i = 1 :length(logi)
        switch logi(i)
            case '('
%                 top_fuhao = top_fuhao  + 1;
                zhan_fuhao = [zhan_fuhao ,'('];
                count_fan = count_fan + 1;  %�У����������ջ
            case ')' 
               % �У���Ҫ��ջ
                while true
                    if strcmp(zhan_fuhao(length(zhan_fuhao)),'(')
%                         top_fuhao = top_fuhao - 1 ;
                        zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        count_fan = count_fan - 1;
                        break;              %����ջ��
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'|')
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;%�������ۣ�����
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        resu = 1-(1-in_1)*(1-in_2);
                        top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
%                         top_fuhao = top_fuhao - 1; 
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'&')
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        resu = in_1* in_2;
                        top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        %������
                    elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'^')
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
                        top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        zhan_fuhao = zhan_fuhao(1:length(zhan_fuhao)-1);
                        %
                    end
                end
            case {'&','|','^'}
                %û�У�������Ҫ��ջ�����
                if count_fan == 0 && top_shuzi>=2
                    if length(zhan_fuhao) >=1
                        in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;%���ǿ�������
                        in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
                        if strcmp(zhan_fuhao(length(zhan_fuhao)),'|')
                            resu = 1-(1-in_1)*(1-in_2);
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'&')
                            resu = in_1* in_2;
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        elseif strcmp(zhan_fuhao(length(zhan_fuhao)),'^')
                            resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
                            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
                        end
                        zhan_fuhao(length(zhan_fuhao)) = logi(i);
                    end
                else
%                     top_fuhao=top_fuhao + 1;
                    zhan_fuhao = [zhan_fuhao,logi(i)];
                end
            case '~'        %������
                is_qiufan = true;
            case {'1','2','3','4','5','6'}
                if is_qiufan
                    top_shuzi = top_shuzi + 1;
                    zhan_shuzi(top_shuzi) = 1-inputzero(str2num(logi(i)));
                    is_qiufan = false;
                else
                    top_shuzi = top_shuzi + 1;
                    zhan_shuzi(top_shuzi) = inputzero(str2num(logi(i)));
                end
        end
    end
    
    if top_shuzi == 2       %ջ���滹������ֵ��
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'|')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            resu = 1-(1-in_1)*(1-in_2);
            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
        end
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'&')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            resu = in_1* in_2;
            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
        end
        if strcmp(zhan_fuhao(length(zhan_fuhao)),'^')
            in_1 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            in_2 = zhan_shuzi(top_shuzi); zhan_shuzi(top_shuzi)= nan; top_shuzi = top_shuzi - 1;
            resu = 1 - (in_1*in_2 + (1-in_1)*(1-in_2));
            top_shuzi = top_shuzi + 1; zhan_shuzi(top_shuzi) = resu;
        end
    end
    
    if top_shuzi==0
        p_out = 0;
    else
        p_out = zhan_shuzi(top_shuzi);
    end
    
% %     function [] = pop_and_compare()
% %         zhan_shuzi(1) = 100;
% %     end

end