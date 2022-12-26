function tunes
close all

%% Read TuneCSV
[fileopen,pathopen]=uigetfile('*.csv','Select Tune CSV File')
settings=readtable(fullfile(pathopen,fileopen))

%% Read AccelDat
accelset=fileread(fullfile(getcurrentdir,"accel.dat"),Encoding='ISO-8859-1');
accelset=string(dec2hex(double(accelset)));
accelstr = "";
for n = 1:length(accelset(:,1))
    accelstr = strcat(accelstr," ",accelset(n));
end

%% Read TravelDat
travelset=fileread(fullfile(getcurrentdir,"travel.dat"),Encoding='ISO-8859-1');
travelset=string(dec2hex(double(travelset)));
travelstr = "";
for n = 1:length(travelset(:,1))
    travelstr = strcat(travelstr," ",travelset(n));
end

%% Read SteerDat
steerset=fileread(fullfile(getcurrentdir,"steer.dat"),Encoding='ISO-8859-1');
steerset=string(dec2hex(double(steerset)));
steerstr = "";
for n = 1:length(steerset(:,1))
    steerstr = strcat(steerstr," ",steerset(n));
end


final="EF 39";

for n=1:2:5
    %% Parse settings per mode

    setComfort=settings.Comfort(n:n+1);
    setZeroG=settings.ZeroG(n:n+1);
    setMaxG=settings.MaxG(n:n+1);
    setDamper=settings([n:n+1],["FastCompression","MedCompression","SlowCompression","SlowRebound","MedRebound","FastRebound"] );
  
    sens=settings.ComfortSensitivity(n);
    glimitthreshold=settings.GLimitThreshold(n);
    speedfactor=settings.SpeedFactor(n);
    gratemax=settings.ComfortGRateMax(n);
    curbfactor=settings.CurbFactor(n);
    mode=string(settings.Mode(n));
    brakedecay=settings.BrakeDecay(n);
    brakethreshold=settings.BrakeThreshold(n);
    brakeminspeed=settings.BrakeMinSpeed(n);


    %% Transform from prct to current
    [defaultrate, fcenter, fmaxuse, rcenter, rmaxuse, fmincurr, fmaxcurr, rmincurr, rmaxcurr, damper] = adjustit(setComfort,setZeroG,setMaxG,setDamper)

%     defaultrate=15;  
%     fcenter=.20;
%     fmaxuse=0.9;
%     rcenter=.20;
%     rmaxuse=0.8;
%     fmincurr=600
%     fmaxcurr=1600
%     rmincurr=600
%     rmaxcurr=2000
%      accelstr=fileread("accel1.dat");    
%      travelstr=fileread("travel1.dat");
%      steerstr=fileread("steer1.dat");
    
    %% Make Tables
    gtablestr=gtablemaker(fcenter,fmaxuse,rcenter,rmaxuse,defaultrate,sens,gratemax,curbfactor,mode(1));
    brakestr=brakemaker(fmaxuse,rmaxuse,brakedecay,brakethreshold,brakeminspeed);
    speedstr=speedmaker(fmaxuse,rmaxuse,glimitthreshold,speedfactor);
    calstr=calmaker(fmincurr,fmaxcurr,rmincurr,rmaxcurr);
    velstr=velmaker(damper);
    
    %% Combine Tables into one file
    if n<5,
        final=strcat(final,gtablestr," 0A ",brakestr," 0A ",accelstr," 0A ",speedstr," 0A ", ...
            steerstr," 0A ",calstr," 20 0A ",velstr," 0A ",travelstr," 0A ");
    else
        final=strcat(final,gtablestr," 0A ",brakestr," 0A ",accelstr," 0A ",speedstr," 0A ", ...
            steerstr," 0A ",calstr," 20 0A ",velstr," 0A ",travelstr);
    end
end


%% Convert file from hex to text
final = strcat(strrep(final,' ',''));
a = convertStringsToChars(final);
a = reshape(a,2,[]);
for n=1:length(a)
    d(n)=hex2dec(strcat(a(1,n),a(2,n)));
end
idx = strcmp(d,13);
d(idx) = [];
c=char(d);

%% Write to pdts
filename=strrep(fileopen,'.csv','.pdts');
[filenew,pathsave]=uiputfile({'*.pdts','DSC Tune Files .pdts'},'Save Tune',fullfile(pathopen,filename))
fid = fopen(fullfile(pathsave,filenew),'wt+','n','ISO-8859-1');
fwrite(fid,c);

%% Display Track Damper settings in case of corrupt table
msg{1}='Damper Settings Track Front';
msg{2}=sprintf('%4.1f | ',damper(1,:));
msg{3}='Damper Settings Track Rear';
msg{4}=sprintf('%4.1f | ',damper(2,:));
msg{5}='Click Once Complete'

% msgbox(msg,"Confirmation","warn");
button = questdlg(msg, 'Confirmation', 'Close','Close');
if strcmpi(button, 'Close')
  return; % Or break or continue
end
fclose('all');