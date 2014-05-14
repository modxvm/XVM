using System;
using System.Collections.Generic;

namespace VehicleBankParser.Renderers
{
    class VehicleNames : AbstractRenderer
    {
        public VehicleNames()
        {
            OUTPUT_FILE = "release\\configs\\@Default\\vehicleNames.xc";
        }

        protected override String getHeader()
        {
            return
@"/**
 * Vehicle names mapping. null value for standard name.
 * Замена названий танков. Значение null - использовать стандартное название.
 */
{" +
"\n  \"vehicleNames\": {";
        }

        protected override String getFooter()
        {
            return "  }\n}";
        }

        private String parseVehicle(Vehicle veh)
        {
            return (String.Format("\"{0}_{1}\": {{\"name\": null, \"short\": null}}",
               veh.nation.ToLower(),
               veh.name.Replace("-", "_")
            ));
        }

        protected override void writeLines(List<Vehicle> vehList)
        {
            int i = 1;
            foreach (Vehicle veh in vehList)
            {
                file.WriteLine("    " + parseVehicle(veh) + (i == vehList.Count ? "" : ","));
                i++;
            }
        }
    }
}
