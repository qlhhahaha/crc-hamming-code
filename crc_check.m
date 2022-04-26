function crc_check_result= crc_check(G , crc_code)

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

for i = 1:1:length(crc_code)
    if(crc_code(i) ~= 0 && crc_code(i) ~= 1)
        errordlg('原始数据中出现了非0、1的数值','Error');
    end
end

for k = 1 : G_len-1
    crc_code = [crc_code 0]; %在尾部补0的数量是生成多项式的长度减一
end

crc_code_len = length(crc_code);
crc = crc_code(1 : G_len-1);

for i = G_len : crc_code_len
    crc(G_len) = crc_code(i);
    if crc(1)
        crc = xor(crc(2:G_len), G(2:G_len));
        %异或运算，相当于除法
    else
        crc = crc(2:G_len);
    end
end

R = crc; %R为余数

R_length=length(R);
sum=0;

for i=1:R_length
    sum=sum+R(i);
end

if sum==0
    % disp('编码正确');
    crc_check_result = 1;
else
    crc_check_result = 0;
    %disp('编码错误');
end
