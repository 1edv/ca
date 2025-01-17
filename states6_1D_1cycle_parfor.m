%% %% PARFOR NEEDS TO WORK

%% WE WANT TO PERMUTE OVER ALL THE POSSIBLE RULESETS , SO:
clear all;
P = PermsRep([1 2 3 4 5 6]);
P = P';
total_permutations = size(P,2);
%I have 6 states from that email. Lets see what I can do with them. Hmm...
total_states = 6 ;
ruleset=[];
%Random sizes and times for 1D initialization.
size = 21;
time = 21;

parfor big = 1:1:total_permutations %loop over all possible rulesets
for sample_initialization=1:1:20
 
stat(big).acyclic(sample_initialization).event=0;
stat(big).acyclic(sample_initialization).time=1;  
stat(big).cyclic(sample_initialization).event=0;
stat(big).cyclic(sample_initialization).time=1;      
    
end
end


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


%% PARFOR WORKS TILL HERE


acyclic_event3=[];
cyclic_event3=[];
acyclic_time3=[];
cyclic_time3=[];

parfor big = 1:1:total_permutations %loop over all possible rulesets

    

    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RULE
%The ruleset here is the new state when a cell receives a signal
%First line is change in state when you do receive a signal
%Second line is a change in state when you do not receive a signal



%rule_original = [ 4 , 0 ;...
 %        3 , 0 ;...
 %        2 , 0 ;...
 %        1 , 0 ;...
 %        4 , 0 ;...
 %        2 , 0 ] ;

%rule = rule_original(:,1) ;


rule_original = P(:,big); 
rule = rule_original;

%%
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
cycle_graph = [ 0 , 0 , 0 , 0 , 0 , 1 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          0 , 0 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          1 , 1 , 0 , 0 , 0 , 0 ;...
          0 , 1 , 1 , 0 , 1 , 0 ] ;
      

cycle_final = rule .* cycle_graph ;
          

if (rule_original(1)~=1 & ...
    rule_original(2)~=2 & ...
    rule_original(3)~=3 & ...
    rule_original(4)~=4 & ...
    rule_original(5)~=5 & ...
    rule_original(6)~=6 )
    
    
ruleset=[ruleset rule_original]



acyclic_event2=[];
cyclic_event2=[];
acyclic_time2=[];
cyclic_time2=[];

for sample_initialization = 1:1:20    
    


%TYPE AND SIZE DEFINITION
A = randi([1 total_states],1,size);
A = repmat ( A, time, 1);

%%

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


acyclic_event1=0;
cyclic_event1=0;
acyclic_time1=1;
cyclic_time1=1;

for(t= 1:time-1),

%
    for(i=2:size-1)
       
        %%FOR ACYCLIC
        if( graph(A(t,i),A(t,i-1)) ~= 0  ) ,
                A(t+1,i) = final(A(t,i) ,A(t,i-1));
                acyclic_event1=acyclic_event1 + 1;
                acyclic_time1=t;
                %stat(big).acyclic(sample_initialization).event=stat(big).acyclic(sample_initialization).event+1;
                %stat(big).acyclic(sample_initialization).time=t;
                
        elseif( graph(A(t,i),A(t,i+1)) ~= 0 )
                A(t+1,i) = final(A(t,i) ,A(t,i+1));
                acyclic_event1=acyclic_event1 + 1;
                acyclic_time1=t;
                %stat(big).acyclic(sample_initialization).event=stat(big).acyclic(sample_initialization).event+1;
                %stat(big).acyclic(sample_initialization).time=t;
                
        else
                A(t+1,i) = A(t,i);

        end
        
        
        %FOR CYCLIC   
           if(   cycle_graph(B(t,i),B(t,i-1)) ~= 0  ) ,
                B(t+1,i) = cycle_final(B(t,i) ,B(t,i-1));
                cyclic_event1=cyclic_event1 + 1;
                cyclic_time1=t;
                %stat(big).cyclic(sample_initialization).event=stat(big).cyclic(sample_initialization).event+1;
                %stat(big).cyclic(sample_initialization).time=t;
                
           elseif( cycle_graph(B(t,i),B(t,i+1)) ~= 0 ) 
                B(t+1,i) = cycle_final(B(t,i) ,B(t,i+1));
                cyclic_event1=cyclic_event1 + 1;
                cyclic_time1=t;
                %stat(big).cyclic(sample_initialization).event=stat(big).cyclic(sample_initialization).event+1;
                %stat(big).cyclic(sample_initialization).time=t;
           else
                B(t+1,i) = B(t,i);

           end
        

        
    end
end

acyclic_event2=[acyclic_event2 acyclic_event1];
cyclic_event2=[cyclic_event2 cyclic_event1];
acyclic_time2=[acyclic_time2 acyclic_time1];
cyclic_time2=[cyclic_time2 cyclic_time1];
end




acyclic_event3=[acyclic_event3 ;acyclic_event2];
cyclic_event3=[cyclic_event3 ;cyclic_event2];
acyclic_time3=[acyclic_time3 ;acyclic_time2];
cyclic_time3=[cyclic_time3 ;cyclic_time2];
end
end
    
