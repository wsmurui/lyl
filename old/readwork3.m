% ��c499�Ķ�ȡ

clc;
clear;
fidin=fopen('work3.txt','r');
data = {};
t = 1;

%count��ȫ�ֱ�����Ҳ����ÿһ��m�ļ������������涼��ʹ���������ݡ����б��������������������˵㿪������������Ҫ�����ݾ���·����Ϣ��
global count;
count.result ={};   %·����Ϣ�ı���ط���
count.num = 1;      %num��ֵ��ʾһ��������·
while ~feof(fidin) 
    tline=fgetl(fidin);
    data{t} = tline;      %data���Ƕ�����ļ���Ϣ��������Ϣ��������
    t = t+ 1;
end
iodata={};

for i=1:4                %IO��Ϣ��1:6��io�ڵ���������ͬ�ĵ�·io��������һ������data�ļ������ж���io�ڣ������￪ʼ��Щ��Ϣ������������
    iodata{i} = data{i+6};
end
logidata = {};              %�߼�����
for i=1:9                %ͬ��
    logidata{i} = data{i+69};  %���Ǽ�198����Ϊligidata��Ϣ�Ǵ�data�еĵ�199�п�ʼ�ġ�
end

io_size = length(iodata);
io = {};
for i = 1 : io_size
    info = iodata{i};
    k = findstr(info,'+');
    io{i} = info(k(1)+2:k(2)-2);
end
input = io(1:3);            %����io���
output = io(4:length(io));          %���io���

lut_info = {};
for i=1:1
    lut_info{i} = data{i+15};
end

fmux_info = {};
% for i=1:5
%     fmux_info{i} = data{i+684};
% end

outmux_info = {};
% for i=1:55
%     outmux_info{i} = data{i+714};
% end

fmux_logi = {};
% for i=1:30
%     fmux_logi{i} = data{i+4455};
% end

outmux_logi = {};
% for i=1:283
%     outmux_logi{i} = data{i+4500};
% end

count.lut_info = lut_info;      %LUT�߼���Ϣ
count.fmux_info = fmux_info;
count.outmux_info = outmux_info;
count.outmux_logi = outmux_logi;
count.fmux_logi = fmux_logi;
count.logidata = logidata;          %LUT�߼�����

% lutis_used_info = zeros(1,length(lut_info));
% lut_input_info = nan(6,length(lut_info));

count.lutis_used_info = zeros(1,length(lut_info));
count.lut_input_info = nan(6,length(lut_info));     %��ʼֵΪnan�����飨���󣩣�6��LUT��6�������
count.output_p = nan(1,length(output));         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count.input_p = [0.6 0.3 0.5];          %ÿ������Ϊ1�ĸ��ʣ������Ҫ�ı��������ڳ�ʼΪ1�ĸ��ʾ�������ģ���Ϊ
                                                %�����·��5������ڣ��Ҿ�������������5����ʼֵ����˳��ֱ��Ӧÿ���ڡ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(input)
    DPS([input{i},',I'],input{i});          %��input{i}�����',I',ƴ���ַ���
end
