function [x,y]=rysTrajektorie(vo,a)
t = 0:0.1:2.0;
g = 10;
x = vo * cos(a)*t;
y = vo * sin(a) * t - (1 / 2) * g * t .^ 2;

plot (x,y, '-');
ylim([0 inf ])
end