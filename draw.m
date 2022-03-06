figure(1)
hold on;

%draw a green background
bg = [0.7, 0.9, 0.7];
rectangle('Position', [-60,-60,120,120], 'FaceColor', bg, 'EdgeColor', bg);
rw = 10; % road width
%grey road background
grey = [40, 43, 42]/255 + 0.2;
%horizontal road
% ht = p3(1,2) - p1(1,2) + 2*rw;
rectangle('Position', [-60,-30,120,60], 'FaceColor', grey, 'EdgeColor', grey);
%vertical road
rectangle('Position', [-30,-60,60,120], 'FaceColor', grey, 'EdgeColor', grey);

%horizontal fog lines
% plot([p1(1,1), p4(1,1)-fd], p1(:,2)-fd, 'w')
% plot([p2(1,1)+fd, p1(2,1)], p1(:,2)-fd, 'w')
% 
% plot([p1(1,1), p4(1,1)-fd], p3(:,2)+fd, 'w')
% plot([p2(2,1)+fd, p1(2,1)], p3(:,2)+fd, 'w')

%horizontal yellow lines
% eps = 0.1;
% plot([p1(1,1), p4(1,1)-fd], [center+eps, center+eps], '-y')
% plot([p2(2,1)+fd, p1(2,1)], [center+eps, center+eps], '-y')
% plot([p1(1,1), p4(1,1)-fd], [center-eps, center-eps], '-y')
% plot([p2(2,1)+fd, p1(2,1)], [center-eps, center-eps], '-y')
% 
% plot([p1(1,1), p4(1,1)-fd], [center - rw, center - rw], '--y')
% plot([p2(2,1)+fd, p1(2,1)], [center - rw, center - rw], '--y')
% plot([p1(1,1), p4(1,1)-fd], [center + rw, center + rw], '--y')
% plot([p2(2,1)+fd, p1(2,1)], [center + rw, center + rw], '--y')


%verical fog lines
% plot(p2(:,1)+fd, [p2(1,2), p1(1,2)-fd], 'w')
% plot(p2(:,1)+fd, [p3(2,2)+fd, p2(2,2)], 'w')
% 
% plot(p4(:,1)-fd, [p4(1,2),p3(1,2)+fd], 'w')
% plot(p4(:,1)-fd, [p1(2,2)-fd,p4(2,2)], 'w')
% 
% %vertical yellow lines
% plot([center+eps, center+eps], [p2(1,2), p1(1,2)-fd], '-y')
% plot([center+eps, center+eps], [p3(2,2)+fd, p2(2,2)], '-y')
% plot([center-eps, center-eps], [p2(1,2), p1(1,2)-fd], '-y')
% plot([center-eps, center-eps], [p3(2,2)+fd, p2(2,2)], '-y')
% 
% plot([center + rw, center + rw], [p2(1,2), p1(1,2)-fd], '--y')
% plot([center + rw, center + rw], [p3(2,2)+fd, p2(2,2)], '--y')
% 
% plot([center - rw, center - rw], [p2(1,2), p1(1,2)-fd], '--y')
% plot([center - rw, center - rw], [p3(2,2)+fd, p2(2,2)], '--y')


axis square;

xlim([-60,60]);
ylim([-60,60]);
for j = 1:12
    xy=[];
    path = Geometry(j);
    for i=0:120
        xy = [xy; path.path(i)];
    end
    plot(xy(:,1),xy(:,2))
end