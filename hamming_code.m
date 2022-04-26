function hamming_code = hamming_code(data)
% 信息位长度
data_len = length(data);

% 求监督位个数flag_len
flag_len = 0;
while 2^flag_len - flag_len - 1 < data_len
    flag_len = flag_len + 1;
    flag_index(flag_len) = 2^(flag_len - 1);
end

% 总码长
code_len = data_len + flag_len;

% 初始化码元数组
hamming_code = zeros(1, code_len);

% 填入源码元
index = 1;
i = 1;
while index <= code_len
    if ismember(index, flag_index)
        index = index + 1;
    else
        hamming_code(index) = data(i);
        index = index + 1;
        i = i + 1;
    end
end

% 判断监督位的值
for i = 1:flag_len
    this_flag_pos = 2^(i - 1);
    temp = 0;
    for j = this_flag_pos:2^i:code_len
        for index = j:min(j+2^(i-1)-1, code_len)
            temp = xor(temp, hamming_code(index));
        end
    end
    if temp == 1
        hamming_code(this_flag_pos) = 1;
    end
end
end
