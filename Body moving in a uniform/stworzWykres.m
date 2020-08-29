function stworzWykres(a_vector,v_vector)
vo1 = v_vector(1);
vo2 = v_vector(2);
vo3 = v_vector(3);
vo4 = v_vector(4);
vo5 = v_vector(5); 

a1 = a_vector(1);
a2 = a_vector(2);
a3 = a_vector(3);
a4 = a_vector(4);
a5 = a_vector(5);

figure

[x1,y1] = rysTrajektorie(vo1,a1);
plot(x1,y1, 'LineWidth',2)   % I trajektoria
hold on 
[x2,y2] = rysTrajektorie(vo2,a2);
plot(x2,y2, 'LineWidth',2)  % II trajektoria
hold on
[x3,y3] = rysTrajektorie(vo3,a3);
plot(x3,y3, 'LineWidth',2)  % III trajektoria
hold on
[x4,y4] = rysTrajektorie(vo4,a4);
plot(x4,y4, 'LineWidth',2)  % IV trajektoria
hold on
[x5,y5] = rysTrajektorie(vo5,a5);
plot(x5,y5, 'LineWidth',2)  % V trajektoria
hold on

plot([2 2],[1 4], 'g', 'LineWidth',4)  % przedzial dozwolony R1
hold on
plot([3 3],[2 3], 'r', 'LineWidth',4)  % przedzia³ niedozwolony R2
hold on
plot([4 7],[1 1], 'g', 'LineWidth',4) % przedzial dozwolony R3

grid on
xlabel('x')
ylabel('y')
title('Trajektoria, obszary dozwolone i niedozwolone');
legend('I trajektoria','II trajektoria', 'III trajektoria', 'IV trajektoria', 'V trajektoria')
end