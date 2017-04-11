function h = circle(x,y,r,Lx,Ly)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
patch(xunit, yunit,'r','EdgeColor',[1 1 1]);
hold on

