function [ M ] = to_matrix( p )
%to_matrix form 3X3 matrix from 1X9 array
    M = [p(1) p(2) p(3);
        p(4) p(5) p(6);
        p(7) p(8) p(9)];

end

