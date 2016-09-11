class selectiveArsenal: Module_F
{
	// Standard object definitions
	scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
	displayName = "Selective Arsenal"; // Name displayed in the menu
	/*icon = "\ee_scripts\data\iconNuke_ca.paa"; // Map icon. Delete this entry to use the default icon*/
	category = "EE_Scripts";

	// Name of function triggered once conditions are met
	function = "EE_Scripts_fnc_sa_selectiveArsenal";
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

	// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
	class ModuleDescription: ModuleDescription
	{
		description = "Short module description"; // Short description, will be formatted as structured text
	};
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
	};
};
