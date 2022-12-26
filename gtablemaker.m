function gtablestring=gtablemaker(fcenter,fmaxuse,rcenter,rmaxuse,defaultrate,sens,gratemax,curbfactor,mode)

% defaultrate=15;
% sens=12;
% gratemax=1.8;
% fcenter=.20;
% fmaxuse=0.9;
% rcenter=.20;
% rmaxuse=0.8;
% curbfactor=100
% mode='Normal'
%% Inputs
curbfactor=curbfactor/100;
[glat,glng]=meshgrid(-1:0.2:1,1:-0.2:-1);

settings=readtable(fullfile(getcurrentdir,"Tune Settings.csv"))

floadfactor=settings.LoadFactor(1);
fswaybarfactor=settings.SwayBarFactor(1)*curbfactor;
frollfactor=settings.RollFactor(1)*curbfactor;
fheavefactor=settings.HeaveFactor(1);
fheavegammafactor=settings.HeaveFactorGamma(1);
frollgammafactor=settings.RollFactorGamma(1);
rloadfactor=settings.LoadFactor(2)
rswaybarfactor=settings.SwayBarFactor(2)*curbfactor;
rrollfactor=settings.RollFactor(2)*curbfactor;
rheavefactor=settings.HeaveFactor(2);
rheavegammafactor=settings.HeaveFactorGamma(2);
rrollgammafactor=settings.RollFactorGamma(2);

%% Make Map

fload=(fcenter+(floadfactor*fmaxuse-fcenter)*(sqrt(glat.^2+glng.^2))/sqrt(2));
fouter=(((((glat+1)/2).^frollgammafactor)-0.5^frollgammafactor))*frollfactor.*(1-abs(glng));
fdive=abs(((((glng+1)/2).^fheavegammafactor)-0.5^fheavegammafactor))*fheavefactor.*(1-abs(glat));
rload=(rcenter+(rloadfactor*rmaxuse-rcenter)*(sqrt(glat.^2+glng.^2))/sqrt(2));
router=(((((glat+1)/2).^rrollgammafactor)-0.5^rrollgammafactor))*rrollfactor.*(1-abs(glng));
rdive=abs(((((glng+1)/2).^rheavegammafactor)-0.5^rheavegammafactor))*rheavefactor.*(1-abs(glat));

%dive=abs(glng.^divegammafactor)*divefactor;
fswaybar=fswaybarfactor*abs(glat);
rswaybar=rswaybarfactor*abs(glat);

gtable(:,:,1)=(round(200*(fload-(fouter)+fdive-fswaybar)))/2;
% gtable(:,:,1)(gtable(:,:,1)>100*fmaxuse)=100*fmaxuse
gtable(:,:,2)=fliplr(gtable(:,:,1));
gtable(:,:,3)=(round(200*(rload+fliplr(router)+flipud(rdive)+rswaybar)))/2;
% gtable(:,:,3)(gtable(:,:,3)>100*rmaxuse)=100*rmaxuse
gtable(:,:,4)=fliplr(gtable(:,:,3));

gtable(gtable>100*max(fmaxuse,rmaxuse))=100*(max(rmaxuse,fmaxuse));

%% Plot Map
figure('Name',mode,'NumberTitle','off')
tiledlayout(2,2);
nexttile;
surf(glat,glng,gtable(:,:,1),"FaceColor",'interp');
colormap(hsv);
clim([fcenter*100 fmaxuse*100])
view(2);
nexttile;
surf(glat,glng,gtable(:,:,2),"FaceColor",'interp');
colormap(hsv);
clim([fcenter*100 fmaxuse*100])
view(2);
nexttile;
surf(glat,glng,gtable(:,:,3),"FaceColor",'interp');
colormap(hsv);
clim([rcenter*100 rmaxuse*100])
view(2);
nexttile;
surf(glat,glng,gtable(:,:,4),"FaceColor",'interp');
colormap(hsv);
view(2);
clim([rcenter*100 rmaxuse*100])


%% Convert to HEX
gtableout=gtable*2;
for n = 1:length(gtableout)
    for k = 1:length(gtableout(1,:,1))
        for j = 1:4
            gtablehex(n,k,j)=convert2hex(gtableout(n,k,j));
        end
    end
end

defaulthex=convert2hex(round(2*defaultrate));
senshex=convert2digit(sens);
% sensitivityhex=string(sensitivity)
gratemaxhex=convert2hex(round(20*gratemax));
%% Combine into one
gtablestring = "";
for k = 1:length(gtablehex(1,:,1))
    for n = 1:length(gtablehex)
        for j = 1:4
            gtablestring = strcat(gtablestring," ",gtablehex(n,k,j));
        end
    end
end
gtablestring = strcat(gtablestring," ",defaulthex," 5D ",gratemaxhex,senshex);
% %% Save File
% filename = uiputfile('*.txt','G Table Portion')
% writelines(final,filename)

%% local functions
% 
% function dsc=convert2dsc(value)
%     if value<=127
%         dsc = char(value+21);
%     elseif value<=191
%         dsc = strcat("Â",char(value+21));
%     else
%         dsc = strcat("Ã",char(value+21));
%     end
% end

