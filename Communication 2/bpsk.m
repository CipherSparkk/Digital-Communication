clc;
clear;

data = input("Enter input bit stream : ", 's'); 
am = input("Enter amplitude of carrier signal : ");
fc = input("Enter frequency of carrier signal (<=5 for better view) : ");

bits = zeros(1, length(data));
for i = 1:length(data)
    bits(i) = str2double(data(i));
end

bits = [bits bits(end)]; 

n = length(bits);
range = 0:n-1;

t = 0:0.01:(n-1);

% Carrier Signal
carrier = am * sin(2*pi*fc*t);
bit_stream = zeros(size(t));

k = 1;
for i = 1:n-1
    for j = 1:100
        if bits(i) == 1
            bit_stream(k) = 1;
        else
            bit_stream(k) = -1;
        end
        k = k + 1;
    end
end

% Modulated Signal
modulated_signal = bit_stream .* carrier;

% Demodulation
demodulated_signal = zeros(1,length(t));
for k = 1:length(t)
    if modulated_signal(k) == carrier(k)
        demodulated_signal(k) = 1;
    else
        demodulated_signal(k) = 0;
    end
end

figure(1)
subplot(2,1,1)
stairs(range, bits, 'LineWidth', 2)
ylim([-1 2])
title("Digital Signal")

subplot(2,1,2)
plot(t,carrier, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Carrier Signal : Sin(w1t)")

figure(2)
subplot(2,1,1)
plot(t,modulated_signal, 'LineWidth', 1.5)
ylim([-(am+1) am+1])
title("Modulated Signal")

subplot(2,1,2)
plot(t,demodulated_signal, 'LineWidth', 2)
ylim([-1 2])
title("Demodulated Signal")
