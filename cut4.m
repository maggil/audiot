function [qarr]=cut4(in_array)

%Parse through array.
indices = find(in_array == 4);
if(numel(indices) == 0)
    qarr = [];
else
    qarr = in_array(indices(1)+1:indices(2)-1);
end