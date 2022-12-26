function [speedstr] = speedmaker(fmaxuse,rmaxuse,glimitthreshold,speedfactor)

% fmaxuse=0.9
% rmaxuse=0.95
% glimitthreshold=0.25
% speedfactor=40

finc=speedfactor*fmaxuse/9;
rinc=speedfactor*rmaxuse/9;

speed=[0:finc:fmaxuse*speedfactor;0:finc:fmaxuse*speedfactor;0:rinc:rmaxuse*speedfactor;0:rinc:rmaxuse*speedfactor];
speedout=round(speed.*2);

for n = 1:length(speedout)
    for j = 1:4
        speedhex(j,n)=convert2hex(speedout(j,n));
    end
end

glimhex=convert2hex(round(100*glimitthreshold));

speedstring = "";
for n = 1:length(speedhex)
    for j = 1:4
        speedstring = strcat(speedstring," ",speedhex(j,n));
    end
end

speedstr=strcat(speedstring," ",glimhex," ",glimhex," ",glimhex," ",glimhex);

end