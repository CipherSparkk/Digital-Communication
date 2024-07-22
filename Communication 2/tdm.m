clc;
clear;

f1 = input('Enter frequency for Message Signal 1: ');
a1 = input('Enter amplitude for Message signal 1: ');
disp(newline);

f2 = input('Enter frequency for Message Signal 2: ');
a2 = input('Enter amplitude for Message signal 2: ');
disp(newline);

f3 = input('Enter frequency for Message Signal 3: ');
a3 = input('Enter amplitude for Message signal 3: ');
disp(newline);

Fs = 100;
t = 0:1/Fs:1;

% Message Signal 1
msg1 = a1*sin(2*pi*f1*t);

% Message Signal 2
msg2 = a2*square(2*pi*f2*t);

% Message Signal 3
msg3 = a3*cos(2*pi*f3*t);

% Plotting message signals 
figure(1);
subplot(3,1,1)
plot(t,msg1)
ylim([min(msg1)-1, max(msg1)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Message Signal 1')

subplot(3,1,2)
plot(t,msg2)
ylim([min(msg2)-1, max(msg2)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Message Signal 2')

subplot(3,1,3)
plot(t,msg3)
ylim([min(msg3)-1, max(msg3)+1]);

xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Message Signal 3')

% Multiplexing Signals
t1 = 0:3*(length(t))-1;
j=1;
for i=1:3:length(t1)
    multiplexed_signal(i) = msg1(j);
    i = i+1;
    multiplexed_signal(i) = msg2(j);
    i = i+1;
    multiplexed_signal(i) = msg3(j);
    j= j+1;
end

% Plotting Multiplexed Signal
figure(2);
plot(t1,multiplexed_signal)
ylim([min(multiplexed_signal)-1, max(multiplexed_signal)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Time Division Multiplexing')

% Demultiplexing Multiplexed Signal
new_msg1 = [];
new_msg2 = [];
new_msg3 = [];

j=1;
for i=1:3:length(t1)
    new_msg1(j) = multiplexed_signal(i);
    i = i+1;
    new_msg2(j) = multiplexed_signal(i);
    i = i+1;
    new_msg3(j) = multiplexed_signal(i);
    j = j+1;
end

% PLotting Demultiplexed Signals
figure(3);
subplot(3,1,1)
plot(t,new_msg1)
ylim([min(new_msg1)-1, max(new_msg1)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Demodulated Message Signal 1')

subplot(3,1,2)
plot(t,new_msg2)
ylim([min(new_msg2)-1, max(new_msg2)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Demodulated Message Signal 2')

subplot(3,1,3)
plot(t,new_msg3)
ylim([min(new_msg3)-1, max(new_msg3)+1]);
xlabel('time (sec) --->')
ylabel('Amplitude (V)')
title('Demodulated Message Signal 3')



%[b, a] = butter(5, fm/(Fs/2));  % Design a low-pass filter with cutoff at fm

%demod_s = filter(b, a, demod_s); % Apply the filter



