%% %% PARFOR NEEDS TO WORK
tic
%% WE WANT TO PERMUTE OVER ALL THE POSSIBLE RULESETS , SO:
clear all;
P = PermsRep([1 2 3 4 5 6]);
P = P';
total_permutations = size(P,2);
%I have 6 states from that email. Lets see what I can do with them. Hmm...
total_states = 6 ;
%Random sizes and times for 1D initialization.
size = 21;
time = 21;




index_set=[];
parfor i=1:1:total_permutations

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

total_valid_rulesets = numel(index_set);
%%



acyclic_event3=zeros(total_valid_rulesets,10);
cyclic_event3=zeros(total_valid_rulesets,10);
acyclic_time3=zeros(total_valid_rulesets,10);
cyclic_time3=zeros(total_valid_rulesets,10);
ruleset=zeros(6,total_valid_rulesets);


%%
for big = index_set %loop over all possible rulesets


big
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







if 0% we dont need this for the statistics section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RULE
%The ruleset here is the new state when a cell receives a signal
%First line is change in state when you do receive a signal
%Second line is a change in state when you do not receive a signal
rule_original = [ 6 , 0 ;...
         2 , 0 ;...
         3 , 0 ;...
         4 , 0 ;...
         5 , 0 ;...
         1 , 0 ] ;

rule = rule_original(:,1) ;


end

rule_original = P(:,big);
rule=rule_original;
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



%%

%A graph with a cycle so we can see a comparision
cycle_graph = [ 0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 0 , 0 , 0 , 0 , 0 ;...
                0 , 1 , 0 , 0 , 0 , 1 ;...
                1 , 0 , 0 , 1 , 0 , 0 ;...
                0 , 0 , 1 , 0 , 1 , 0 ] ;


cycle_final = rule .* cycle_graph ;

%cycle_final
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%HOW CAN THERE BE A CYCLIC GRAPH , WHAT ARE THE RULES AND EQUATIONS THAT
%WOULD GIVE US A CYCLIC GRAPH. THINK ABOUT IT.


ruleset(:,big)= rule_original ;


acyclic_event2=zeros(1,10);
cyclic_event2=zeros(1,10);
acyclic_time2=zeros(1,10);
cyclic_time2=zeros(1,10);


for sample_initialization = 1:1:10




%TYPE AND SIZE DEFINITION
A = randi([1 total_states],size,size,1);

%%
%%%%%%%%%%
%INITIALIZING FOR LAUREN PAPER


%%
A = repmat(A,[1 1 time]);
%imagesc(A(:,:,4))


%B is A for cyclic
B = A;




acyclic_event1=0;
cyclic_event1=0;
acyclic_time1=1;
cyclic_time1=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UPDATION

for(t= 1:time-1),

