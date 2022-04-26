function [output, wrong_index] = hamming_decode(code)

%wrong_index = 0;
code_len = length(code);
% 求信息位长度和监督位长度
flag_len = 0;
while 2^flag_len < code_len
    flag_len = flag_len + 1;
end
data_len = code_len - flag_len;

% 判断奇偶校验位组别的奇偶性并纠错
for i = 1:flag_len
    this_flag_pos = 2^(i - 1);
    temp = 0;
    for j = this_flag_pos:2^i:code_len
        for index = j:min(j+2^(i-1)-1, code_len)
            temp = xor(temp, code(index));
        end
    end
    if temp == 1
        wrong(i) = '1';
    else
        wrong(i) = '0';
    end
end
% 定位错误码元位置并纠错
wrong = reverse(wrong);
wrong_index = bin2dec(wrong);
if wrong_index ~= 0
    code(wrong_index) = ~code(wrong_index);
end

for i = 1:flag_len
    flag_index(i) = 2^(i-1);
end

index = 0;
i = 1;
while index < code_len
    index = index + 1;
    if ismember(index, flag_index)
        continue
    else
        output(i) = code(index);
        i = i + 1;
    end
end

end
