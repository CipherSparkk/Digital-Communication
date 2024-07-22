clc;
clear;

data = input("Enter input bit stream : ", 's'); 
am = input("Enter amplitude of carrier signal : ");
fc = input("Enter frequency of carrier signal (<=5 for better view) : ");

% For ensuring length of input stream is always even
if mod(length(data),2) ~= 0
    data = ['0' data];
end

bits = zeros(1, length(data));
for i = 1:length(data)
    bits(i) = str2double(data(i));
end

bits = [bits bits(end)]; 

n = length(bits);
range = 0:n-1;

t = 0:0.01:(n-1);

% Carrier Signal
carrier_00 = am*sin(2*pi*fc*t + 3*pi/4);
carrier_10 = am*sin(2*pi*fc*t + pi/4);
carrier_01 = am*sin(2*pi*fc*t + 5*pi/4);
carrier_11 = am*sin(2*pi*fc*t + 7*pi/4);

bit_stream = zeros(size(t));

k = 1;
for i = 2:2:n
    for j = 0:0.01:1.99
        if bits(i-1) == 0 && bits(i) == 0
            bit_stream(k) = am*sin(2*pi*fc*j + 3*pi/4);
        end
        if bits(i-1) == 0 && bits(i) == 1
            bit_stream(k) = am*sin(2*pi*fc*j + 5*pi/4);
        end
        if bits(i-1) == 1 && bits(i) == 0
            bit_stream(k) = am*sin(2*pi*fc*j + pi/4);
        end
        if bits(i-1) == 1 && bits(i) == 1
            bit_stream(k) = am*sin(2*pi*fc*j + 7*pi/4);
        end
        k = k + 1;
    end
end

% Modulation
modulated_signal = bit_stream;

% Demodulation
demodulated_signal = [zeros(1,length(range)-1)];
j = 1;
for i=1:200:length(t)-1
    if modulated_signal(i) == carrier_00(1)
        demodulated_signal(j) = 0;
        demodulated_signal(j+1) = 0;
    elseif modulated_signal(i) == carrier_01(1)
        demodulated_signal(j) = 0;
        demodulated_signal(j+1) = 1;
    elseif modulated_signal(i) == carrier_10(i)
        demodulated_signal(j) = 1;
        demodulated_signal(j+1) = 0;
    else
        demodulated_signal(j) = 1;
        demodulated_signal(j+1) = 1;
    end
    j = j+2;
end

demodulated_signal = [demodulated_signal demodulated_signal(end)];

figure(1)
subplot(2,1,1)
stairs(range, bits, 'LineWidth', 2)
ylim([-1 2])
title("Digital Signal")

figure(2)
subplot(4,1,1)
plot(t,carrier_00, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Carrier 1 --- be : 0 , bo = 0")

subplot(4,1,2)
stairs(t,carrier_01, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Carrier 2 --- be : 0 , bo = 1")

subplot(4,1,3)
plot(t,carrier_10, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Carrier 3 --- be : 1 , bo = 0")

subplot(4,1,4)
plot(t,carrier_11, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Carrier 4 --- be : 1 , bo = 1")

figure(3)
subplot(2,1,1)
plot(t,modulated_signal, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Modulated Signal")

subplot(2,1,2)
stairs(range,demodulated_signal, 'LineWidth', 2)
ylim([-1 2])
title("Demodulated Signal")