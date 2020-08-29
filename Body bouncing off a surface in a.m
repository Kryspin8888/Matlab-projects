[X,Y] = meshgrid(-15:1:15,-15:15);
Z = X.^2 + Y.^2;
surf(X,Y,Z);
%surfnorm(X,Y,Z)

pos_before = [-5, 0, 200]; %po³o¿enie pocz¹tkowe
pos_after = [];
g = 10;
v_before = [2, 4, 0]; % prêdkoœæ pocz¹tkowa
v_after = [];
k = 1;
m = 1;
T = table();
trajectory = [];

%pochodne cz¹stkowe do obliczenia normalnej do powierzchni
syms x y
f(x,y) = x^2 + y^2; %nasza powierzchnia
dx = diff(f,x);
dy = diff(f,y);

hold on 
%rysowanie punktu startowego
plot3(pos_before(1),pos_before(2),pos_before(3),'o', 'MarkerFaceColor', 'r','MarkerSize',10);

for counter = 1:5

    %obliczanie czasu w jakim nast¹pi³o odbicie - wzór (5)
    % p - zawiera wspó³czynniki wielomianu, obliczone na podstawie powierzchni
    p = [v_before(1)^2 + v_before(2)^2 + 1/2*g, 2*pos_before(1)*v_before(1) + 2*pos_before(2)*v_before(2) - v_before(3), pos_before(1)^2 + pos_before(2)^2 - pos_before(3)]; 
    t = roots(p); % miejsca zerowe wielomianu czyli nasz potencjalny czas odbicia
    time = max(t); % biorê najwiêkszy z mo¿liwych

    %obliczanie po³o¿enia
    pos_after(1) = pos_before(1) + v_before(1)*time; % x
    pos_after(2) = pos_before(2) + v_before(2)*time; % y
    pos_after(3) = pos_before(3) + v_before(3)*time - 1/2*g*time^2; % z
    
    %rysowanie punktów odbicia
    plot3(pos_after(1),pos_after(2),pos_after(3),'o', 'MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',10);
    
    %obliczanie trajektorii - 5 iteracji ¿eby by³o widaæ parabolê a nie liniê prost¹
    trajectory = [trajectory; pos_before]; % dodajê punkty odbicia do punktów trajektorii
    for j = 1:5 
        xx = pos_before(1) + v_before(1)*time/5*j; % x
        yy = pos_before(2) + v_before(2)*time/5*j; % y
        zz = pos_before(3) + v_before(3)*time/5*j - 1/2*g*(time/5*j)^2; % z
        trajectory = [ trajectory; xx,yy,zz];
    end

    %obliczanie normalnej do powierzchni w punkcie odbicia
    N = [-dx(pos_after(1),pos_after(2)), -dy(pos_after(1),pos_after(2)), 1];
    N_norm = norm(N);
    n = N ./ N_norm;

    %obliczam now¹ sk³adow¹ 'z' prêdkoœci w momencie odbicia
    v_before(3) = v_before(3) - g*time;

    %obliczam now¹ prêdkoœæ - po odbiciu
    v_after = sqrt(k) * (v_before - 2 * dot(v_before,n) * n);

    %przepisuje wartoœci do kolejnej iteracji
    v_before(1) = v_after(1); % Vx
    v_before(2) = v_after(2); % Vy
    v_before(3) = v_after(3); % Vz

    pos_before(1) = pos_after(1); % x
    pos_before(2) = pos_after(2); % y
    pos_before(3) = pos_after(3); % z

    %gdy istnieje strata Ek liczê bez straty
    if k < 1
        E_kin = m * norm(v_before / sqrt(k))^2 / 2;
    else 
        E_kin = m * norm(v_before)^2 / 2;
    end

    E_pot = m * g * pos_before(3);
    E_tot = E_kin + E_pot;
    %dodajê nowe wiersze do tabeli
    T = [T ; {pos_before(1),pos_before(2),pos_before(3),time,E_kin,E_pot,E_tot,k}];

end

%dodajê nazwy kolumn do tabeli
varNames = {'x','y','z','delta_t','E_kin','E_pot','E_tot','k'};
T.Properties.VariableNames = varNames;
%rysowanie trajektorii
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3),'-','LineWidth',3,'Color','m');
disp(T);
hold off