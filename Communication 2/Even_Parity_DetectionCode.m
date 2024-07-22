clc
clear

user_data1 = input("Enter data : ");
encoded_data = dec2bin(user_data1);

% For Even Parity
codeword = [];
cnt1 = 0;
for i=1:length(encoded_data)
    codeword(i) = encoded_data(i) - '0';
    if(codeword(i) == 1)
        cnt1 = cnt1 + 1;
    end
end

if(mod(cnt1, 2) == 0)
    codeword = [codeword 0];
else
    codeword = [codeword 1];
end

received_data1 = input("Enter received data : ");
encoded_received = dec2bin(received_data1);

received_codeword = [];
cnt2 = 0;
for i=1:length(encoded_received)
    received_codeword(i) = encoded_received(i) - '0';
    if(received_codeword(i) == 1)
        cnt2 = cnt2 + 1;
    end
end

if(mod(cnt2, 2) == 0)
    received_codeword = [received_codeword 0];
else
    received_codeword = [received_codeword 1];
end

n1 = length(codeword);
n2 = length(received_codeword);

if(n2 > n1)
    codeword = [zeros(1, abs(n1 - n2)), codeword];
end

if(n1 > n2)
    received_codeword = [zeros(1, abs(n1 - n2)), received_codeword];
end

codeword
received_codeword

% Check for errors
parity_check = 0;
for i=1:length(received_codeword)
    parity_check = xor(parity_check, received_codeword(i));
end

if parity_check == 1
    disp("Error detected!!!");
else
    disp("No error was found!!!");
end
