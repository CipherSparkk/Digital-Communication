n = input("Enter length of data : ");

range = 0:1:n;
range1 = 0:1/2:n;

data = [];

disp("Enter data (only 0 or 1)");
for i=1:n
    x = input("> ");
    if(x == 1 || x == 0)
        data(i) = x;
        i = i+1; 
    else
        disp("Wrong Input!!!")
    end
end

amp = 2;

disp("So, entered code is : ");
disp(data)

data = [data data(i-1)];

% For Uni-Polar Non-Returned to Zero
uni_polar_nrz = [zeros(1,n)];
for i=1:length(range)
    if(i == length(range))
        uni_polar_nrz(i) = 0;
    else 
        if(data(i) == 1)
        uni_polar_nrz(i) = amp;
        end
    end
    i = i+1;
end

% For Uni-Polar Returned to Zero
uni_polar_rz = [zeros(1,length(range1))];
j=1;
for i=1:length(range)
    if(j == length(range1))
        uni_polar_rz(j) = 0;
    else 
        if(data(i) == 1)
            uni_polar_rz(j) = amp;
        end
    end
    i = i+1;
    j = j+2;
end

% For Polar Non-Returned to Zero
polar_nrz = [];
for i=1:length(range)
    if(i == length(range1))
        polar_nrz(i) = 0;
    else 
        if(data(i) == 1)
            polar_nrz(i) = amp;
        else
            polar_nrz(i) = -amp;
        end
    end
    i = i+1;
end

% For Polar Returned to Zero
polar_rz = [zeros(1,length(range1))];
j=1;
for i=1:length(range)
    if(j == length(range1))
        polar_rz(j) = 0;
    else 
        if(data(i) == 1)
            polar_rz(j) = amp;
        else
            polar_rz(j) = -amp;
        end
    end
    i = i+1;
    j = j+2;
end

% For Bi-Polar Non-Returned to Zero
bi_polar_nrz = [zeros(1,length(range))];
check = 1;
for i=1:length(range)
    if(i == length(range))
        bi_polar_nrz(i) = 0;
    else 
        if(data(i) == 1)
            if(check == 1)
                bi_polar_nrz(i) = amp;
            else
                bi_polar_nrz(i) = -amp;
            end
            check = -check;
        end
    end
    i = i+1;
end

% For Bi-Polar Returned to Zero
bi_polar_rz = [zeros(1,length(range1))];
j=1;
check = 1;
for i=1:length(range)
    if(j == length(range1))
        bi_polar_rz(j) = 0;
    else 
        if(data(i) == 1)
            if(check == 1)
                bi_polar_rz(j) = amp;
            else
                bi_polar_rz(j) = -amp;
            end
            check = -check;
        end
    end
    i = i+1;
    j = j+2;
end

% For Manchester Code
manchester = [];
j = 1;
for i=1:length(range)
    if(j == length(range1))
        manchester(j) = 0;
    else
        if(data(i) == 1)
            manchester(j) = amp;
            j = j+1;
            manchester(j) = -amp;
        else
            manchester(j) = -amp;
            j = j+1;
            manchester(j) = amp;
        end
    end
    i = i+1;
    j = j+1;
end
    
% For Plotting Uni-Polar 
figure(1)
subplot(2,1,1)
stairs(range,uni_polar_nrz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Uni-Polar NRZ')

subplot(2,1,2)
stairs(range1,uni_polar_rz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Uni-Polar RZ')

% For Plotting Polar 
figure(2)
subplot(2,1,1)
stairs(range,polar_nrz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Polar NRZ')

subplot(2,1,2)
stairs(range1,polar_rz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Polar RZ')

% For Plotting Bi-Polar 
figure(3)
subplot(2,1,1)
stairs(range,bi_polar_nrz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Bi-Polar NRZ')

subplot(2,1,2)
stairs(range1,bi_polar_rz,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
xticks(range)
ylabel('Amplitude')
ylim([-4,4])
title('Bi-Polar RZ')

% For Plotting Manchester Code 
figure(4)
subplot(2,1,1)
stairs(range1,manchester,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 14);
xlabel('Tb--->')
ylabel('Amplitude')
xticks(range)
ylim([-4,4])
title('Manchester Code')

