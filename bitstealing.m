function gray = bitstealing(img, l)

vr = 0;
vb = 0;
n = 0;
if l == 1
    vr = 0;
    vb = 1;
    n = 766;
elseif l == 2
    vr = 0;
    vb = 2;
    n = 1274;
elseif l == 3
    vr = 1;
    vb = 1;
    n = 2294;
elseif l == 4
    vr = 1;
    vb = 2;
    n = 3816;
end

variations = zeros([(2*vr+1) * (2*vb+1), 3]);
k = 1;
for x = -vr:vr
    for z = -vb:vb
        variations(k, :) = [x 0 z];
        k = k + 1;
    end
end

lower_limit = vb;
upper_limit = 255 - vb;
c = 1;
lut = zeros([256 * length(variations), 3]);
for i = 0:255
    
    for v = 1:length(variations)
       
        edited = [i i i] + variations(v, :);
        
        if i < lower_limit
            edited(edited < 0) = 0;
        elseif i > upper_limit
            edited(edited > 255) = 255;
        end
        
        lut(c, :) = edited;
        c = c + 1;
        
    end
    
end

lut = unique(round(lut), 'rows');
lum = sum(lut .* [0.2989 0.587 0.114], 2);
[~, i] = sort(lum);
lut = lut(i, :);

img = single(img);
lum_img = img(:, :, 1) .* 0.2989 + img(:, :, 2) .* 0.587 + img(:, :, 3) .* 0.114;
lum_img = round((lum_img / 255) * (n - 1)) + 1;
gray = uint8(reshape(lut(lum_img, :), size(img)));
