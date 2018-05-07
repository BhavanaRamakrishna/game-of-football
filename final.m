clear all;
close all;
clc;
%reading the video
video = VideoReader('bounce_bkg.mp4');
%defining 100 frames to obtain from the video, maximum =
%video.NumberOfFrames;
frames = 100;
folder = 'frames';
goal_folder = 'goal';
delete([folder filesep '*.jpg']);
delete([goal_folder filesep '*.jpg']);
textPos = [200 400];
box_color = {'yellow'};
for iFrame=1:frames
    %get frame
    %try-catch block in case there are fewer than 100 frames
    try
        frame = read(video, iFrame);
    catch ME
        break
    end
    if iFrame == 1
        pos = identify_goal(frame);
    end
    %get an image with the ball detected and marked
    [detected_image,count] = identify_ball(frame,pos);
    img = detected_image;
    if count == 1
        filename = [sprintf('%03d',iFrame) '.jpg']; 
        img = insertText(detected_image,textPos,'Goal!!','FontSize',50,'BoxColor',box_color,'BoxOpacity',0.6,'TextColor','black');
        imwrite(img,fullfile([goal_folder filesep filename]), 'jpg');
    end
    %create destination to store these updated image frames
    filename = [folder filesep sprintf('%03d',iFrame) '.jpg'];
    %store the image 
    imwrite(img,fullfile(filename), 'jpg');
end

%obtain all the stored image frames
frame_names = dir(fullfile([folder filesep '*.jpg']));
frame_names = {frame_names.name}';
%create a video using those images
outputVideo = VideoWriter('video_out','Motion JPEG AVI');
%defining framerate for the video obtained from original video
outputVideo.FrameRate = video.FrameRate;
open(outputVideo);
for ii = 1:length(frame_names)
    %display figure(visibility is Off, so the user does not see it) having
    %the image frames and catch that into a frame which can be easily added
    %to a video without having to resize it, original images size will
    %differ inorder to make a video out of them
    image = imread(fullfile([folder filesep frame_names{ii}]));
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