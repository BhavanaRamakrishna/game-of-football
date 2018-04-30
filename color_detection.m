clear all;
close all;
clc;
%reading the video
vid = VideoReader('videoplayback.mp4');

%mov = read(vid);
%implay(mov)

vidHeight = vid.Height;
vidWidth = vid.Width;

%for iFrame=1:20

%obtain vid.NumberOfFrames of frames from the video
for iFrame=1:vid.NumberOfFrames
    b = read(vid, iFrame);
    %b_gray = rgb2gray(b);
    
    %get the color detected image
    detected_image = getImage(b);
    
    %create destination to store these updated image frames
    filename = [sprintf('%03d',iFrame) '.jpg'];
    folder = 'file:///Users/bhavanarama/Desktop/Notes%20and%20Texts/Sem%202/Computer%20Vision/Final%20Project';
    new = 'images';
    %fullname = fullfile(new,'images',filename);
    %imwrite(b_gray,fullname);
    if ~exist(new,'dir')
        mkdir(new);
    end
    imwrite(detected_image,fullfile(filename), 'jpg');
    %imwrite(b_gray,'file:///Users/bhavanarama/Desktop/Notes%20and%20Texts/Sem%202/Computer%20Vision/Final%20Project/newimage.jpg','jpg');
end


%obtain all the stored image frames
imageNames = dir(fullfile('*.jpg'));
imageNames = {imageNames.name}';
%create a video using those images
outputVideo = VideoWriter('video_out','Uncompressed AVI');
%defining framerate for the video
outputVideo.FrameRate = vid.FrameRate;
open(outputVideo);
for ii = 1:length(imageNames)
    %display figure(visibility is Off, so the user does not see it) having
    %the image frames and catch that into a frame which can be easily added
    %to a video without having to resize it, original images size will
    %differ inorder to make a video out of them
    close all
    figure('visible', 'off');
    img = imread(fullfile(imageNames{ii}));
    imshow(img);
    axis tight
    h = getframe(gcf);
    %write the frame into the video
    writeVideo(outputVideo,h);
end
close(outputVideo);

%retrieve the stored movie and play
shuttleAvi = VideoReader('video_out.avi');
ii = 1;
while hasFrame(shuttleAvi)
   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end
figure
imshow(mov(1).cdata, 'Border', 'tight');
movie(mov,1,shuttleAvi.FrameRate);



function new_image = getImage(b)
    %get all the red, green and blue components of the image
    red = b(:,:,1);
    green = b(:,:,2);
    blue = b(:,:,3);
    new_image = b;
    m = 1;
    %scan all pixels to get the first pixel with required color
    for i=1:size(red,1)
        for j=1:size(red,2)
            if ( (100<red(i,j)) &&(red(i,j)<=255) && (10<green(i,j)) &&(green(i,j)<100) && (10<blue(i,j)) &&(blue(i,j)<100) && (m==1))
                new_image = insertShape(new_image,'circle',[j i 5],'LineWidth',2);
                m = 0;
            end
        end
    end
    
end