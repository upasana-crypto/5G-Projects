function e = q2()
H=q1();
H=vpa(H,100);
e = eig(H*H');

figure(1); clf;
semilogy(fliplr(e), 'x')
xlim([.5 9.5])
ylabel('eig(HH^H)')
xlabel('# Eigenvalue')
fig2pdf(1, './', 'q2_')

end