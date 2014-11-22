function h = hilbtsym(data_y)
%
%    h = hilbtsym(data_y):
%
%    Function to calculate an instantaneus frequency of data_y(n),
%    where n specifies the length of time series for a given IMF component.
%    The function generates symmetrical waves from the data (based 
%    on zero-crossings), applies the hilbert transform to the waves, 
%    and then forms a new data cropping the artificial waves. 
%
%    Input-
%	data_y	- vector data_y(n) for a given IMF component
%    Output-
%	h	- vector h(n) that represents the instataneous frequency
%
%    J. Marshak (NASA GSFC)	Jan.14, 2004 Edited
%
%    Temporary remarks -
%    the naming is very confusing since the function returns the
%    instantaneus frequency. Other hilbert-named functions return
%    a hilbert transform.
%    Check if I can make the function return the transform correctly.

%----- Initialize
first_time = 0;
n_mx = -1; n_mn = -1;
    h=[];
    y=[];
    orient=0;
first = 1;
num_copies = 0;

%----- Process each element of a data_y
while length(data_y) > 1
    zz = [];
    second = 0;
 
    %----- Check the value of the first element
    if(data_y(1) == 0)
        if(data_y(2) > 0)
            orient = 1;
        else
            orient = -1;
        end
    elseif(data_y(1) > 0)
        orient = 1;
    elseif(data_y(1) < 0)
        orient = -1;
    end
    
    %----- Find the index of zero-crossing
    for i=1:length(data_y)-1
        if(data_y(i)*orient > 0)
            second = i;
        elseif(data_y(i)*orient == 0) & (i == 1)
            second = i;
        else
            break;
        end        
    end

    
    %----- Get the values between crossings
    zz=data_y(1:second); %get all y values between min and max extrema

    %----- Prepare the waves
    mm=length(zz); %length of zz
    zz1 = zz*-1;    

    if(zz1(1) == 0)
        zz1 = zz1(2:end);
    end
    if(zz1(end) == 0)
        zz1 = zz1(1:end-1);
    end
    
    x1 = [];
    iaa = 51;
    x1_len = (length(zz)+length(zz1))*25+1;
    for jj=1:iaa,
        x1=[x1,zz(1:end),zz1(1:end)];  % copy the wave
    end

%----- Apply the hilbert transform to the waves
    htemp = hilbert(x1(1:end-1));

%    comment temporary next 2 lines to return HT not frequency JM
     htemp = diff(unwrap(angle(htemp)));   
     htemp = [htemp, htemp(end)];
    
%----- Form the output dataset h and shift the input
    if(mm > 1)
        h = [h, htemp(x1_len:x1_len+mm-2), htemp(x1_len+mm-2)];
        data_y = data_y(mm+1:end);
    else
        h = [h, htemp(1)];
        data_y = data_y(2:end);
    end
    


end    
 
h = [h, h(end)];

%----- Plot the original and improved frequency
% x = 1:length(data_y);
% d = diff(unwrap(angle(hilbert(data_y))));
% d = [d, d(end)];
% plot(x, d, x, h);