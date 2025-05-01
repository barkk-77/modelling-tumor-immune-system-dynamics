function hCube = grow_cubes(origin,num_cubes,color)
length = 1;
alpha= 0.9;

hCube=[];
if num_cubes == 0
    return; % Exit early without drawing anything
end

directions = [
    1 0 0;
   -1 0 0;
    0 1 0;
   0 -1 0;
    0 0 1;
   0 0 -1
 ];

% Dictionary to keep log of cube centers
occupied = dictionary();

% Function to generate key from  center coordinates
key_gen = @(c) sprintf('%d_%d_%d', c(1),c(2),c(3));

% Initialisation
hCube = draw_cube(origin,length,color,alpha);
occupied(key_gen(origin))= true;

queue = origin; % Queue of centers to run 6 face check on
drawn = 1;
queue_index = 1; 

while drawn<num_cubes
    centre=queue(queue_index,:);
    queue_index=queue_index+1; %update queue_index in anticipation of next run

    for i = 1:6
        adjacent = centre + directions(i,:); %Shift from centre of focus in direction chosen
        adjacent_key = key_gen(adjacent);

        if ~isKey(occupied,adjacent_key)
            draw_cube(adjacent*length,length,color,alpha);
            queue =[queue; adjacent];
            drawn=drawn+1;

            if drawn> num_cubes
                break;
            end
        end
    end
end

end