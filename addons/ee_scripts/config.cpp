class CfgPatches
{
	class EE_Scripts
	{
		units[] = {"equipmentSpawner","selectiveArsenal","vehicleSpawner","unitSpawner";"vehicleRespawner","reloadingAmmobox"};
		requiredVersion = 1.1;
		requiredAddons[] = {"A3_Modules_F","CBA_main"};
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class EE_Scripts: NO_CATEGORY
	{
		displayName = "EE Scripts";
	};
};
#include "defines.hpp"
