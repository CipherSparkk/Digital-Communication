clc
clear

data = input("Enter input bit stream : ", 's'); 
am = input("Enter carrier signal amplitude : ");
fc = input("Enter carrier frequency : ");

bits = [];
for i = 1:length(data)
    bits(i) = data(i) - '0'; 
end

bits = [bits bits(end)]; 

n = length(bits);
range = 0:n-1;

t = 0:0.01:(n-1.01);
% Carrier Signal
carrier = am*cos(2*pi*fc*t);

bit_stream = [];

k = 1;
for i=1:n-1
    for j=1:100
        if(bits(i) == 1)
            bit_stream(k) = 1;
        else
            bit_stream(k) = 0;
        end
        k = k+1;
    end
end

% Modulated Signal
modulated_signal = bit_stream.*carrier;

% Demodulated Signal
demod_signal = [];
for i=1:length(t)
    if(modulated_signal(i) > 0)
        demod_signal(i) = 1;
    else
        demod_signal(i) = 0;
    end
end


figure(1)
subplot(2,1,1)
stairs(range, bits, 'LineWidth', 2)
ylim([-1 2])
title("Input Bit stream")

subplot(2,1,2)
plot(t,carrier, 'LineWidth', 1)
ylim([-(am+1) am+1])
title("Carrier Signal : Cos(wot)")

figure(2)
subplot(2,1,1)
plot(t,modulated_signal, 'LineWidth',1)
ylim([-(am+1) am+1])
title("Modulated Signal")


subplot(2,1,2)
plot(t,demod_signal, 'LineWidth',2)
ylim([-1 2])
title("Demodulated Signal")

