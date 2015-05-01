function [ D ] = create_rotation_matrix( theta, u )
%create_rotation_matrix create desired rotation matrix by rotating theta angle u
%along u
    D = cos(theta)*eye(3) + sin(theta)*toskew(u) + (1-cos(theta))*tensor_prod(u);

end

