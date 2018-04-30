clear all;
close all;
clc;
vid = videoinput('macvideo');
set(vid,'FramesPerTrigger',Inf);
set(vid,'ReturnedColorspace','rgb');
vid.FrameGrabInterval=5;
start(vid);
while(vid.FramesAcquired <= 100)
    data = getsnapshot(vid);
    %imgae processing code goes here getdetectedimage(data)
    new_image = insertShape(data,'circle',[100 100 5],'LineWidth',2);
    imshow(new_image);
end
stop(vid);
flushdata(vid);
clear all;