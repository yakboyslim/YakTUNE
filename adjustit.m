function [defaultrate, fcenter, fmaxuse, rcenter, rmaxuse, fmincurr, fmaxcurr, rmincurr, rmaxcurr, damper] = adjustit(setComfort,setZeroG,setMaxG,setDamper)

settings=readtable(fullfile(getcurrentdir,"Tune Settings.csv"))

shockLow=settings.ShockLow(1)
shockHigh=settings.ShockHigh(1)


% settings=readtable("settings.csv")
% n=1
%     setComfort=settings.ComfortCurrent(n:n+1);
%     setZeroG=settings.ZeroGCurrent(n:n+1);
%     setMaxG=settings.MaxGCurrent(n:n+1);
% %     setrComfort=settings.ComfortCurrent(n+1);
% %     setrZeroG=settings.ZeroGCurrent(n+1);
% %     setrMaxG=settings.MaxGCurrent(n+1);
%     setDamper=settings([n:n+1],["FastCompression","MedCompression","SlowCompression","SlowRebound","MedRebound","FastRebound"] )
%      

%% Convert Damper set prct to curr

dampercurr=table2array(setDamper)*(shockHigh-shockLow)/100;

%% Calculate and apply offset to even rebound and compression sides of zero
offset = (setDamper.SlowRebound+setDamper.SlowCompression)/2;
dampercurr=dampercurr+offset;
setComfort=setComfort*(shockHigh-shockLow)/100+shockLow+offset;
setZeroG=setZeroG*(shockHigh-shockLow)/100+shockLow+offset;
setMaxG=setMaxG*(shockHigh-shockLow)/100+shockLow+offset;

%% Calculate currents
if shockHigh>shockLow
    minvel=min(dampercurr,[],2);
    maxvel=max(dampercurr,[],2);
    
    mincurr=setComfort+minvel;
    maxcurr=setMaxG+maxvel;
    mincurr(mincurr<shockLow)=shockLow;
    maxcurr(maxcurr>shockHigh)=shockHigh;
    fmaxcurr=maxcurr(1);
    rmaxcurr=maxcurr(2);
    
    slope=(maxcurr-mincurr)/100;
    comfort=round(2*(setComfort-mincurr)./slope)/2;
    comfort(1:2)=max(comfort);
    comfort(comfort<1)=1;
    comfort(comfort>15)=15;
    defaultrate=comfort(1);
    slope=(maxcurr-setComfort)./(100-comfort);
    mincurr=maxcurr-100*slope;
    mincurr(mincurr<shockLow)=shockLow;
    fmincurr=mincurr(1);
    rmincurr=mincurr(2);
    center=round(2*(setZeroG-mincurr)./slope)/2;
    fcenter=center(1)/100;
    rcenter=center(2)/100;
    maxuse=round(2*(setMaxG-mincurr)./slope)/2;
    fmaxuse=maxuse(1)/100;
    rmaxuse=maxuse(2)/100;
    damper=round(dampercurr./slope,1);

else
    minvel=max(dampercurr,[],2);
    maxvel=min(dampercurr,[],2);
    
    mincurr=setComfort+minvel;
    maxcurr=setMaxG+maxvel;
    mincurr(mincurr>shockLow)=shockLow;
    maxcurr(maxcurr<shockHigh)=shockHigh;
    fmaxcurr=maxcurr(1);
    rmaxcurr=maxcurr(2);
    
    slope=(maxcurr-mincurr)/100;
    comfort=round(2*(setComfort-mincurr)./slope)/2;
    comfort(1:2)=max(comfort);
    comfort(comfort<1)=1;
    comfort(comfort>15)=15;
    defaultrate=comfort(1);
    slope=(maxcurr-setComfort)./(100-comfort);
    mincurr=maxcurr-100*slope;
    mincurr(mincurr>shockLow)=shockLow;
    fmincurr=mincurr(1);
    rmincurr=mincurr(2);
    center=round(2*(setZeroG-mincurr)./slope)/2;
    fcenter=center(1)/100;
    rcenter=center(2)/100;
    maxuse=round(2*(setMaxG-mincurr)./slope)/2;
    fmaxuse=maxuse(1)/100;
    rmaxuse=maxuse(2)/100;
    damper=round(dampercurr./slope,1);
end