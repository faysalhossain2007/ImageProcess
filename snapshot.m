function img = snapshot(vid, crop, fname)
    start(vid);
    pause(2);
    img = getsnapshot(vid);
    stop(vid);
    
    if nargin == 2
        [m,n] = size(img);
        n = n/3;
        img = imcrop(img, [crop crop n-crop m-crop]);
    end
    
    if nargin == 3
        imwrite(img, fname, 'JPG');
    end
end