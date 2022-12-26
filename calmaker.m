function [calstr] = calmaker(fmincurr,fmaxcurr,rmincurr,rmaxcurr)
% 
% fmincurr=600
% fmaxcurr=1600
% rmincurr=600
% rmaxcurr=2000

finc=(fmaxcurr-fmincurr)/32;
rinc=(rmaxcurr-rmincurr)/32;

cal=[fmincurr:finc:fmaxcurr;fmincurr:finc:fmaxcurr;rmincurr:rinc:rmaxcurr;rmincurr:rinc:rmaxcurr];
calout=round(cal);

for n = 1:length(calout)
    for j = 1:4
        caldig(j,n)=convert2digit(calout(j,n));
    end
end


calstring = "";
for j = 1:4
    for n = 1:length(caldig)
        calstring = strcat(calstring," 20",caldig(j,n));
    end
end

calstr=eraseBetween(calstring,1,3);

end