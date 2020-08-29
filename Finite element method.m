x0 = 0;
x1 = 2;
N = 50;
k1 = 1;
k2 = 3;
A = 0.1;
d = 900;
cp = 20;

Le = (x1 - x0)/N;
x= linspace(x0, x1, N + 1);

K = sparse(N + 1, N + 1);
M = sparse(N + 1, N + 1);
L = zeros(N + 1, 1);

f = 1;

for p=1:N
    xd = x0 + Le * p;
    if (xd > 0.6 * (x1 - x0)) 
        Ke = (k1*A/Le)*[1 -1; -1 1];
    else
        Ke = (k2*A/Le)*[1 -1; -1 1];
    end
    Me = (A*Le/6)*[2 1; 1 2] * cp * d;
    K(p: p+1, p:p+1) = K(p:p+1,p:p+1) + Ke;
    M(p: p+1, p:p+1) = M(p:p+1,p:p+1) + Me;
    if (xd > 0.4 * (x1 - x0)) 
        L(p: p+1) = L(p:p + 1) + Le/2 * 0;
    else
        L(p: p+1) = L(p:p + 1) + Le/2 * exp(xd);
    end
end

% K = K(1:end-1,1:end-1);
% M = M(1:end-1,1:end-1);
% L = L(1:end-1, 1);

vidObj = VideoWriter('heat1D.avi');
open(vidObj);

U0(1) = 3;
U0(2:N+1,1) = 0;
% U0 = U0(1:end -1);
U0(end) = 13;
Q = 9000;
dt = 1e0;
V = zeros(900, 1);
figure(1);
for p=1:Q
    U1 = (M + dt*K)\(M*U0 + dt*L);
    U1(1) = 3;
    U1(end) = 13;
    U0 = U1;
    V(p) = U1(26);
    
    plot(x, U1, 'b-o');
    ylim([3 13]);
    str = ['dt =' num2str(dt) ', time = ' num2str(p*dt)];
    title(str);
    currFrame = getframe(gcf);
    writeVideo(vidObj, currFrame);
end

xD= linspace(0, Q * dt, Q);
figure(2);
plot(xD, V, 'r');
ylim([-1 7]);
close(vidObj);
disp(V);

implay('heat1D.avi');
