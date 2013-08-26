using System;
using System.Collections.Generic;

namespace VehicleBankParser.Renderers
{
    class VehicleInfo : AbstractRenderer
    {
        public VehicleInfo()
        {
            OUTPUT_FILE = "release\\res\\VehicleInfo.json";
        }

        protected override String getHeader()
        {
            return "{";
        }

        protected override String getFooter()
        {
            return "}";
        }

        protected override void writeLines(List<Vehicle> vehList)
        {

            foreach (Vehicle veh in vehList)
            {
                file.WriteLine("  " + parseVehicle(veh) + ",");
            }

            file.WriteLine("  \"observer\": { \"level\": 0, \"name\": \"Observer\" },");
            file.WriteLine("  \"unknown\":  { \"level\": 0, \"name\": \"UNKNOWN\" }");
        }

        private String parseVehicle(Vehicle veh)
        {
            return (String.Format("{0} {{ {1}{2}{3}{4}{5}{6}{7}{8}{9} }}",
              String.Format("\"{0}\":", veh.name.Replace("-", "_").ToLower()).PadRight(29),
              String.Format("\"id\": {0},", veh.tankId).PadRight(11),
              String.Format("\"level\": {0},", veh.level).PadRight(13),
              String.Format("\"type\": \"{0}\", ", veh.getType()).PadRight(15),
              String.Format("\"hpstock\": {0}, ", veh.hpstock).PadRight(17),
              String.Format("\"hptop\": {0}, ", veh.hptop).PadRight(15),
              String.Format("\"turret\": {0}, ", veh.status),
              String.Format("\"premium\": {0}, ", veh.premium ? "1" : "0"),
              String.Format("\"nation\": \"{0}\", ", veh.nation).PadRight(21),
              String.Format("\"name\": \"{0}\"", veh.name)));
        }

    }
}
