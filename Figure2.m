clc
clf
clear all
close all
set(0,'DefaultAxesFontSize',25);
set(0,'DefaultAxesFontName','Times New Roman');

%Setting the initial parameters
N_max=10000;
p=0.1;

%Generating the adjacency matrix for the network
A=aon_network(N_max,p);

%Calculate the degree of each node from the adjacency matrix
k=sum(A,2);

%Forming the degree distribution
k_max=max(k);
distribution=histcounts(k,0:k_max+1);
P=distribution/N_max;

%Generating power-law distribution prediction
x=linspace(1,k_max+1,1000);
y=zeros(1,1000);

for j=1:1000
    y(1,j)=(1.5*10^11)*(x(j)+1/p)^(-1-1/p);
end

%Removing the k=0 case
P_results=zeros(1,k_max+1);
for i=1:k_max
    P_results(i)=P(i+1);
end


%Plotting both simulated result and power-law distribution
plot((1:k_max+1)',P_results,'DisplayName','Simulated Result')
hold on;
plot(x,y,'DisplayName','Power-law Distribution')
hold off;
xlabel('Degree, \itk', 'Interpreter','tex');
ylabel('Degree Distribution, \itP(k)', 'Interpreter','tex')
title('Figure 2')
legend;