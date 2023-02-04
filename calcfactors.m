function calcfactors

latg=1
K=[195,250]
Sway=[362,880]
w=3331
wheelbase=103.5
Track=[60.6,59.7]
dist=[0.618,1-0.618]
springmotion=[0.973,0.642]
dampermotion=[0.973,0.85]
swaymotion=[0.973,0.453]
Kw=K.*springmotion.^2
Swayw=2*Sway.*swaymotion.^2
natf=3.13*(Kw./(w*dist/2)).^0.5
rc=[2,7.75]
rcC=dist(1)*rc(1)+dist(2)*rc(2)
cgZ=23.5
Trollcouple=latg*w*(cgZ-rcC)
Kroll=2*[Kw+Swayw]
KTroll=sum(Kroll,"all")
rollcouple=Trollcouple*Kroll./KTroll
weighttrans=(rollcouple+latg*w.*dist.*rc)./Track
wroll=[w/2*dist+weighttrans]
natroll=[3.13*((Kroll)./wroll).^0.5]

base=[24,30]
base=30+base.*(0.7)
natrat=natroll./natf
max=(base.*natrat)
max=(max-40)./0.7 


i=1
end
