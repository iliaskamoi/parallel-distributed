grapher1("Cilk_2.jpg", [1, 2, 3, 4, 8], [0.543351, 0.396003, 0.297130, 0.306597, 0.362975]);
grapher1("Cilk_3.jpg", [1, 2, 3, 4, 8], [ 0.306042, 0.157890, 0.142756, 0.134441, 0.147650]);
grapher1("Cilk_1.jpg", [1, 2, 3, 4, 8], [ 0.702814,  0.438404,  0.395235, 0.380468, 0.266733]);
grapher1("Simple_C_3.jpg", [1, 2, 3, 4, 8], [0.267076, 0.230409, 0.330967, 0.306371, 0.255821]);
grapher1("Simple_C_2.jpg", [1, 2, 3, 4, 8], [0.461432, 0.437526, 0.501741, 0.505987, 0.431357]);
grapher1("Simple_C_1.jpg", [1, 2, 3, 4, 8], [0.684286,  0.727278, 0.665424, 0.669959, 0.602167]);
grapher1("OpenMP_3.jpg", [1, 2, 3, 4, 8], [0.302360, 0.125020, 0.101001,  0.123407,  0.089431]);
grapher1("OpenMP_2.jpg", [1, 2, 3, 4, 8], [0.378298, 0.314995, 0.203841,  0.280896, 0.224307]);
grapher1("OpenMP_1.jpg", [1, 2, 3, 4, 8], [ 0.730037,  0.410506,  0.381187, 0.272976,  0.285763]);
function grapher1(name, threads, exec_time)
    figure;
    plot(threads, exec_time,  'o-', 'LineWidth', 2);
    xlabel('Threads');
    ylabel('Execution Time (Secs)');
    title(name);
    name = strcat("/home/ilias/Desktop/distributed/figures/", name);
    print(gcf, name, '-dpng', '-r0');
end