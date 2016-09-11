class equipmentSpawner: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "Equipment spawner"; // Name displayed in the menu

	category = "EE_Scripts";

	// Name of function triggered once conditions are met
	function = "EE_Scripts_fnc_es_equipmentSpawner";
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

	// Module arguments
	class Arguments: ArgumentsBaseUnits
	{
		// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
		// Module specific arguments
		//The code executed after box or vehicle creation
		class Init
		{
			displayName = "Init"; // Argument label
			description = "Init String. executed short after box or vehicle creation ([_logic,_vehicle, _vehicleName] spawn _init;)"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		//Classname of the box to spawn
		class BoxClass
		{
			displayName = "Box class string"; // Argument label
			description = "The class name for the box that should be spawned"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Type
			{
			displayName = "Type"; // Argument label
			description = "Type of equipment to spawn in the box"; // Tooltip description
			typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			class values
			{
				class EE_Scripts_item	{name = "Item";	value = "item"; default = 1;}; // Listbox item
				class EE_Scripts_weapon	{name = "Weapon"; value = "weapon";};
				class EE_Scripts_backpack	{name = "Backpack"; value = "backpack";};
			};
		};
		class Level
		{
				displayName = "Level"; // Argument label
				description = "Level of the equipment to spawn in the box (Box level +-Range)"; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
		};
		class Range
		{
				displayName = "Range"; // Argument label
				description = "Range of the equipment selection"; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				class values
				{
					class EE_Scripts_range0	{name = "0";	value = 0; default = 1;}; // Listbox item
					class EE_Scripts_range1	{name = "1"; value = 1;};
					class EE_Scripts_range2	{name = "2"; value = 2;};
					class EE_Scripts_range5	{name = "5"; value = 5;};
					class EE_Scripts_range10	{name = "10"; value = 10;};
				};
		};
	};

	// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
	class ModuleDescription: ModuleDescription
	{
		description = "Short module description"; // Short description, will be formatted as structured text
	};
};
