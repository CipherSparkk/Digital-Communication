clc;
clear;

Ts = 2*pi/75;
t = 0:Ts:2*pi;
am = input("Enter message signal amplitude: ");

% Message signal (Assuming 2*pi*f = 1)
msg = am + am*sin(t);

delta = am*2*Ts;

adm_output = zeros(1, length(msg));
incremented_output = am-0.00001;

deltas_array = [delta zeros((size(msg)-1))];

for i = 1:length(msg)-1
    if i > 1
        % Calculate adaptive delta
        delta = abs(msg(i) - msg(i-1)) / (5.5*Ts);
    end
    if incremented_output(i) <= msg(i)
        bit = 0;
        deltas_array(i) = delta;
        incremented_output(i+1) = incremented_output(i) + delta;
    else
        bit = 1;
        deltas_array(i) = -delta;
        incremented_output(i+1) = incremented_output(i) - delta;
    end
    adm_output(i) = bit;
end

% Demodulation
demodulated_adm = ones(size(msg)) * am;

for i=1:length(msg)-1
    demodulated_adm(i+1) = demodulated_adm(i) + deltas_array(i);
end

final_output = smooth(demodulated_adm, 10);

disp("Adaptive Delta Modulated Output : ");
disp(adm_output);

figure(1);
plot(t, msg, 'LineWidth', 1.5)
set(gca, 'FontSize', 12);
hold on;
stairs(t, incremented_output, 'LineWidth', 1);
ylim([-am 2*am+am])
xlim([0 max(t)])
xlabel('time --->')
ylabel('Amplitude')
title('Comparing Message and Adaptive Delta Modulated Signal')

figure(2);
plot(t,final_output,'LineWidth',1.5)
set(gca, 'FontSize', 12);
ylim([-am 2*am+am])
xlim([0 max(t)])
xlabel('time --->')
ylabel('Amplitude')
title('Demodulated Signal')

