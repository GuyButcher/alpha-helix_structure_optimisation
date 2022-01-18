# Readme
### Repository for alpha-helix structural optimisation code

#### Key Files
* `startup.m` generates any required data `.mat` files and add relevant folders to Matlab's current path.
* `generate_results.m` runs all the simulations to generate the data and results.
* `generate_table.m` creates tables use in manuscript from simulation results.
* `generate_figures.m` creates all figures used in manuscript from simulation results.
#### Folders
 * `classes/` holds the class definitions and member functions for the key classes the handle all simulation objects and generate simulation objects from pdb data.
 * `funtions_and_scripts/` holds helper functions.
 * `pdb_data/` contains the local copy of the pdb files used within the simulation. 
