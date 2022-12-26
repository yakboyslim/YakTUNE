function velstr=velmaker(damper)

%  damper = [1.2000 1.2000 2.3000 -2.3000 -10.4000 1.2000;1.7000 -4.1000 -4.1000 4.1000 14.9000 1.7000]

zerospeed=[0;0];
damper= [damper(:,1:3) zerospeed damper(:,4:end)];
damperout=(damper*10)+1000;

%% Convert velocity information to hex

for n = 1:length(damperout(1,:))
    damperhex(1,n)=convert2digit(damperout(1,n));
    damperhex(2,n)=convert2digit(damperout(1,n));
    damperhex(3,n)=convert2digit(damperout(2,n));
    damperhex(4,n)=convert2digit(damperout(2,n));
end

%% Get pre/post amble

preamble="31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30";
postamble="31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30";
% flaunchstr="31 30 30 30 20 31 30 30 30 20 31 31 30 30 20 31 30 30 30 20 32 30 30 30 20 31 35 30 30 20 31 32 35 30";
% rlaunchstr="31 32 35 30 20 31 35 30 30 20 32 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30 20 31 30 30 30";

%% Get Launch portions

flaunchset=fileread(fullfile(getcurrentdir,"launchdamper_front.dat"),Encoding='ISO-8859-1');
flaunchset=string(dec2hex(double(flaunchset)));
flaunchstr = "";
for n = 1:length(flaunchset(:,1))
    flaunchstr = strcat(flaunchstr," ",flaunchset(n));
end
rlaunchset=fileread(fullfile(getcurrentdir,"launchdamper_rear.dat"),Encoding='ISO-8859-1');
rlaunchset=string(dec2hex(double(rlaunchset)));
rlaunchstr = "";
for n = 1:length(rlaunchset(:,1))
    rlaunchstr = strcat(rlaunchstr," ",rlaunchset(n));
end


%% Combine into one string

velstr=strcat(preamble);
for n = 1:length(damperhex(1,:))
    velstr=strcat(velstr," 20",damperhex(1,n));
end

velstr=strcat(velstr," 20 ",flaunchstr," 20 ",postamble," 20 ",preamble);
for n = 1:length(damperhex(2,:))
    velstr=strcat(velstr," 20",damperhex(2,n));
end
velstr=strcat(velstr," 20 ",flaunchstr," 20 ",postamble," 20 ",preamble);
for n = 1:length(damperhex(3,:))
    velstr=strcat(velstr," 20",damperhex(3,n));
end
velstr=strcat(velstr," 20 ",rlaunchstr," 20 ",postamble," 20 ",preamble);
for n = 1:length(damperhex(4,:))
    velstr=strcat(velstr," 20",damperhex(4,n));
end
velstr=strcat(velstr," 20 ",rlaunchstr," 20 ",postamble," 20");