clc;
clear;

Ts = 2*pi/75;
t = 0:Ts:2*pi;
am = input("Enter message signal amplitude: ");

% Message signal (Assuming 2*pi*f = 1)
msg = am + am*sin(t);

delta = am*4*Ts/3;

dm_output = [zeros(1,101)];
incremented_output = am-0.00001;


for i=1:length(msg)-1
    if incremented_output(i) <= msg(i)
        bit = 0;
        incremented_output(i+1) = incremented_output(i) + delta;
    else
        bit = 1;
        incremented_output(i+1) = incremented_output(i) - delta;
    end
    dm_output(i) = bit;

end

disp("Delat Modulated Output : ");
disp(dm_output);

% Demodulation

% Demodulation

demodulated_dm = ones(size(msg)) * am;

for i=2:length(msg)
    if dm_output(i) == 0
        demodulated_dm(i) = demodulated_dm(i-1) + delta;
    else
        demodulated_dm(i) = demodulated_dm(i-1) - delta;
    end
end

final_output = smooth(demodulated_dm,10);

figure(1);
plot(t,msg,'LineWidth',1.5)
set(gca, 'FontSize', 12);
hold on;
stairs(t,incremented_output,'LineWidth',1);
ylim([-am 2*am+am])
xlim([0 max(t)])
xlabel('time --->')
ylabel('Amplitude')
title('Comparing Message and Delta Modulated Signal')

figure(2);
plot(t,final_output,'LineWidth',1.5)
set(gca, 'FontSize', 12);
ylim([-am 2*am+am])
xlim([0 max(t)])
xlabel('time --->')
ylabel('Amplitude')
title('Demodulated Signal')
