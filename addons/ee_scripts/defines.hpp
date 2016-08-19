class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

  #include "equipmentSpawner\cfgVehicles.hpp"
  #include "vehicleSpawner\cfgVehicles.hpp"
  #include "unitSpawner\cfgVehicles.hpp"
  #include "selectiveArsenal\cfgVehicles.hpp"
  #include "vehicleRespawner\cfgVehicles.hpp"
};

class CfgFunctions
{
	class EE_Scripts
	{
    tag = "EE_Scripts";
    #include "equipmentSpawner\cfgFunctions.hpp"
    #include "vehicleSpawner\cfgFunctions.hpp"
    #include "unitSpawner\cfgFunctions.hpp"
    #include "selectiveArsenal\cfgFunctions.hpp"
    #include "vehicleRespawner\cfgFunctions.hpp"
	};
};
#include "cfgEE_Scripts.hpp"
