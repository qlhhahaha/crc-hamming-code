function crc_code= crc_encode(G,data) % 校验多项式,原始信号
G_len = length(G);

while G_len(1) == 0 %校验多项式第一项为零时，就从下一项开始
    G = G(2:G_len);
    G_len = length(G);
    %set(handles.tishi, 'String', '生成多项式首位为0，已经自动忽略高位0');
end

for i = 1:1:G_len
    if(G(i) ~= 0 && G(i) ~= 1)
        errordlg('多项式中出现了非0、1的数值','Error');
    end
end

for i = 1:1:length(data)
    if(data(i) ~= 0 && data(i) ~= 1)
        errordlg('原始数据中出现了非0、1的数值','Error');
    end
end

data_backoff = data;

for k = 1 : G_len-1
    data = [data 0]; %在尾部补0的数量是生成多项式的长度减一
end

data_len = length(data);
crc = data(1 : G_len-1);

for i = G_len : data_len
    crc(G_len) = data(i);
    if crc(1)
        crc = xor(crc(2:G_len), G(2:G_len));   
        %异或运算，相当于除法
    else
        crc = crc(2:G_len);
    end
end

R = crc; %R为余数

crc = [data_backoff R]; 
crc_code = crc;
%crc_code=num2str(crc);  %数组转字符串





