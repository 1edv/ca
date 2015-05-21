%I have 6 states from that email. Lets see what I can do with them. Hmm...
size = 101;
time = 51;

%
A = zeros(time,size);
A(1,floor(size/2) + 1)=1;

%Ruleset for the 8bit two state automaton. Rule 90 is just the binary
%representation of 90 01011010
rule = [0,1,0,1,1,0,1,0]


%Updating the automaton according to the ruleset
for(t= 1:time-4),

for(i=2:size-1)
if(A(t,i-1) == 0   &   A(t,i) ==  0    &   A(t,i+1) == 0),

  A(t+1,i) = rule(1);

end
if(A(t,i-1) ==  0   &   A(t,i) ==  0    &   A(t,i+1) == 1 ),

  A(t+1,i) = rule(2);

end
if(A(t,i-1) == 0    &   A(t,i) == 1     &   A(t,i+1) == 0),

  A(t+1,i) = rule(3);

end
if(A(t,i-1) == 0    &   A(t,i) == 1     &   A(t,i+1) == 1),

  A(t+1,i) = rule(4);

end
if(A(t,i-1) == 1    &   A(t,i) == 0     &   A(t,i+1) == 0),

  A(t+1,i) = rule(5);

end
if(A(t,i-1) ==  1   &   A(t,i) ==  0    &   A(t,i+1) == 1),

  A(t+1,i) = rule(6);

end
if(A(t,i-1) ==  1   &   A(t,i) ==   1   &   A(t,i+1) == 0),

  A(t+1,i) = rule(7);

end
if(A(t,i-1) == 1    &   A(t,i) ==    1  &   A(t,i+1) == 1),

  A(t+1,i) = rule(8);

end

end
end

%Output for a 1D automaton
spy(A)

