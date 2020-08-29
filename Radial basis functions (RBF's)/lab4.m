size = Nt;
sizeV = Nv;

x_min = -2; 
x_max = 2;
y_min = -3;
y_max = 1;

fx = x_min : (x_max - x_min)/(size - 1) : x_max;
fy = y_min: (y_max - y_min)/(size - 1) : y_max;

f = fx.'*fy;

min_beta = 0.1;
max_beta = 20;
error = zeros(1,Nv);
max_error = zeros(100, 1);
mean_error = zeros(100,1);
iteration=1;
step = 0.1;
err = zeros(size,1);

for beta = min_beta : step : max_beta
    for i = 1:size
        for j = 1 : size
%            Gaussian
            f(i, j) = exp(-1*(sqrt((xt(i) - xt(j))^2 + (yt(i) - yt(j))^2)*beta).^2);
%           Inverse quadric
%           f(i, j) = 1/(1 + (sqrt((xt(i) - xt(j))^2 + (yt(i) - yt(j))^2)*beta).^2);
%           Multiquadric
%            f(i,j) = sqrt(1 + (sqrt((xt(i) - xt(j))^2 + (yt(i) - yt(j))^2)*beta).^2);
        end
    end

    a = f\ft;
    
    f2 = zeros(sizeV ,1);
    for i = 1:sizeV
        for j = 1:size
%            Gaussian
             f2(i) = f2(i) + a(j) * exp(-1*(sqrt((xv(i) - xt(j))^2 + (yv(i) - yt(j))^2)*beta).^2);
%           Inverse quadric
%            f2(i) = f2(i) + a(j) * 1/(1 + (sqrt((xv(i) - xt(j))^2 + (yv(i) - yt(j))^2)*beta).^2);
%           Multiquadric
%            f2(i) = f2(i) + a(j) * sqrt(1 + (sqrt((xv(i) - xt(j))^2 + (yv(i) - yt(j))^2)*beta).^2);
        end
        
        for k = 1: size
            error(k) = abs(f2(k) - fv(k));
        end
    
    end    
    
disp('Beta');
disp(beta);
disp(max(error));
disp(mean(error));
max_error(iteration) = max(error);
mean_error(iteration) = mean(error);

iteration = iteration+1;

end

close all
disp('minimum max_error');
[m,i] = min(max_error);
disp(m);
disp('for beta');
disp(i * step);
disp('minimum mean_error');
[m,i] = min(mean_error);
disp(m);
disp('for beta');
disp(i * step);

[xq, yq] = meshgrid(fx,fy);   
vq = griddata(xt,yt,ft,xq,yq);
figure(1);
mesh(xq, yq, vq);
hold on
plot3(xt,yt,ft,'o', 'MarkerFaceColor', 'r');
title('Surface plot');
xlabel('X');
ylabel('Y');
zlabel('f');
hold off

figure(2);
plot(min_beta : step : max_beta, max_error);
title('Max error plot');
xlabel('Beta');
ylabel('MAX ERROR');

figure(3);
plot(min_beta : step : max_beta, mean_error);
title('Mean error plot');
xlabel('Beta');
ylabel('MEAN ERROR');
