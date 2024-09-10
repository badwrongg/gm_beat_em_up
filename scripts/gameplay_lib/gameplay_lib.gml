// Values used to define and tweak various gameplay mechanics

// Character Constants
#macro C_CHARACTER_JUMP_POWER   18		// Default value, can be modified per object
#macro C_CHARACTER_MOVE_SPEED   3.2		// Default value, can be modified per object
#macro C_CHARACTER_MOVE_ACCEL	0.6		// Default value, can be modified per object
#macro C_CHARACTER_MOVE_DECEL	0.4		// Default value, can be modified per object
#macro C_CHARACTER_NO_ATTACK    -10		// For attack state
#macro C_CHARACTER_HIT_DEPTH    8		// Extra depth to hitboxes when attacking
#macro C_CHARACTER_AVOID_POWER  0.8		// Local avoidance is applied overtime as it decays.

// Gameplay Constants
#macro C_COLLISION_STEPS		8   	// Steps used to resolve collisions
#macro C_INPUT_REMEMBER			65536   // 16 frames (2^16), uses bitshift counter
#macro C_MOVE_TERM_VELOCITY	    25		// Max move distance per step 
#macro C_MOVE_MAX_IMPULSE		1000	// Max accumulated impulse force
#macro C_MOVE_MAX_IMPULSE_Z     32      // Max z impulse (jumping or knockups)
#macro C_MOVE_IMPULSE_FRICTION  0.85    // Decel for impulse movments      
#macro C_MOVE_GRAVITY_POWER     0.8     // Gravity for z impulse movement
#macro C_MOVE_AIR_CONTROL       1.2		// How much movement control in the air

// Game World Constants
#macro C_ENTITY_CULL_DISTANCE   1200    // Distance from view where entities are culled
#macro C_PARTICLE_SYSTEM_COUNT  50		// Number of particle systems to create
#macro C_NAVGRID_CELL_WIDTH     86		// Width of mp_grid used for navigation
#macro C_NAVGRID_CELL_HEIGHT    48		// Height of mp_grid used for navigation
#macro C_NAVGRID_CELL_WIDTH_2   43		// Half width of mp_grid used for navigation
#macro C_NAVGRID_CELL_HEIGHT_2  24		// Half height of mp_grid used for navigation

// AI
#macro C_AI_TARGET_UPDATE_TIME  0.25	// Time between AI target updates in seconds

// User Events
#macro EV_ANIMATION_SPRITES     11
#macro EV_ACTION_STATES			12
#macro EV_ATTACK_DATA			13
#macro EV_FUNCTION_DECLARATIONS 14
#macro EV_METHOD_BINDS			15

enum e_team
{
	// For hitbox checks (avoid friendly fire)
	neutral,
	player,
	enemy
}

enum e_attack
{
	// Properties used when calling create_attack_params()
	damage,
	knockback,
	knockup,
	effect,
	type
}

enum e_attack_type
{
	// Types of attack damage
	high,
	low,
	none
}