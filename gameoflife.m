%Game of Life awesome implementation

%Random Initialization of the matrix
m = randi(2, 50) - 1;


i=1;
for i=1:200      %number of times the game of life is run
    spy(m);
    title('Game of Life simulation with Random Initialization')
    xlabel('Cell Position') % x-axis label
    ylabel('Cell Position') % y-axis label
   drawnow;
   neighbours = conv2(m, [1 1 1; 1 0 1; 1 1 1], 'same');
   m = double((m & neighbours == 2) | neighbours == 3);
   M(i) = getframe(gcf)
end

