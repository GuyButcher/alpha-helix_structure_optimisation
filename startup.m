clc
fprintf("---: PDB and Talin Sim :---\n")
fprintf("Executing Startup:...\n");

fprintf("Adding 'classes' path.\n");
addpath("classes/");

fprintf("Running 'gen_residue_properties'.\n");
gen_residue_properties;

fprintf("Adding 'functions_and_scripts' path.\n");
addpath("functions_and_scripts/");

fprintf("Adding 'pdb_data' path.\n");
addpath("pdb_data/");

fprintf("Loading variable 'helix_indeces' to Workspace.\n");
load("helix_indeces.mat");

fprintf("Loading variable 'pdb_filepaths' to Workspace.\n")
pdb_filepaths = Get_Talin_PDB_Filepaths();

fprintf("Startup Complete.\n\n\n");