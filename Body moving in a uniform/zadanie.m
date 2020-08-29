g=10;
t=0:0.001:30;
time_size = length(t);
e = 0.01;

a_vector = [];
v_vector = [];
counter=0;
for c =1:100000
    v0 = rand()*20;
    a = rand()*pi/2;
    %booleany spelnienia warunku
    first = false;
    second = false;
    third = false;
   
    %petla probkowania czasu
    for j = 1:time_size
        time = t(j);
       
        x = v0 * cos(a)*time;
        y = v0 * sin(a)*time -(1/2) * g*time.^2;
           
            %pierwszy zakres
            if abs(x-2)<e && y>1 && y<4
               first = true;
            end
            %break the loop if critical condition is met
            if abs(x-3)<e && y>2 && y<3
                break
            end
            if abs(y-1)<e && x>4 && x<7
                third = true;
            end
    end
    if first==true && third==true
       a_vector = [a_vector a];
       v_vector = [v_vector v0];
       counter=counter+1;
    end
end



%L = length(a_vector);

%ix =randperm(L);        %miesza indeksy
%disp(ix)

%iix = ix(1:100);        %bierze tylko 100 pierwszych

%disp(iix)
%plot (a_vector(iix),v_vector(iix), 'ro', 'MarkerSize',10);


VoAlfa(a_vector,v_vector);

stworzWykres(a_vector,v_vector);
