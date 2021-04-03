include <BOSL2/std.scad>
include <BOSL2/stacks.scad>

///////////////////
// Vars
///////////////////

// [width, depth, height]
WOOD_SPACE=1;
PLANKS=[1800,93,2*18]; // https://www.leroymerlin.fr/produits/menuiserie/panneau-bois-tablette-etagere-tasseau-moulure-et-plinthe/tablette-bois-tablette-melamine/tablette-pin-noueux-lisse-l-200-x-l-30-cm-x-ep-18-mm-82025628.html
LEGS=[57,57,0]; // https://www.leroymerlin.fr/produits/menuiserie/panneau-bois-tablette-etagere-tasseau-moulure-et-plinthe/tasseau-planche-et-equerre-de-fixation/tasseau-et-latte-a-lambris/tasseau-sapin-petits-noeuds-rabote-57-x-57-mm-l-2-4-m-61536160.html#component-displaycomp
SLEEPER=[0,25,50];

///////////////////
// Bench module
///////////////////

module benche(
  max_width=800,
  max_height=300,
  space=25,
  nb_planks=3,
  bottom_sort_sleeper=false,
  bottom_long_sleeper=false
  ) {

  legs_height = max_height-PLANKS[2];

  top_width = max_width;
  top_depth = nb_planks*PLANKS[1];

  side_width = top_width-(2*(space+LEGS[0]));
  side_depth = top_depth-(2*(space+LEGS[1]));
  leg_ratio = 4;

  echo("---------- inventories ----------");


  ///////////////////
  // Top
  ///////////////////
  color("#6A5348")
  ycopies(PLANKS[1],nb_planks,sp=[0,0,0]) cuboid(p1=[0,0,legs_height],p2=[top_width,PLANKS[1]-WOOD_SPACE,legs_height+PLANKS[2]]);

  echo(nb_planks , "planks ( ",top_width, " x ", PLANKS[1], " x ", PLANKS[2], ")" );

  ///////////////////
  // Legs & Sleeper
  ///////////////////
  color("#B79171") {
    // Legs
    grid3d(xa=[space,top_width-LEGS[0]-space], ya=[space,top_depth-LEGS[1]-space], za=[0,0]) cuboid(p1=[0,0,0],p2=[LEGS[0],LEGS[1],legs_height]);
    echo(4 , "legs ( ",PLANKS[1], " x ", PLANKS[1], " x ", legs_height, ")" );

    // Top long sleeper
    grid3d(xa=[top_width/2,top_width/2], ya=[space+LEGS[1]/2,top_depth-LEGS[1]/2-space], za=[legs_height-SLEEPER[2]/2,legs_height-SLEEPER[2]/2]) cuboid([top_width-2*(LEGS[0]+space),SLEEPER[1],SLEEPER[2]]);
    echo(2 , "sleeper ( ",top_width-2*(LEGS[0]+space), " x ", SLEEPER[1], " x ", SLEEPER[2], ")" );

    // Top sort sleeper
    grid3d(xa=[space+LEGS[0]/2,top_width-LEGS[0]/2-space], ya=[top_depth/2,top_depth/2], za=[legs_height-SLEEPER[2]/2,legs_height-SLEEPER[2]/2]) cuboid([SLEEPER[1],top_depth-2*(LEGS[1]+space),SLEEPER[2]]);
    echo(2 , "sleeper ( ",SLEEPER[1], " x ", top_depth-2*(LEGS[1]+space), " x ", SLEEPER[2], ")" );

    // Bottom hort sleeper
    if (bottom_sort_sleeper || bottom_long_sleeper) grid3d(xa=[space+LEGS[0]/2,top_width-LEGS[0]/2-space], ya=[top_depth/2,top_depth/2], za=[legs_height/leg_ratio-SLEEPER[2]/2,legs_height/leg_ratio-SLEEPER[2]/2]) cuboid([SLEEPER[1],top_depth-2*(LEGS[1]+space),SLEEPER[2]]);
    echo(2 , "sleeper ( ",SLEEPER[1], " x ", top_depth-2*(LEGS[1]+space), " x ", SLEEPER[2], ")" );

    // Bottom long sleeper
    if (bottom_long_sleeper) grid3d(xa=[top_width/2,top_width/2], ya=[top_depth/2,top_depth/2], za=[legs_height/leg_ratio-SLEEPER[2]/2,legs_height/leg_ratio-SLEEPER[2]/2]) cuboid([top_width-2*(SLEEPER[1]+space),SLEEPER[1],SLEEPER[2]]);
    echo(1 , "sleeper ( ",top_width-2*(SLEEPER[1]+space), " x ", SLEEPER[1], " x ", SLEEPER[2], ")" );
  }

  echo("---------------------------------");

}

// benche();

// move([300,1000,0])
// benche(bottom_sort_sleeper=true);

// move([300,2000,0])
// benche(bottom_long_sleeper=true);
