%% Table One Generation

if(not(isfile('optim_collision_results_table.mat')))
    generate_results;
end

if(not(exist('table_data', 'var')))
    collision_results = load('optim_collision_results_table', 'table_data');
    table_data = collision_results.table_data;
end

clearvars tab output;

tab.bundle = table_data.names';
tab.orig_force = round(table_data.original_force, 3, 'significant')' * 10^12;
tab.optim_col_force = round(table_data.optim_col_force, 3, 'significant')' * 10^12;
tab.force_delta = round(table_data.optim_col_force_delta, 3, 'significant')' * 10^12;
tab.position_delta = process_cells_for_table(table_data.optim_col_position);
tab.rotation_delta = process_cells_for_table(table_data.optim_col_rotation);
tab.position_delta_mean = round(table_data.optim_col_position_mean, 3, 'significant')';
tab.rotation_delta_mean = round(table_data.optim_col_rotation_mean, 3, 'significant')';

output = struct2table(tab);
output.Properties.VariableNames = {...
    'Bundle', ...
    'Original Force, \si{\pico\newton}', ...
    'Optimised Force, \si{\pico\newton}', ...
    'Force Delta, \si{\pico\newton}', ...
    'Position Delta, \si{\angstrom}', ...
    'Rotation Delta, Degrees', ...
    'Mean Position Delta, \si{\angstrom}', ...
    'Mean Rotation Delta, Degrees'};

% output.Properties.VariableNames = {...
%     'Bundle', ...
%     'Original Force, \si{\pico\newton}', ...
%     'Optimised Force, \si{\pico\newton}', ...
%     'Force Delta, \si{\pico\newton}', ...
%     'Mean Position Delta, \si{\angstrom}', ...
%     'Mean Rotation Delta, Degrees'};

save('table_1_object', 'output');
tableLatex(output, 'table_1', true);

%% Table Two Data Generation

collision_force = table_data.optim_col_force;
collision_extension = [160,200,240,280,320,360,400,440,520,520,560,600,640,680];

[sorted_collision_forces,collision_sortID] = sort(-collision_force' * 10^(12));

r7 = (collision_sortID == 7);
r8 = (collision_sortID == 8);
sorted_collision_forces(r7) = sorted_collision_forces(r7) + sorted_collision_forces(r8);
sorted_collision_forces(r8) = [];
collision_sortID(r8) = [];

sorted_collision_forces = -sorted_collision_forces;
