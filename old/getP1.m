global count;
p1map = containers.Map;

for i=1:length(input)
    p1map([input{i},',I|']) = count.input_p(i);         %����������õ�input_p(i)��ֵ��ֵ��ȥ
end

% for i=1:length(input)
%     p1map([input{i},',I|']) = 0.5;        %�����������ÿ���˿�Ϊ1�ĸ���Ϊ0.5
% end

for i=1:length(count.logidata)
    info = count.logidata{i};       %LUT�߼���������
    if length(findstr(info,'LUT'))~=0
            c_lut = info;       %����LUT��Ϣ���߼����߸���c_lut
    end
    if length(findstr(info,'<-'))~=0        %��<-�Ķ�
        if strcmp(info(findstr(info,'-')+2:length(info)),'null')    %������null
            lie_axil = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;    %������Ϣnull����
            hand_axil = str2num(info(2));   %������Ϣ���ӵ�LUT�Ķ˿�����
            count.lut_input_info(hand_axil,lie_axil) = 0;
            continue;
        end
        if length(findstr(info,'XDL_DUMMY_INT'))~=0 %������XDL_DUMMY_INT
            lie_axil = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;        %������Ϣ
            hand_axil = str2num(info(2));    %������Ϣ���ӵ�LUT�Ķ˿�����
            count.lut_input_info(hand_axil,lie_axil) = 0;
            continue; 
        end
        if length(findstr(info,'Mxor_N380_xo<0>29'))~=0 %������Mxor_N380_xo<0>29
            lie_axil = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;        %������Ϣ
            hand_axil = str2num(info(2));    %������Ϣ���ӵ�LUT�Ķ˿�����
            count.lut_input_info(hand_axil,lie_axil) = 0;
            continue;
        end
        douk = findstr(info,',');    %�����е�','������
        mapkey = info(findstr(info,'-') + 2:douk(2)-1);  %N7����������Ϣ ��ֵ�Եļ�
        sz_key = cell2mat(keys(p1map));                  %key���Ǽ�����˼������sz_key�����飨sz������������һ������������Ŀǰ���ڵ����м�  %������
        if length(findstr(sz_key,[mapkey,'|']))~=0       %�ж�Ŀǰ�������м����Ƿ���mapkey��Ҳ����˵,���統ǰ��N7����˼���ǲ鿴�Ƿ񱣴���N7Ϊ1�ĸ���
            p1 = p1map([mapkey,'|']);
            lie_axil = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;
            hand_axil = str2num(info(2));
            count.lut_input_info(hand_axil,lie_axil) = p1;
        end
    end
end
%��ʼ�����������ɣ�������ݳ�ʼ����LUT�����������LUT��

