%% Figure 1b Coloured Helices

close all;
clear;
startup;

sim = Simulation();
sim.Load_Amino_Acid_PDB_File(pdb_filepaths(6));
sim.Load_Helix(6,1,helix_indeces);
sim.Load_Helix(6,2,helix_indeces);
sim.Load_Helix(6,3,helix_indeces);
sim.Load_Helix(6,4,helix_indeces);
sim.Load_Helix(6,5,helix_indeces);
sim.Load_PDB_Parallel_Chain();

attributes = sim.Generate_Attributes_Struct();
attributes.mode = "dots";
attributes.helix_colours = [[0.3529,0.5686,0.7490];[0.7137,0.8824,0.9882];[0.8431,0.9020,0.5961];[1,0.5,0];[1,0,0]];

fig1 = sim.Make_Figure_With_Attributes(attributes);
view(fig1.CurrentAxes,122,12);
lgt = light(fig1.CurrentAxes);
lgt.Position = [10 20 15];
print(fig1,'figure_1b','-dpng','-r300');

%% Figure 1c Surface Plot 1

sim = Simulation();
sim.Load_Amino_Acid_PDB_File(pdb_filepaths(6));
sim.Load_Helix(6,1,helix_indeces);
sim.Load_Helix(6,2,helix_indeces);
sim.Load_Helix(6,3,helix_indeces);
sim.Load_Helix(6,4,helix_indeces);
sim.Load_Helix(6,5,helix_indeces);
sim.Load_PDB_Parallel_Chain();
% sim.Make_Figure();
output = sim.Run_Interaction_Mapping(2,4);
sim.Run_Static_Force(2,4)
% sim.Generate_Mapping_Figure(output);

sim.Generate_Mapping_Figure(circshift(output,[length(output)/2,length(output)/2]));
xticklabels({'-180','-90','0','90','180'});
yticklabels({'-180','-90','0','90','180'});
view(-114,35);
xlabel('Helix Rotation, degrees');
ylabel('Helix Rotation, degrees');
zlabel('Interaction Force, N');
print('figure_1c','-dpng','-r300');

%% Figure 1c Surface Plot 1

sim = Simulation();
sim.Load_Amino_Acid_PDB_File(pdb_filepaths(6));
sim.Load_Helix(6,1,helix_indeces);
sim.Load_Helix(6,2,helix_indeces);
sim.Load_Helix(6,3,helix_indeces);
sim.Load_Helix(6,4,helix_indeces);
sim.Load_Helix(6,5,helix_indeces);
sim.Load_PDB_Parallel_Chain();
% sim.Make_Figure();
output = sim.Run_Interaction_Mapping(2,4);
sim.Run_Static_Force(2,4)
% sim.Generate_Mapping_Figure(output);

sim.Generate_Mapping_Figure(circshift(output,[length(output)/2,length(output)/2]));
xticklabels({'-180','-90','0','90','180'});
yticklabels({'-180','-90','0','90','180'});
view(-49,35);
xlabel('Helix Rotation, degrees');
ylabel('Helix Rotation, degrees');
zlabel('Interaction Force, N');
print('figure_1d','-dpng','-r300');

%% Figure 2 Tile Before and After Optimisation Plots

close all;
clear;
startup;

view_coords = zeros(13,2);
view_coords(1,:) = [0,0];
view_coords(2,:) = [0,0];
view_coords(3,:) = [0,0];
view_coords(4,:) = [0,0];
view_coords(5,:) = [36,-2];
view_coords(6,:) = [122,12];
view_coords(7,:) = [0,0];
view_coords(8,:) = [0,0];
view_coords(9,:) = [0,0];
view_coords(10,:) = [0,0];
view_coords(11,:) = [0,0];
view_coords(12,:) = [0,0];
view_coords(13,:) = [0,0];

img1 = zeros(1313,1750,3);
img2 = zeros(1313,1750,3);
img3 = zeros(1313,1750,3);
img4 = zeros(1313,1750,3);
img5 = zeros(1313,1750,3);
img6 = zeros(1313,1750,3);
img7 = zeros(1313,1750,3);
img8 = zeros(1313,1750,3);
img9 = zeros(1313,1750,3);
img10 = zeros(1313,1750,3);
img11 = zeros(1313,1750,3);
img12 = zeros(1313,1750,3);
img13 = zeros(1313,1750,3);


