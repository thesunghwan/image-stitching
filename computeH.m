%im1_pts should be the center picture
%im2_pts should be the compared picture
function H = computeH(im1_pts, im2_pts)
    A = [
        -im2_pts(1, 1) -im2_pts(1, 2) -1 0 0 0 im1_pts(1, 1)*im2_pts(1, 1) im1_pts(1, 1)*im2_pts(1, 2) im1_pts(1, 1);
        0 0 0 -im2_pts(1, 1) -im2_pts(1, 2) -1 im1_pts(1, 2)*im2_pts(1, 1) im1_pts(1, 2)*im2_pts(1, 2) im1_pts(1, 2);
        -im2_pts(2, 1) -im2_pts(2, 2) -1 0 0 0 im1_pts(2, 1)*im2_pts(2, 1) im1_pts(2, 1)*im2_pts(2, 2) im1_pts(2, 1);
        0 0 0 -im2_pts(2, 1) -im2_pts(2, 2) -1 im1_pts(2, 2)*im2_pts(2, 1) im1_pts(2, 2)*im2_pts(2, 2) im1_pts(2, 2);
        -im2_pts(3, 1) -im2_pts(3, 2) -1 0 0 0 im1_pts(3, 1)*im2_pts(3, 1) im1_pts(3, 1)*im2_pts(3, 2) im1_pts(3, 1);
        0 0 0 -im2_pts(3, 1) -im2_pts(3, 2) -1 im1_pts(3, 2)*im2_pts(3, 1) im1_pts(3, 2)*im2_pts(3, 2) im1_pts(3, 2);
        -im2_pts(4, 1) -im2_pts(4, 2) -1 0 0 0 im1_pts(4, 1)*im2_pts(4, 1) im1_pts(4, 1)*im2_pts(4, 2) im1_pts(4, 1);
        0 0 0 -im2_pts(4, 1) -im2_pts(4, 2) -1 im1_pts(4, 2)*im2_pts(4, 1) im1_pts(4, 2)*im2_pts(4, 2) im1_pts(4, 2);
        
    ];

    %H = transpose(A) * A;

    [a, b] = eig(transpose(A) * A);
    h = a(:, 1);
    h = h / norm(h, 2);
    h = transpose(h);
    top = h(1:3);
    middle = h(4:6);
    bottom = h(7:9);
    
    
    H = [
        top;
        middle;
        bottom;
    ];
     
 

%ax(?x1, ?y1, ?1, 0, 0, 0, x?2*x1, x?2*y1, x?2)T (11)
%ay(0,0,0,?x1,?y1,?1,y2?*x1,y2?*y1,y2? )T .
    
end