%��⣬��һ��LUT��6����Ϊ1�ĸ��ʶ�֪���ˣ���ô�Ҿ�Ҫȥ�����������Ϊ1�ĸ��ʣ������Ҷ�ÿ��LUT�Ҷ�ֻ�����һ�Σ��ظ�����û������
%���Ծ���lutis_used_info������LUT�Ƿ��Ѿ�������ˣ�����������lutis_used_info��Ӧ���Ǹ�lut������Ϊ1���ҾͲ�������ˣ������еĶ�Ϊ1�ˣ����Ҿͼ������ˣ��������ѭ���ˡ�
last = length(find(count.lutis_used_info==1));
while true
    for i = 1:size(count.lut_input_info,2)
        if count.lutis_used_info(i) == 1   %Ϊ1�ˣ���ǰlut�����˲�������
            continue;                      %����������룬�����´�ѭ��
        end
        if length(find(count.lut_input_info(:,i)>=0)) == 6   %6���ڶ���Ϊ1�ĸ����ˣ���ô�Ϳ��Լ�����
            count.lutis_used_info(i) = 1;                      % ��ע���LUT�ù���
            plus_index = findstr(count.lut_info{i},'+') ;       %�ҵ�+��λ�á�
            logi = count.lut_info{i}(plus_index(length(plus_index))+2:length(count.lut_info{i}));      %��lut���߼���Ϣ
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            p1_out = calculate_lutoutput( count.lut_input_info(:,i), logi );   %����calculate_lutoutput�����������ǰlut�����Ϊ1�ĸ���
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cu_slice = count.lut_info{i}(plus_index(1)+2:plus_index(2)-2);  %��ǰ��slice
            pin = count.lut_info{i}(plus_index(length(plus_index)-1)+2);       %��ǰ����˿ڣ�A,B,C,D
            p1map([cu_slice,',',pin,'|']) = p1_out;      %��ֵ�ԣ�����˵��ǰslice��ĳ���˿�Ϊ1�ĸ���֪���ˣ���ô�ͼ��뵱��ֵ��������ȥ
            p1map([cu_slice,',',pin,'MUX|']) = p1_out;      %ͬ�ϣ�ֻ�Ǽ�ֵ��һ�������Ƕ˿ںţ������MUX
        end
    end

    %���ѭ�����Ǳ������е�LUT����Ϊ��һ��ѭ��ֻ�������Slice+�˿ںŵ�1���ʣ����ǲ���֪�����slice+�˿ں���������һ��LUT��
    %�������ѭ�����Ǳ���ÿһ��LUT��ÿ����������������ĸ�Slice+�˿��ϣ��ڴӼ�ֵ�����������Ƿ�������˿ںŵĸ��ʣ��еĻ����LUT���������˿ڵ�1����Ҳ��֪����
    %�Ϳ����ٻص���һ��ѭ���������Ƿ��ĸ�LUT��6���˿ڵ�1���ʶ����˶���û�����LUT���ٽ��м��㡣
    for i=1:length(count.logidata)
        info = count.logidata{i};
        if length(findstr(info,'LUT'))~=0
                c_lut = info;
        end
        if count.lutis_used_info(str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1) == 1
            continue;
        end
        if length(findstr(info,'<-'))~=0
            douk = findstr(info,',');
            if length(douk) == 0
                continue;
            end
            mapkey = info(findstr(info,'-') + 2:douk(2)-1);
            sz_key = cell2mat(keys(p1map));
            if length(findstr(sz_key,[mapkey,'|']))~=0
                p1 = p1map([mapkey,'|']);
                lie_axil = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;
                hand_axil = str2num(info(2));
                count.lut_input_info(hand_axil,lie_axil) = p1;
            end
        end
    end
    
    %%��ÿ��LUT��������ˣ���ֹͣwhile true �����ѭ���ˡ�
    if length(find(count.lutis_used_info==1))==length(count.lutis_used_info)
        break;
    elseif last == length(find(count.lutis_used_info==1))
        break;
    else 
        last = length(find(count.lutis_used_info==1));
    end
end
%����LUT�������Ϊ1�ĸ����Ѿ����

%�����������Ϊ1�ĸ���
for i = 1:length(count.logidata)
    info = count.logidata{i};
    if length(findstr(info,'LUT'))~=0
            c_lut = info;
            continue;
    end
    if length(findstr(info,'->'))~=0 && length(findstr(info,',O,'))~=0
        if count.lutis_used_info(str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1) == 1
            mykey = info(findstr(info,'>')+3:findstr(info,',')-1);
            index = str2num(c_lut(findstr(c_lut,'-')+1:length(c_lut)))+1;
            plus_index = findstr(count.lut_info{index},'+') ;
            cu_slice = count.lut_info{index}(plus_index(1)+2:plus_index(2)-2);
            pin = count.lut_info{index}(plus_index(length(plus_index)-1)+2);
            sz_key = cell2mat(keys(p1map));
            if length(findstr(sz_key,[cu_slice,',',pin,'|']))~=0
                p1map(mykey) = p1map([cu_slice,',',pin,'|']);
            else
                p1map(mykey) = p1map([cu_slice,',',pin,'MUX|']);
            end
        end
    end
end

for i = 1 : length(output)
    count.output_p(i) = p1map(output{i});
end



