function VoAlfa(a_vector,v_vector)
L = length(a_vector);

ix =randperm(L);        %miesza indeksy
disp(ix)

iix = ix(1:L);        %bierze tylko 100 pierwszych

disp(iix)
plot (a_vector(iix),v_vector(iix), 'ro', 'MarkerSize',1);
xlabel('alfa')
ylabel('Vo')
axis([0 inf 0 inf])
%ylim([0 20])
%xlim([0 20])
end