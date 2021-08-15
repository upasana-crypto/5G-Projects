function e = q3()
H=q1(5e9, 3, 1e-3,  2.5, 1e-3, 5, 5, -1);
H=vpa(H,100);
e=eig(H*H');

figure(1); clf;
semilogy(fliplr(e), 'x')
xlim([.5 9.5])
ylabel('eig(HH^H)')
xlabel('# Eigenvalue')
fig2pdf(1, './', 'q3_')

end
