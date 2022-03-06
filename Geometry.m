function pathdata = Geometry(idx)

path1 = @(s) [-15, 60-s];   %N2S
path2 = @(s) [15, s-60];    %S2N
path3 = @(s) [s-60, -15];   %W2E
path4 = @(s) [60-s, 15];    %E2W

path5 = @(s) pathR(s,1);    %N2W
path6 = @(s) pathR(s,2);    %S2E
path7 = @(s) pathR(s,3);    %W2S
path8 = @(s) pathR(s,4);    %E2N

path9  = @(s) pathL(s,1);    %N2E
path10 = @(s) pathL(s,2);    %S2W
path11 = @(s) pathL(s,3);    %W2N
path12 = @(s) pathL(s,4);    %E2S

paths = {path1;path2;path3;path4;path5;path6;path7;path8;path9;path10;path11;path12};

pathdata.path = paths{idx};
end


function P = pathR(s,idx)
    R = 5;
    cx = [-30,30,-30,30];
    cy = [30,-30,-30,30];
    
    x1 = [-25, 25, s-60, 60-s];
    y1 = [60-s, s-60, -25, 25];
    
    theta = (s-30)/R;
    x2 = R*[cos(theta), -cos(theta), sin(theta), -sin(theta)];
    y2 = R*[-sin(theta), sin(theta), cos(theta), -cos(theta)];
    
    r0 = 30+R*pi/2;
    x3 = [-30-(s-r0),30+(s-r0),-25,25];
    y3 = [25,-25,-30-(s-r0),30+(s-r0)];
    
    if s < 30
        x = x1(idx);
        y = y1(idx);
    elseif s < 30 + R*pi/2
        x = cx(idx) + x2(idx);
        y = cy(idx) + y2(idx);
    else
        x = x3(idx);
        y = y3(idx);
    end
    P = [x,y];
end

function P = pathL(s,idx)
    R = 35;
    cx = [30,-30,-30,30];
    cy = [30,-30,30,-30];
    
    x1 = [-5, 5, s-60, 60-s];
    y1 = [60-s, s-60, -5, 5];
    
    theta = (s-30)/R;
    x2 = R*[-cos(theta), cos(theta), sin(theta), -sin(theta)];
    y2 = R*[-sin(theta), sin(theta), -cos(theta), cos(theta)];
    
    r0 = 30+R*pi/2;
    x3 = [30+(s-r0),-30-(s-r0),5,-5];
    y3 = [-5,5,30+(s-r0),-30-(s-r0)];
    
    if s < 30
        x = x1(idx);
        y = y1(idx);
    elseif s < 30 + R*pi/2
        x = cx(idx) + x2(idx);
        y = cy(idx) + y2(idx);
    else
        x = x3(idx);
        y = y3(idx);
    end
    P = [x,y];
end