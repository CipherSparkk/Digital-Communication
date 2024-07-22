clc
clear

% For Hamming Code (7,4)

while(true)
    c_ = input("Enter dataword (i of Ci) : ");
    if(c_ < 16 && c_ >= 0)
        data = dec2bin(c_);
        break
    else
        disp("Wrong Input!!!")
        disp("Enter again")
    end
end

dataword = [];


for i=1:length(data)
    dataword(i) = data(i) - '0';
end

if(length(dataword)<4)
    dataword = [zeros(1,4-length(dataword)) dataword];
end

p1 = xor(xor(dataword(1),dataword(2)),dataword(3));
p2 = xor(xor(dataword(2),dataword(3)),dataword(4));
p3 = xor(xor(dataword(1),dataword(2)),dataword(4));

codeword = [dataword p1 p2 p3]


while(true)
    received_c_ = input("Enter Received word (i of Ci) : ");
    if(received_c_ < 16 && received_c_ >= 0)
        received = dec2bin(received_c_);
        break
    else
        disp("Wrong Input!!!")
        disp("Enter again")
    end
end

receivedword = [];
for i=1:length(received)
    receivedword(i) = received(i) - '0';
end

if(length(receivedword)<4)
    receivedword = [zeros(1,4-length(receivedword)) receivedword];
end

u5 = xor(xor(receivedword(1),receivedword(2)),receivedword(3));
u6 = xor(xor(receivedword(2),receivedword(3)),receivedword(4));
u7 = xor(xor(receivedword(1),receivedword(2)),receivedword(4));

received_codeword = [receivedword u5 u6 u7]

% error_pattern Syndrome
s1 = bitxor(u5,p1);
s2 = bitxor(u6,p2);
s3 = bitxor(u7,p3);

s = [s1 s2 s3];
disp("Error Syndrome : ");
disp(s);

% Convert the array s into a string
num = 0;
for i=1:length(s)
    num = num*10 + s(i);
end
num

error_pattern = [];

% Use switch statement with strcmp comparisons
switch num
    case 0
        error_pattern = [zeros(1, 7)];
    case 100
        error_pattern = [1 zeros(1, 6)];
    case 10
        error_pattern = [0 1 zeros(1, 5)];
    case 1
        error_pattern = [zeros(1, 2) 1 zeros(1, 4)];
    case 110
        error_pattern = [zeros(1, 3) 1 zeros(1, 3)];
    case 11
        error_pattern = [zeros(1, 4) 1 zeros(1, 2)];
    case 111
        error_pattern = [zeros(1, 5) 1 0];
    case 101
        error_pattern = [zeros(1, 6) 1];
end


disp("Error pattern :");
disp(error_pattern); 

% Correcting code word : C = r xor e
corrected_codeword = xor(received_codeword,error_pattern);
correct_data = corrected_codeword(1:4);

if s(1) == 0 && s(2) == 0 && s(3) == 0 && isequal(receivedword, dataword)
    disp("Received code is correct!!!")
    disp("Hence, no error_pattern found")
else
    if nnz(correct_data ~= receivedword) > 1
        disp("More than one bit flipped")
        disp("Hence, can't correct it!!!");
    else
        disp("error_pattern was detected and corrected!");
        disp("Correct Codeword was :");
        disp(corrected_codeword);
        correct_data_str = num2str(correct_data);
        correct_data_deci = bin2dec(correct_data_str);
        disp("Correct data was : ");
        disp(correct_data_deci)
    end
end

