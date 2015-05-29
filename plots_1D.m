%%Writing code to generate histograms!

%% Load the datafile
clear all;

load('1D_statistics_deranged_trackowitz')

%%
clear P;
P = PermsRep([1 2 3 4 5 6]);
P = P';
total_permutations = size(P,2);
%% 



%% 
plot_acyclic_time = [];
plot_cyclic_time = [];
%%FIND THE INDEXes THAT are ALLOWED
index_set=[];
for i=1:1:total_permutations
    
    rule_original = P(:,i); 

    if (rule_original(1)~=1 & ...
        rule_original(2)~=2 & ...
        rule_original(3)~=3 & ...
        rule_original(4)~=4 & ...
        rule_original(5)~=5 & ...
        rule_original(6)~=6 )
            index_set=[index_set i];
            
    end       
end


%%

sample = 1;

acyclic_time_matrix = [];
cyclic_time_matrix = [];
acyclic_event_matrix = [];
cyclic_event_matrix = [];
        


    
for index = index_set
    
         acyclic_time_matrix1 = [];
         cyclic_time_matrix1 = [];
         acyclic_event_matrix1 = [];
         cyclcic_event_matrix1 = [];
       
    
    for sample = 1:1:20,
          acyclic_time_matrix1 = [acyclic_time_matrix1 stat(index).acyclic(sample).time];
          cyclic_time_matrix1 = [cyclic_time_matrix1 stat(index).cyclic(sample).time];
          acyclic_event_matrix1 = [acyclic_event_matrix1 stat(index).acyclic(sample).event];
          cyclcic_event_matrix1 = [cyclcic_event_matrix1 stat(index).cyclic(sample).event];
    end
    
    
    acyclic_time_matrix = [acyclic_time_matrix ;acyclic_time_matrix1];
    cyclic_time_matrix = [cyclic_time_matrix ;cyclic_time_matrix1];
    acyclic_event_matrix = [acyclic_event_matrix ;acyclic_event_matrix1];
    cyclic_event_matrix = [cyclic_event_matrix ; cyclcic_event_matrix1 ];
end
    
    

%% SCATTER PLOt
scatterhist(mean(acyclic_time_matrix,2), mean(cyclic_time_matrix,2))


    %% COOL Scatter Plot
    AB = [mean(acyclic_event_matrix,2) mean(cyclic_event_matrix,2)]
% Find unique rows and corresponding indices
[uniqueAB, ~, n] = unique(AB, 'rows');
% Find number of occurrences
nHist = hist(n, unique(n));
mx = max(nHist);
% Create colors for each number of occurrence
colors = jet(mx);
colormap(colors);
% Construct a color matrix
cMatrix = colors(nHist, :);
% Create scatter plot
scatter(uniqueAB(:, 1), uniqueAB(:, 2), 25, cMatrix, 'filled');
colorbar('YTick', linspace(1/(2*mx), 1-1/(2*mx), mx), ...
         'YTickLabel', 1:mx);
    
    %%
    
figure
subplot(121)
histogram(mean(acyclic_event_matrix,2), 1:1:100)

subplot(122);
histogram(mean(cyclic_event_matrix,2), 1:1:100)
