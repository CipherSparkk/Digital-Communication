clc;
clear;

% No. of bits
n = 3;

t = 0:0.2:2*pi;

% Message signal
am = 5;
msg = am + am*sin(t);

% No. of quantization levels 
lvl = 2^n;
q = 2*am/lvl;

amp = 0:q:2*am;

% Quantization Process
quant = [];

for i=1:length(msg)
    j=1;
    while(true)
        if(msg(i) - amp(j) <= q/2)
            quant(i) = amp(j);
            break;
        else
            j=j+1;
        end
    end
    i = i+1;
end

% Encoding quantized signal
encoded_msg = dec2bin(quant);
% Decoding quantized signal
decoded_msg = bin2dec(encoded_msg);

% Plot for message signal
figure(1)
subplot(2,1,1)
plot(t,msg,'LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Message Signal')

% Plot after Sampling
subplot(2,1,2)
stem(t,msg,'LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Sampled Signal')

% Plot after Quantization
figure(2)
subplot(2,1,1)
stem(t,quant,'LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Quantized Signal')

subplot(2,1,2)
stairs(t,quant,'LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Quantized Signal (staircase pattern)')

% Plot after Demodulation
figure(3)
subplot(2,1,1)
plot(t,decoded_msg,'r','LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Demodulated Signal')

subplot(2,1,2)
plot(t,msg,'LineWidth',1.5)
set(gca, 'FontSize', 15);
hold on;
plot(t,decoded_msg,'r','LineWidth',1.5)
set(gca, 'FontSize', 15);
xlabel('time --->')
ylabel('Amplitude')
ylim([min(msg)-4, max(msg)+4])
title('Comparing Message and Demodulated Signal')
legend('Message Signal', 'Demodulated Signal')

