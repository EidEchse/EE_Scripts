class vehicleSpawner: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "Vehicle spawner"; // Name displayed in the menu
	/*icon = "\ee_scripts\data\iconNuke_ca.paa"; // Map icon. Delete this entry to use the default icon*/
	category = "EE_Scripts";

	// Name of function triggered once conditions are met
	function = "EE_Scripts_fnc_vs_vehicleSpawner";
	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	functionPriority = 10;
	// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isGlobal = 1;
	// 1 for module waiting until all synced triggers are activated
	isTriggerActivated = 1;
	// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
	isDisposable = 1;
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
			description = "Init String. executed short after box creation ([_logic,_vehicle, _vehicleName] spawn _init;)"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Type
			{
			displayName = "Type"; // Argument label
			description = "Type of vehicle to spawn at the position"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class EE_Scripts_aa	{name = "Anti-Air";	value = "aa"; default = 1;}; // Listbox item
				class EE_Scripts_vehicle	{name = "Vehicles"; value = "vehicle";};
				class EE_Scripts_artillary	{name = "Artillarys"; value = "artillary";};
				class EE_Scripts_plane	{name = "Planes"; value = "plane";};
				class EE_Scripts_boat	{name = "Boats"; value = "boat";};
				class EE_Scripts_helicopter	{name = "Helicopters"; value = "helicopter";};
			};
		};
		class Level
		{
			displayName = "Level"; // Argument label
			description = "Level of the vehicle to spawn at the position (Box level +-Range)"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Range
		{
			displayName = "Range"; // Argument label
			description = "Range of the vehicle selection"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class EE_Scripts_range0	{name = "0";	value = 0; default = 1;}; // Listbox item
				class EE_Scripts_range1	{name = "1"; value = 1;};
				class EE_Scripts_range2	{name = "2"; value = 2;};
				class EE_Scripts_range5	{name = "5"; value = 5;};
				class EE_Scripts_range10	{name = "10"; value = 10;};
				class EE_Scripts_range15	{name = "15"; value = 15;};
				class EE_Scripts_range20	{name = "20"; value = 20;};
			};
		};
	};

	// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
	class ModuleDescription: ModuleDescription
	{
		description = "Short module description"; // Short description, will be formatted as structured text
	};
};
