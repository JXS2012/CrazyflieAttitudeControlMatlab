function plot_rotation( R, label, color )
%plot_rotation plot rotation matrix R

plot3([0 R(1,1) nan 0 R(1,2) nan 0 R(1,3)],...
    [0 R(2,1) nan 0 R(2,2) nan 0 R(2,3)],...
    [0 R(3,1) nan 0 R(3,2) nan 0 R(3,3)],color);
hold on
text([R(1,1) R(1,2) R(1,3)], ...
    [R(2,1) R(2,2) R(2,3)],...
    [R(3,1) R(3,2) R(3,3)],...
    label);


end

