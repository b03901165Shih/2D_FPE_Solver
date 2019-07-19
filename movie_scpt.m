
% Movie script ...
% Parameters:
skip_frame = 2*4;
from_top = true;
writeVids = false;
equal_axis = true;

figure('units','pixels','position',[0 0 1280 720]), set(gcf, 'Color','white')
surf(x2,x1,p(:,:,1),'edgecolor','none');  axis([x1(1) x1(end) x2(1) x2(end) -0.05 0.2])
set(gca, 'nextplot','replacechildren', 'Visible','on');
if equal_axis
    axis equal;
end

if writeVids
    myVideo = VideoWriter('FPE_movie.avi');
    myVideo.FrameRate = 50;  % Default 30
    myVideo.Quality = 75;    % Default 75
    open(myVideo);
end
    
for j=2:skip_frame:length(t)
    %drawnow
    surf(x2,x1,p(:,:,j),'edgecolor','none');
    if from_top
        az = 0;
        el = 90;
        view(az, el);
    end
    if writeVids
        writeVideo(myVideo,getframe(gca));
    else
        drawnow
    end
    %pause(.1)
end

if writeVids
    close(myVideo);
end