for i = 1:13
    % Set up Simulation Instance
    sim = Simulation();
    sim.Load_Amino_Acid_PDB_File(pdb_filepaths(i));
    sim.Load_Helix(i,1,helix_indeces);
    sim.Load_Helix(i,2,helix_indeces);
    sim.Load_Helix(i,3,helix_indeces);
    sim.Load_Helix(i,4,helix_indeces);
    if(helix_indeces(i,5,1) == 0)
        helices_to_include = 1:4;
    else
        sim.Load_Helix(i,5,helix_indeces);
        helices_to_include = 1:5;
    end
    
    sim.Load_PDB_Parallel_Chain();

    attributes = sim.Generate_Attributes_Struct();
    attributes.mode = ["dots","primary_sidechain_emphesis","hide_normal_sidechains"];
    attributes.primary_sidechain_stick_colour = 'k';
    attributes.helix_colours = ones(5,3) * 0.6627;

    fig1 = sim.Make_Figure_With_Attributes(attributes);
    view(fig1.CurrentAxes,view_coords(i,1),view_coords(i,2));
    light(fig1.CurrentAxes);

    % Run Optimisation

    sim = Simulation();
    domain_index = i;
    helices_to_rotate = helices_to_include;
    inital_rotation_conditions_coefficient = 0;
    inital_translation_conditions_coefficient = 0;
    bounds_rotation_coefficient = 15;
    bounds_translation_coefficient = 10;
    sim.Initialise_Optim_Rot_Sim(domain_index,helix_indeces,helices_to_include,helices_to_rotate);
    results = sim.Run_Optim_RotTrans_Collision_Sim(inital_rotation_conditions_coefficient,inital_translation_conditions_coefficient,bounds_rotation_coefficient,bounds_translation_coefficient,100);
    attributes.primary_sidechain_stick_colour = '';
    attributes.helix_colours = ones(5,3) * -1;

    fig2 = sim.Make_Figure_With_Attributes(attributes);
    view(fig2.CurrentAxes,view_coords(i,1),view_coords(i,2));
    light(fig2.CurrentAxes);

    xl = xlim(fig2.CurrentAxes);
    yl = ylim(fig2.CurrentAxes);
    zl = zlim(fig2.CurrentAxes);

    xlim(fig1.CurrentAxes, xl);
    ylim(fig1.CurrentAxes, yl);
    zlim(fig1.CurrentAxes, zl);
    
    set(fig1.CurrentAxes,'visible','off');
    set(fig2.CurrentAxes,'visible','off');

    print(fig1,'optim_paper/comparison_fig_1','-dpng','-r300');
    print(fig2,'optim_paper/comparison_fig_2','-dpng','-r300');

    % image manipulation for transparency overlay

    [imgfig1,map1,alpha1] = imread('optim_paper\comparison_fig_1.png');
    % test = image(imgfig1);
    % test.AlphaData = all(test.CData == 255,3);

    imgfig2 = imread('optim_paper\comparison_fig_2.png');
    % imgfig3 = cat(3,imgfig2,ones(1313,1750));

    % figure();
    % C = imfuse(imgfig1,imgfig2,'blend');
    % img = imshow(C);

    fig3 = figure();
    imgfig3 = (imgfig1*0.5) + (imgfig2 * 0.6);
    img = imshow(imgfig3);
    
    switch i
        case 1
            img1 = imgfig3;
        case 2
            img2 = imgfig3;
        case 3
            img3 = imgfig3;
        case 4
            img4 = imgfig3;
        case 5
            img5 = imgfig3;
        case 6
            img6 = imgfig3;
        case 7
            img7 = imgfig3;
        case 8
            img8 = imgfig3;
        case 9
            img9 = imgfig3;
        case 10
            img10 = imgfig3;
        case 11
            img11 = imgfig3;
        case 12
            img12 = imgfig3;
        case 13
            img13 = imgfig3;
        otherwise
            fprintf("Wrong...\n");
    end

end
tilefig = figure();

img6big = imresize(img6,2);
quad2top = horzcat(img1,img2);
quad2bottom = horzcat(img3,img4);

quad2 = vertcat(quad2top,quad2bottom);
quad3 = vertcat(horzcat(img5,img7),horzcat(img8,img9));
quad4 = vertcat(horzcat(img10,img11),horzcat(img12,img13));

allQuads = vertcat(horzcat(img6big,quad2),horzcat(quad3,quad4));

tiledFigure = figure();
imshow(allQuads);

vertLength = size(allQuads,1) / 4;
horzLength = size(allQuads,2) / 4;

text(60,100,'R6', 'FontSize', 14);
text((horzLength * 2) + 60, (vertLength * 0) + 100, 'R1', 'FontSize', 14);
text((horzLength * 3) + 60, (vertLength * 0) + 100, 'R2', 'FontSize', 14);
text((horzLength * 2) + 60, (vertLength * 1) + 100, 'R3', 'FontSize', 14);
text((horzLength * 3) + 60, (vertLength * 1) + 100, 'R4', 'FontSize', 14);
text((horzLength * 0) + 60, (vertLength * 2) + 100, 'R5', 'FontSize', 14);
text((horzLength * 1) + 60, (vertLength * 2) + 100, 'R7', 'FontSize', 14);
text((horzLength * 2) + 60, (vertLength * 2) + 100, 'R8', 'FontSize', 14);
text((horzLength * 3) + 60, (vertLength * 2) + 100, 'R9', 'FontSize', 14);
text((horzLength * 0) + 60, (vertLength * 3) + 100, 'R10', 'FontSize', 14);
text((horzLength * 1) + 60, (vertLength * 3) + 100, 'R11', 'FontSize', 14);
text((horzLength * 2) + 60, (vertLength * 3) + 100, 'R12', 'FontSize', 14);
text((horzLength * 3) + 60, (vertLength * 3) + 100, 'R13', 'FontSize', 14);

print(tiledFigure.Parent.Parent,'comparision_tile','-dpng','-r300');

%% Figure 3 Force Extension Comparison Graphs

clear;
startup;

data = generate_force_extension_plot_data();
fig = figure();

plot(data.yao_stretch.x,data.yao_stretch.y, 'Color','Blue');

xlabel("Force, pN");
ylabel("Extension, nm");

hold on

plot(data.collision.x,data.collision.y, 'Color', 'Red');
plot(data.original.x,data.original.y, 'Color',[0.5 0.5 0.5]);

hold off

grid(fig.CurrentAxes, 'on');
grid(fig.CurrentAxes, 'minor');
legend(fig.CurrentAxes, 'Yao et al.', 'Sim Optimised', 'Sim Original', 'Location', 'southeast');

print(fig, 'figure_3','-dpng','-r300');