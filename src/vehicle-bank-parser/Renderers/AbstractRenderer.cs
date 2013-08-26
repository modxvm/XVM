using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using VehicleBankParser.Properties;

namespace VehicleBankParser.Renderers
{
    abstract class AbstractRenderer
    {
        protected String OUTPUT_FILE;
        protected static StreamWriter file;

        public void buildFile(List<Vehicle> vehList)
        {
            if (!Directory.Exists(Settings.Default.XVM_PATH)) 
            {
                throw new FileNotFoundException("Specify correct XVM folder");
            }

            if (String.IsNullOrEmpty(OUTPUT_FILE))
            {
                throw new Exception("Output file is not defined.");
            }

            file = new StreamWriter(Path.Combine(Settings.Default.XVM_PATH, OUTPUT_FILE), false, Encoding.UTF8);

            file.WriteLine(getHeader());
            writeLines(vehList);
            file.WriteLine(getFooter());

            file.Close();

            Console.WriteLine("Generated file: " + Path.GetFileName(OUTPUT_FILE));
        }

        protected abstract void writeLines(List<Vehicle> vehList);

        protected abstract String getHeader();

        protected abstract String getFooter();
    }
}
