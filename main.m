clear; close all;

%%% ToDo:
% 1) Random Travel Demand
% 2) Implement with fixed cost
% 3) Change the cost with coordination part

global val chk;
global M V d2n n2d;

%%%%%%%%%%%%%%% Graph Setting %%%%%%%%%%%%%%%

V = 9;  % vertices
E = 28; % edges
d2n = [0 5 4 2;
       0 6 1 3;
       0 7 2 0;
       1 8 0 5;
       1 8 4 6;
       2 9 5 7;
       3 9 6 0;
       5 0 4 9;
       6 0 8 7];
n2d = [0 4 0 3 2 0 0 0 0;
       3 0 4 0 0 2 0 0 0;
       0 3 0 0 0 0 2 0 0;
       1 0 0 0 4 0 0 2 0;
       1 0 0 3 0 4 0 2 0;
       0 1 0 0 3 0 4 0 2;
       0 0 1 0 0 3 0 0 2;
       0 0 0 3 1 0 0 0 4;
       0 0 0 0 0 1 4 3 0];

S = 1;  % the number of stations
s = 3;  % station node idx

%%%%%%%%%%%%%%% Travel Demand Setting %%%%%%%%%%%%%%%

M = 20; % the number of travel demands
ODT = [randi([1,V],M,2) sort(ones.*(10*rand(M,1)))];
for i =1:M
    if ODT(i,1) == ODT(i,2)
        ODT(i,2) = mod(ODT(i,2)+i,8)+1;
    end
end
O = ODT(:,1);
D = ODT(:,2);
T = ODT(:,3);

VTA = ones([M,1]); % Vehicle to Trip Assignment VTA(m) = s

%%%%%%%%%%%%%%% Routing Variables %%%%%%%%%%%%%%%

val = 2e10*ones([E,4]); % 4 direction (North/South/West/East)
chk = zeros([E,4]); % 1 if visited, otherwise 0

%%%%%%%%%%%%%%% CAV and Coordnation Variables %%%%%%%%%%%%%%%

% need to define coordination and control variables here
v0 = 0.25;  % Initial vehicle speed at the station


%%%%%%%%%%%%%%% Algorithm %%%%%%%%%%%%%%%

for m = 1:M
    % generatingfor each vehicle (or travel demand)

    src = s(VTA(m));    % source node
    tml = O(m);         % terminal node
    data = Search(src,tml,4,T(m));  % data = [Tf,vf,dirOut]

    src = d2n(O(m),data.dirOut);
    tml = D(m);
    t0 = data.tf;
    dirIn = n2d(src,O(m));
    data = Search(src,tml,dirIn,t0);

    src = d2n(D(m),data.dirOut);
    tml = s(VTA(m));
    t0 = data.tf;
    dirIn = n2d(src,D(m));
    data = Search(src,tml,dirIn,t0);

    disp(data);
end


function data = Search(src,tml,dirIn,T0)

    global val chk;
    global V d2n n2d;

    val = 2e10*ones([V,4]); % 4 direction (North/South/West/East)
    chk = zeros([V,4]); % 1 if visited, otherwise 0

    for i=1:4
        if dirIn ~= i && d2n(src,i) ~= 0
            val(src,i) = T0+2+2*rand(1); %%%% coordination here!!!!
        end
    end

    while 1
        min = 3e10;
        for i=1:V
            for j=1:4
                if val(i,j) <= min && chk(i,j) == 0
                    min = val(i,j);
                    node = i;
                    dirOut = j;
                end
            end
        end
        chk(node,dirOut) = 1;
        if node == tml
            data.tf = val(node,dirOut);
            data.vf = 0;
            data.dirOut = dirOut;
            return
        end
        nodeNew = d2n(node,dirOut);
        dirIn = n2d(nodeNew,node);
        for i=1:4
            if dirIn ~= i && d2n(nodeNew,i) ~= 0
                valNew = val(node,dirOut)+2+2*rand(1);  %%%% coordination here!!!!
                if valNew < val(nodeNew,i)
                    val(nodeNew,i) = valNew;
                end
            end
        end
    end
end
