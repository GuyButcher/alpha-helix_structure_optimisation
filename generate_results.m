%% Generate all data for tables
close all;
clear;
startup;

% Original Force
orig_force_results = Simulation.Run_All_Bundle_Static_Forces();

% Domain Names
for i = 1:13
    domain_names(i) = sprintf("R%i", i);
end

% Optimised Force
optim_results = [];
for i = 1:13
    domain_names(i) = sprintf("R%i", i);
    result = do_bundle_optimisation_rot_trans(i, helix_indeces, false);
    optim_results = [optim_results;result];
end
optim_force_results = [optim_results.final_force];

% Position and Rotation Deltas
for i = 1:13
    optim_results_rotation{i} = optim_results(i).final_rotation_configuration;
    optim_results_position{i} = optim_results(i).final_translation_configuration;
end

% Collisions Optim Sims

% Optimised Force
optim_collision_results = [];
for i = 1:13
    domain_names(i) = sprintf("R%i", i);
    result = do_bundle_optim_rot_trans_collision(i, helix_indeces, false);
    optim_collision_results = [optim_collision_results;result];
end
optim_collision_force_results = [optim_collision_results.final_force];

% Position and Rotation Deltas
for i = 1:13
    optim_collision_results_rotation{i} = optim_collision_results(i).final_rotation_configuration;
    optim_collision_results_position{i} = optim_collision_results(i).final_translation_configuration;
end

% Saving Pre-table Results

table_data.names = domain_names;
table_data.original_force = orig_force_results;
table_data.optim_force = optim_force_results;
table_data.force_delta = table_data.optim_force - table_data.original_force;
table_data.optim_position = optim_results_position;
table_data.optim_rotation = optim_results_rotation;
table_data.optim_col_force = optim_collision_force_results;
table_data.optim_col_force_delta = table_data.optim_col_force - table_data.original_force;
table_data.optim_col_position = optim_collision_results_position;
table_data.optim_col_rotation = optim_collision_results_rotation;
for i = 1:13
    table_data.optim_col_position_mean(i) = mean(table_data.optim_col_position{i});
    table_data.optim_col_rotation_mean(i) = mean(table_data.optim_col_rotation{i});
end
save('optim_collision_results_table', 'table_data');
