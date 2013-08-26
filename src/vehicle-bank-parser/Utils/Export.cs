using System;
using System.Collections.Generic;
using System.Globalization;
using VehicleBankParser.Renderers;

class Export
{
    private List<Vehicle> vehicles;
    private AbstractRenderer renderer;

    public Export(List<Vehicle> vehList)
    {
        vehicles = vehList;
    }

    public void genVehicleInfoData2()
    {
        sortByLevelTypeNationName();
        renderer = new VehicleInfoData2();
        renderer.buildFile(vehicles);
    }

    public void genVehicleInfo()
    {
        sortByLevelTypeNationName();
        renderer = new VehicleInfo();
        renderer.buildFile(vehicles);
    }

    public void genVehicleNames()
    {
        sortByNationName();
        renderer = new VehicleNames();
        renderer.buildFile(vehicles);
    }

    public void genVehicleInfoData()
    {
        sortByLevelTypeNationName();
        renderer = new VehicleInfoData();
        renderer.buildFile(vehicles);
    }


    /**
     * sort order: level -> type -> nation -> name
     */
    private void sortByLevelTypeNationName()
    {
        vehicles.Sort((a, b) =>
        {
            var n = a.level - b.level;
            if (n != 0)
                return n;
            n = Array.IndexOf(Defines.TYPES_FOR_SORT, a.getType()) - Array.IndexOf(Defines.TYPES_FOR_SORT, b.getType());
            if (n != 0)
                return n;
            n = Array.IndexOf(Defines.COUNTRIES, a.nation) - Array.IndexOf(Defines.COUNTRIES, b.nation);
            if (n != 0)
                return n;
            return String.Compare(a.name, b.name, true, new CultureInfo("en-US"));
        });
    }

    /**
     * sort order: nation -> name
     */
    private void sortByNationName()
    {
        vehicles.Sort((a, b) =>
        {
            var n = String.Compare(a.nation, b.nation, true, new CultureInfo("en-US"));
            if (n != 0)
                return n;
            return String.Compare(a.name, b.name, true, new CultureInfo("en-US"));
        });
    }
}