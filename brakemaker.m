function [brakestr] = brakemaker(fmaxuse,rmaxuse,brakedecay,brakethreshold,brakeminspeed)

% brakedecay=1500;
% brakepressure=35;
% brakeminspeed=5;

finc=100*fmaxuse/9;
rinc=100*rmaxuse/9;

brake=[0:finc:fmaxuse*100;0:finc:fmaxuse*100;0:rinc:rmaxuse*100;0:rinc:rmaxuse*100];
brakeout=round(brake.*2);

for n = 1:length(brakeout)
    for j = 1:4
        brakehex(j,n)=convert2hex(brakeout(j,n));
    end
end

decaydig=convert2digit(brakedecay);
pressuredig=convert2digit(brakethreshold);
speeddig=convert2digit(brakeminspeed);

brakestring = "";
for n = 1:length(brakehex)
    for j = 1:4
        brakestring = strcat(brakestring," ",brakehex(j,n));
    end
end

brakestr=strcat(brakestring," 20",decaydig," 20",pressuredig," 20",speeddig);

end