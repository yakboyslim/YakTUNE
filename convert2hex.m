function dsc=convert2hex(value)
    if value<=127-33
        dsc = strcat("",dec2hex(value+33));
    elseif value<=191-33
        dsc = strcat("C2 ",dec2hex(value+33));
    else
        dsc = strcat("C3 ",dec2hex(value+33-64));
    end
