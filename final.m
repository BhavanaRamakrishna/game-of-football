clear all;
close all;
clc;
%reading the video
video = VideoReader('Red_Ball.mp4');
%defining 100 frames to obtain from the video, maximum =
%video.NumberOfFrames
frames = 100;
for iFrame=1:frames
    %get frame
    frame = read(video, iFrame);
    %get an image with the ball detected and marked
    detected_image = identify_ball(frame);
    %create destination to store these updated image frames
    filename = [sprintf('%03d',iFrame) '.jpg'];
    folder = 'file:///Users/bhavanarama/Desktop/Notes%20and%20Texts/Sem%202/Computer%20Vision/Final%20Project';
    %store the image 
    imwrite(detected_image,fullfile(filename), 'jpg');
end

%obtain all the stored image frames
frame_names = dir(fullfile('*.jpg'));
frame_names = {frame_names.name}';
%create a video using those images
outputVideo = VideoWriter('video_out','Uncompressed AVI');
%defining framerate for the video obtained from original video
outputVideo.FrameRate = video.FrameRate;
open(outputVideo);
for ii = 1:length(frame_names)
    %display figure(visibility is Off, so the user does not see it) having
    %the image frames and catch that into a frame which can be easily added
    %to a video without having to resize it, original images size will
    %differ inorder to make a video out of them
    image = imread(fullfile(frame_names{ii}));
    close all;
    figure('visible', 'off'),imshow(image);
    axis tight;
    %capture frame from figure
    captured_frame = getframe(gcf);
    %write the frame into the video
    writeVideo(outputVideo,captured_frame);
end
close(outputVideo);

%retrieve the stored movie and play
display_video = VideoReader('video_out.avi');
i = 1;
while hasFrame(display_video)
   mov(i) = im2frame(readFrame(display_video));
   i = i+1;
end
figure,imshow(mov(1).cdata, 'Border', 'tight'),title('Ball detected');
movie(mov,1,display_video.FrameRate);