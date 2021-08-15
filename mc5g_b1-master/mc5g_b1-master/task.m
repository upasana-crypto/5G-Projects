clear; close all;

M_R = 80; % number of antennas at receiver
users = 8; % number os users
avg = 1e4; % number of realizations 
sum_rate = zeros(3,avg);

for i = 1:avg

    H=1/sqrt(2)*(randn(M_R,8)+1j*randn(M_R,8));
    H_sum = zeros(M_R);
    
    % MU-MIMO rate
    sum_rate(1,i) = log2(real(det(eye(M_R)+H*H')));
    
    % orthotogonalized rate
    for j = 1:users
        user_channel = H(:,j)*H(:,j)';
        H_sum = H_sum + user_channel;
        sum_rate(2,i) = sum_rate(2,i) + 1/users*log2(real(det(eye(M_R)+user_channel)));
    end
    
    % rate with interference
    % https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4450815
    for j = 1:users
        user_channel = H(:,j)*H(:,j)';
        interference = H_sum - user_channel;
        sum_rate(3,i) = sum_rate(3,i) + log2(real(det(eye(M_R)+H_sum))) - log2(real(det(eye(M_R)+interference)));
    end
    
end

[F1,X1] = ecdf(sum_rate(1,:));
[F2,X2] = ecdf(sum_rate(2,:));
[F3,X3] = ecdf(sum_rate(3,:));

figure(1)
hold on
plot(X1,F1,'LineWidth',2)
plot(X2,F2,'LineWidth',2)
plot(X3,F3,'LineWidth',2)
xlabel('sum-rate [bit/s/Hz]')
ylabel('CDF')
legend('MU-MIMO','orthogonalization','interference')
grid ON
grid MINOR