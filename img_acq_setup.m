function vid = img_acq_setup()
    vid = videoinput('winvideo');
    triggerconfig(vid,'manual');
    vid.ReturnedColorSpace = 'RGB';
end