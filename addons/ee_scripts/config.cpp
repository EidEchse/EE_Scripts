class CfgPatches
{
	class EE_Scripts
	{
		units[] = {"equipmentSpawner","vehicleSpawner","unitSpawner"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
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
