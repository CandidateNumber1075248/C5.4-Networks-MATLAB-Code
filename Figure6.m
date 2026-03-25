clc
clf
clear all
close all
set(0,'DefaultAxesFontSize',25);
set(0,'DefaultAxesFontName','Times New Roman');

%Setting the range of parameters to be used
N_values=round(linspace(100,5000,30));
p_values=[0.3,0.5,0.7];

%Number of trials to take the mean over
trials=100;

%Empty matrices to store data for k_max across parameter space
k_max_mean=zeros(length(p_values),length(N_values));
kmax_trials=zeros(trials,1);

for i=1:length(p_values)

    for j=1:length(N_values)

        for trial=1:trials

            %Generating the adjacency matrix for the network
            A=aon_network(N_values(j), p_values(i));

            %Derive the degree of each node using the adjacency matrix
            degree=sum(A,2);

            %Find the maximum degree within the network
            kmax_trials(trial)=max(degree);

        end

        %Taking mean over simulations
        k_max_mean(i,j)=mean(kmax_trials);

    end
end

%Generating the analytical prediction
k_max_analytical=zeros(size(k_max_mean));

for i=1:length(p_values)
    k_max_analytical(i,:) = k_max_mean(i,1)*(N_values.^p_values(i))/(N_values(1)^p_values(i))-1/p_values(i);
end

figure;
hold on;

%Plotting the simulated result and analytical prediction for each p-value
a1=plot(N_values,k_max_mean(1,:),'-','LineWidth', 1.5,'color','#0f46a6','DisplayName','p=0.3');
plot(N_values,k_max_analytical(1,:),'--','LineWidth', 1.5,'color','#0f46a6')

a2=plot(N_values,k_max_mean(2,:),'-','LineWidth', 1.5,'color','red','DisplayName','p=0.5');
plot(N_values,k_max_analytical(2,:),'--','LineWidth', 1.5,'color','red')

a3=plot(N_values,k_max_mean(3,:),'-','LineWidth', 1.5,'color','#0f8a57','DisplayName','p=0.7');
plot(N_values,k_max_analytical(3,:),'--','LineWidth', 1.5,'color','#0f8a57')


xlabel('Number of Nodes, N');
ylabel('Maximum degree, k_{max}');
legend([a1,a2,a3],'Location','best')
title('Figure 6');

grid on;
