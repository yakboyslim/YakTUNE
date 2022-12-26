function dsc=convert2digit(value)
    value = dec2base(value,10) - '0';
    value=string(value+30);
    dsc="";
    for k = 1:length(value)
        dsc=strcat(dsc," ",value(k));
    end
end