%
    for(x=2:size-1)
        for(y=2:size-1)


            a_signal=0;
            c_signal=0;


        %%FOR ACYCLIC and ACYCLIC


                    %CHECK FOR THE ACYCLIC GRAPH

                    %-1,-1

                    if( graph(A(x,y,t),A(x-1,y-1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x-1;
                        a_signal_y = y-1;
                    end

                     %-1,0
                    if( graph(A(x,y,t),A(x-1,y,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x-1;
                        a_signal_y = y;
                    end

                     %-1,1
                    if( graph(A(x,y,t),A(x-1,y+1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x-1;
                        a_signal_y = y+1;
                    end

                     %0,-1
                    if( graph(A(x,y,t),A(x,y-1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x;
                        a_signal_y = y-1;
                    end


                     %0,1
                    if( graph(A(x,y,t),A(x,y+1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x;
                        a_signal_y = y+1;
                    end


                     %1,-1
                    if( graph(A(x,y,t),A(x+1,y-1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x+1;
                        a_signal_y = y-1;
                    end

                     %1,0
                    if( graph(A(x,y,t),A(x+1,y,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x+1;
                        a_signal_y = y;
                    end

                     %1,1
                    if( graph(A(x,y,t),A(x+1,y+1,t)) ~= 0  ) ,
                        a_signal=1;
                        a_signal_x = x+1;
                        a_signal_y = y+1;
                    end












                    %CHECK FOR THE CYCLIC GRAPH

                    %-1,-1
                    if( cycle_graph(B(x,y,t),B(x-1,y-1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x-1;
                        c_signal_y = y-1;

                    end

                    %-1,0
                    if( cycle_graph(B(x,y,t),B(x-1,y,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x-1;
                        c_signal_y = y;

                    end

                    %-1,1
                    if( cycle_graph(B(x,y,t),B(x-1,y+1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x-1;
                        c_signal_y = y+1;

                    end

                    %0,-1
                    if( cycle_graph(B(x,y,t),B(x,y-1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x;
                        c_signal_y = y-1;

                    end

                    %0,1
                    if( cycle_graph(B(x,y,t),B(x,y+1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x;
                        c_signal_y = y+1;

                    end

                    %1,-1
                    if( cycle_graph(B(x,y,t),B(x+1,y-1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x+1;
                        c_signal_y = y-1;

                    end

                    %1,0
                    if( cycle_graph(B(x,y,t),B(x+1,y,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x+1;
                        c_signal_y = y;

                    end

                    %1,1
                    if( cycle_graph(B(x,y,t),B(x+1,y+1,t)) ~= 0  ) ,
                        c_signal=1;
                        c_signal_x = x+1;
                        c_signal_y = y+1;

                    end



            %%SIGNAL DECISION FOR ACYCLIC
                    if( a_signal == 1 ) ,
                        A(x,y,t+1) = final(A(x,y,t) ,A(a_signal_x,a_signal_y,t));
                         acyclic_event1=acyclic_event1+1;
                         acyclic_time1=t;

                    else
                        A(x,y,t+1) = A(x,y,t);

                    end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


           %%SIGNAL DECISION for CYCLIC
                    if( c_signal == 1 ) ,
                        B(x,y,t+1) = cycle_final(B(x,y,t) ,B(c_signal_x,c_signal_y,t));
                         cyclic_event1=cyclic_event1+1;
                         cyclic_time1=t;

                    else
                        B(x,y,t+1) = B(x,y,t);

                    end




        end
    end
end
%%

acyclic_event2(1,sample_initialization)=acyclic_event1;
cyclic_event2(1,sample_initialization)=cyclic_event1;
acyclic_time2(1,sample_initialization)=acyclic_time1;
cyclic_time2(1,sample_initialization)=cyclic_time1;

%%
if 0 % we dont need this section for now !
figure

for(rec=1:time)

subplot(121);
%%%PLOT FOR ACYCLIC
h = imagesc(A(2:size-2,2:size-2,rec));
axis square;
caxis([1 6]);
colormap(jet(6));
q = colorbar;
q.Location = 'southoutside';
xlabel(q, 'State Marker');

ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Acyclic | Rule: ',mat2str(rule_original(:,1))))
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : size -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%


subplot(122);
%%%PLOT FOR CYCLIC
h = imagesc(B(2:size-2,2:size-2,rec));
axis square;
caxis([1 6]);
colormap(jet(6));
q = colorbar;
q.Location = 'southoutside';
%set(q,'YTick',[1,2,3,4,5,6])

%lcolorbar(labels,'fontweight','bold');


xlabel(q, 'State Marker');
ylabel('Cell Position');
xlabel('Time Step');
title(strcat('Cyclic | Rule: ',mat2str(rule_original(:,1))));
ax = gca;
ax.YTick = 1.5 : 1 : size -0.5;
ax.XTick = 1.5 : 1 : size -0.5;
ax.YGrid = 'on';
ax.XGrid = 'on';
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%%%


%M(rec) = getframe(gcf);
%close all;
end

end %if statement

%%Save Figure
%savefig(strcat(mat2str(big),mat2str(rule_original(:,1))))
%saveas(gcf,strcat(mat2str(big),mat2str(rule_original(:,1)),'.png'))
%clearvars -except big;
%end

end

acyclic_event3(big,:)=acyclic_event2;
cyclic_event3(big,:)=cyclic_event2;
acyclic_time3(big,:)=acyclic_time2;
cyclic_time3(big,:)=cyclic_time2;

%%
%movie2avi(M,strcat(mat2str(rule_original(:,1)),'.avi'))
end

save('ligands3_states6_cyclesize3','index_set','ruleset','acyclic_event3','cyclic_event3','acyclic_time3','cyclic_time3')
toc