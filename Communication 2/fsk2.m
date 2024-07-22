clc
clear

data = input("Enter input bit stream : ", 's'); 
am = input("Enter carrier signal amplitude : ");
fc_high = input("Enter higher carrier frequency (<=30) : ");
fc_low = input("Enter lower carrier frequency (<=10) : ");

bits = [];
for i = 1:length(data)
    bits(i) = data(i) - '0'; 
end

bits = [bits bits(end)]; 

n = length(bits);
range = 0:n-1;

t = 0:0.01:(n-1.01);
% Carrier Signal
carrier_high = am*cos(2*pi*fc_high*t);
carrier_low = am*cos(2*pi*fc_low*t);

% For high frequency
fsk_high = [];
fsk_low = [];
k = 1;
m = 1;
for i=1:n-1
    for j=1:100
        if bits(k) == 1
            fsk_high(m) = carrier_high(m);
            fsk_low(m) = 0;
        else
            fsk_high(m) = 0;
            fsk_low(m) = carrier_low(m);
        end
        m = m+1;
    end
    k = k+1;
end

% Modulated Signal
modulated_signal = fsk_high + fsk_low;

% Demodulation Process -- Coherent
demod_high = fsk_high.*carrier_high;
demod_low = fsk_low.*carrier_low;

% Low-pass filtering
[b, a] = butter(6, fc_high * 2 * 0.01, 'low');
demod_filtered_high = filter(b, a, demod_high);

% Low-pass filtering
[b, a] = butter(6, fc_low * 2 * 0.01, 'low'); 
demod_filtered_low = filter(b, a, demod_low);

% Scaling filtered output by a factor of 2
demod_filtered_high  = demod_filtered_high*2;
demod_filtered_low = demod_filtered_low*2;

for i=1:length(t)
    if demod_filtered_high(i) > demod_filtered_low(i)
        demodulated_signal(i) = demod_filtered_high(i);
    else
        demodulated_signal(i) = 0;
    end
end

figure(1)
subplot(3,1,1)
stairs(range, bits, 'LineWidth', 2)
ylim([-1 2])
xlabel("Tb --->")
ylabel("Amplitude")
title("Input Bit stream")

subplot(3,1,2)
plot(t,carrier_high, 'LineWidth', 1)
xlabel("t --->")
ylabel("Amplitude")
ylim([-(am+1) am+1])
title("High Frequency Carrier Signal : Cos(w1t)")

subplot(3,1,3)
plot(t,carrier_low, 'LineWidth', 1)
ylim([-(am+1) am+1])
xlabel("t --->")
ylabel("Amplitude")
title("Low Frequency Carrier Signal : Cos(w2t)")

figure(2)
subplot(3,1,1)
plot(t,fsk_high, 'LineWidth',1)
ylim([-(am+1) am+1])
xlabel("t --->")
ylabel("Amplitude")
title("High Frequency Component")

subplot(3,1,2)
plot(t,fsk_low, 'LineWidth',1)
ylim([-(am+1) am+1])
xlabel("t --->")
ylabel("Amplitude")
title("Low Frequency Component")

subplot(3,1,3)
plot(t,modulated_signal, 'LineWidth',1)
ylim([-(am+1) am+1])
xlabel("t --->")
ylabel("Amplitude")
title("Modulated Signal")

figure(3)
subplot(2,1,1)
plot(t,demodulated_signal, 'LineWidth',1)
ylim([-(am+1) am+1])
xlabel("Tb --->")
ylabel("Amplitude")
title("Demodulated Signal")

