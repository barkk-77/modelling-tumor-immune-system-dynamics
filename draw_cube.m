function cube = draw_cube(center, side_length, color, alpha)
%center - [x, y, z]
%color - RGB color (e.g., [1 0 0] for red) or color name ('red')
%alpha -Transparency (0=transparent, 1=opaque)

orig_vertices = [
    -1 -1 -1; 
     1 -1 -1; 
     1  1 -1; 
    -1  1 -1; 
    -1 -1  1; 
     1 -1  1; 
     1  1  1; 
    -1  1  1
];
vertices = orig_vertices * (side_length / 2) + center;

faces = [
    1 2 3 4;   
    5 6 7 8;   
    1 2 6 5;   
    2 3 7 6;   
    3 4 8 7;   
    4 1 5 8;   
];

cube = patch('Vertices', vertices, 'Faces', faces, 'FaceColor', color, 'FaceAlpha', alpha, 'EdgeColor', 'k');
end