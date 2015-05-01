function [ H ] = find_H( E,e,a,d,ddot )
%FIND_H solve H matrix
    A = zeros(9,9);
    while rank(A) < 9
        for i = 1:9
            A(i,:) = rand(1,9);
        end
    end
    M = zeros(9,3,3);
    for i = 1:9
        M(i,:,:) = to_matrix(A(i,:));
    end
    
    n = zeros(9,3);
    for i = 1:9
        tempM = squeeze(M(i,:,:));
        n(i,:) = get_non_gradient_control(E,e,a,d,ddot,tempM);
    end
    
    H = A\n;
    
    p4 = rand(1,9);
    M4 = to_matrix(p4);
    n4 = get_non_gradient_control(E,e,a,d,ddot,M4)';
    
    if norm(n4 - p4*H)>0.1
        H
        A(1,:)
        squeeze(M(1,:,:))
        n(1,:)
        E
        e
        a
        d
        ddot
        norm(n4 - p4*H)
        error('mis identified H');
    end
    
    H = H';
end

