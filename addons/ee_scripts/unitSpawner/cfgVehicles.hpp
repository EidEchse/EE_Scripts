class unitSpawner: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "Unit spawner"; // Name displayed in the menu
	/*icon = "\ee_scripts\data\iconNuke_ca.paa"; // Map icon. Delete this entry to use the default icon*/
	category = "EE_Scripts";

	icon = "\ee_scripts\img\IconModule_UnitSporn.paa";

	// Name of function triggered once conditions are met
	function = "EE_Scripts_fnc_us_unitSpawner";
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
			description = "Init String. executed short after box creation ([_logic,_vehicle, _vehicleName] spawn _init;)"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class BoxClass
		{
			displayName = "Box class string"; // Argument label
			description = "The class name for the box that should be spawned"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Type
		{
			displayName = "Type"; // Argument label
			description = "Unit or group spawn"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class Unit	{name = "Unit";	value = "unit"; default = 1;}; // Listbox item
				class Group	{name = "Group"; value = "group";};
			};
		};
		class Units
  	{
			displayName = "Units or Groups";
			description = 'Classnames of units as , seperated list ("B_Soldier_F","B_Soldier_GL_F","B_soldier_AR_F")';
			defaultValue = ""; // Default text filled in the input box
			typeName = "STRING";
			// When no 'values' are defined, input box is displayed instead of listbox
		};
		class Count
		{
			displayName = "Count"; // Argument label
			description = "Number of units to spawn at the same time"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Respawn
		{
			displayName = "Respawn"; // Argument label
			description = "Respawn time per unit in minutes"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Skill
		{
			displayName = "Skill"; // Argument label
			description = "Skill of the units"; // Tooltip description
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
	};

	// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
	class ModuleDescription: ModuleDescription
	{
		description = "Short module description"; // Short description, will be formatted as structured text
	};
};
