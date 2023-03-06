#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;

init()
{

    level thread OnPlayerConnect();

}

OnPlayerConnect()
{

    while ( true )
    {

        level waittill( "connecting", player );
        player thread OnPlayerSpawned();

    }

}

OnPlayerSpawned()
{

    level endon( "game_ended" );
	self endon( "disconnect" );

    while ( true )
    {

        self waittill( "spawned_player" );

        self thread box_hit_calc();
        self thread box_hit_hud();

    }

}

box_hit_calc()
{

    level.box_hits = 0;
    for ( i = 0; i < level.chests.size; i++ )
    {

        level.chests[i] thread checkforhit();

    }

}

checkforhit()
{

    while ( 1 )
    {

        self waittill( "trigger" );
        level.box_hits++;
        self waittill( "chest_accessed" );

    }

}

box_hit_hud()
{

    self endon( "disconnect" );

    boxhits = newClientHudElem( self );
    boxhits.alignx = "left";
    boxhits.aligny = "top";
	boxhits.horzalign = "user_left";
	boxhits.vertalign = "user_top";
	boxhits.x += 5;
	boxhits.y += 20;
	boxhits.fontscale = 1.4;
	boxhits.alpha = 0;
	boxhits.color = ( 1, 1, 1 );
	boxhits.hidewheninmenu = 1;
	boxhits.label = &"Box Hits: ";

	flag_wait( "initial_blackscreen_passed" );

    boxhits.alpha = 1;
    while ( true )
    {

        boxhits setValue(level.box_hits);

        wait( 0.1 );

    }

}