class vehicleRespawner: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "Vehicle Respawner"; // Name displayed in the menu
	/*icon = "\ee_scripts\data\iconNuke_ca.paa"; // Map icon. Delete this entry to use the default icon*/
	category = "EE_Scripts";

	icon = "\ee_scripts\img\IconModule_vehicleSporn.paa";

	// Name of function triggered once conditions are met
	function = "EE_Scripts_fnc_vr_vehicleRespawner";
	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	functionPriority = 10;
	// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isGlobal = 1;
	// 1 for module waiting until all synced triggers are activated
	isTriggerActivated = 1;
	// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
	isDisposable = 0;
	// // 1 to run init function in Eden Editor as well
	is3DEN = 0;

	// Menu displayed when the module is placed or double-clicked on by Zeus
	/*curatorInfoType = "RscDisplayAttributeEquipmentSpawner";*/

	// Module arguments
	class Arguments: ArgumentsBaseUnits
	{
		// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
		/*class Units: Units {};*/
		// Module specific arguments
		class Init
		{
			displayName = "Init"; // Argument label
			description = "Init String. executed short after vehicle creation ([_logic,_vehicle, _vehicleName] spawn _init;)"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Name
		{
			displayName = "Vehicle Name"; // Argument label
			description = "Class name of the vehicle to spawn"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Respawn
		{
			displayName = "Respawn Time"; // Argument label
			description = "Respawn time in minutes"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "";
	};
};
