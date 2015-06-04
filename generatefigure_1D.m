%% WE WANT TO PERMUTE OVER ALL THE POSSIBLE RULESETS , SO:
clear all;

%I have 6 states from that email. Lets see what I can do with them. Hmm...
total_states = 6 ;
ruleset=[];
%Random sizes and times for 1D initialization.
size = 21;

time = 21;







    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RULE
%The ruleset here is the new state when a cell receives a signal
%First line is change in state when you do receive a signal
%Second line is a change in state when you do not receive a signal



rule_original = [ 2 , 0 ;...
                  3 , 0 ;...
                  4 , 0 ;...
                  5 , 0 ;...
                  2 , 0 ;...
                  1 , 0 ] ;

rule = rule_original(:,1) ;




rule = [ rule rule rule rule rule rule];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GRAPH FOR ACYCLIC - LEBON ET AL
graph = zeros(total_states,total_states);

%The graph from the lauren paper is the following DAG
graph = [ 0 , 0 , 0 , 0 , 0 , 0 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 1 , 0 , 1 , 0 ] ;
      

final = rule .* graph ;
          



%A graph with a cycle so we can see a comparision
cycle_graph = [ 1 , 1 , 1 , 1 , 1 , 1 ;...
                1 , 1 , 1 , 1 , 1 , 1 ;...
                1 , 1 , 1 , 1 , 1 , 1 ;...
                1 , 1 , 1 , 1 , 1 , 1 ;...
                1 , 1 , 1 , 1 , 1 , 1 ;...
                1 , 1 , 1 , 1 , 1 , 1 ] ;
      

cycle_final = rule .* cycle_graph ;
          


        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%HOW CAN THERE BE A CYCLIC GRAPH , WHAT ARE THE RULES AND EQUATIONS THAT
%WOULD GIVE US A CYCLIC GRAPH. THINK ABOUT IT.



    
% I am imposing a condition here : the rule must not allow 1->1 , 2->2
% ,etc. Basically, I am not allowing no transition


    
    
ruleset=[ruleset rule_original];

    


%TYPE AND SIZE DEFINITION
A = randi([1 total_states],1,size);
A = repmat ( A, time, 1);



%B is A for cyclic
B = A;

%
%Now what I am going to do is, I am going to have a ruleset and then when I
%am going to compare the results for graphs that have cycles and graphs
%that do not have cycles! And then I will change the initializations and
%the rulesets to see where that takes us.

%THREE THINGS THAT CAN COMPLETELY DEFINE FATE FOR OUR DETERMINISTIC MODEL:
    %GRAPH
    %RULESET
    %INITIALIZATION
    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%INITIALIZATION
%Different ways to initialize the cells










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UPDATION 



for(t= 1:time-1),

%
    for(i=2:size-1)
       
        %%FOR ACYCLIC
        if( graph(A(t,i),A(t,i-1)) ~= 0  ) ,
                A(t+1,i) = final(A(t,i) ,A(t,i-1));
                
                
        elseif( graph(A(t,i),A(t,i+1)) ~= 0 )
                A(t+1,i) = final(A(t,i) ,A(t,i+1));
               
                
        else
                A(t+1,i) = A(t,i);

        end
        
        
        %FOR CYCLIC   
           if(   cycle_graph(B(t,i),B(t,i-1)) ~= 0  ) ,
                B(t+1,i) = cycle_final(B(t,i) ,B(t,i-1));
                
                
           elseif( cycle_graph(B(t,i),B(t,i+1)) ~= 0 ) 
                B(t+1,i) = cycle_final(B(t,i) ,B(t,i+1));
                
           else
                B(t+1,i) = B(t,i);

           end
        

        
    end
end



if 1 % no need for figures

figure

subplot(121);
%%%PLOT FOR ACYCLIC
h = imagesc(A(1:time-1,1:size-1)');
axis square;
caxis([1 6]);
colormap(parula(6));
q = colorbar;
q.Location = 'southoutside';
xlabel(q, 'State Marker');

ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Acyclic | Rule: ',mat2str(rule_original(:,1))))
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : time -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%


subplot(122);
%%%PLOT FOR CYCLIC
h = imagesc(B(1:time-1,1:size-1)');
axis square;
caxis([1 6]);
colormap(parula(6));
q = colorbar;
q.Location = 'southoutside';
%lcolorbar(labels,'fontweight','bold');


xlabel(q, 'State Marker');
ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Cyclic | Rule: ',mat2str(rule_original(:,1))));
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : time -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%

end %No need for figures

%%Save Figure
%savefig(strcat(mat2str(big),mat2str(rule_original(:,1))))
%saveas(gcf,strcat(mat2str(big),mat2str(rule_original(:,1)),'.png'))
%clearvars -except big;
%close all



%%

%save('1D_statistics_deranged_trackowitz','stat','ruleset')