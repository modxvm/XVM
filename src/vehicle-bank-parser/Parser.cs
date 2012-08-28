using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;


static class Parser
{
    /**
     * Parses XML nodes object.
     * Gets turret possibilities, max HP, tank name.
     * Saves parsed data to new AffectedVehicles object.
     */
    public static List<Vehicle> parseFiles(List<XmlNode> allVehicles)
    {
        List<Vehicle> parsedData = new List<Vehicle>();

        foreach (XmlNode vehicle in allVehicles)
        {
            if (vehicle.SelectSingleNode("//turrets0") == null)
                throw new Exception("Error: " + vehicle.Name + " not a vehicle file.");

            short status = getTurretStatus(vehicle);
            if (status == Vehicle.ONLY_ONE_TURRET)
                continue;
            string name = getVehicleName(vehicle);
            int hpstock = getHpStock(vehicle);
            parsedData.Add(new Vehicle(name, hpstock, status));
        }

        return parsedData;
    }

    private static short getTurretStatus(XmlNode rootNode)
    {
        XmlNode turretsNode = rootNode.SelectSingleNode("//turrets0");
        /**
         * FirstChild is empty - "".
         * 2 turrets - 3 children.
         * 1 turret - 2 children.
         */
        if (turretsNode.ChildNodes.Count == 2)
            return Vehicle.ONLY_ONE_TURRET;

        XmlNodeList secondTurretNodes = turretsNode.LastChild.ChildNodes;
        foreach (XmlNode node in secondTurretNodes)
        {
            if (node.Name == "unlocks")
                return Vehicle.TOP_TURRET_UNLOCKS_TOP_GUN;
        }

        return Vehicle.TOP_TURRET_SINGLE;
    }

    private static string getVehicleName(XmlNode rootNode)
    {
        // from  <a-20.xml><crew>...
        // to    a-20
        return rootNode.Name.ToString().Replace(".xml", "");
    }

    private static int getHpStock(XmlNode rootNode)
    {
        /**
         * Hull HP
         * a-20 hull HP - 272
         */
        XmlNode hullHpNode = rootNode.SelectSingleNode("//hull/maxHealth");
        if (hullHpNode == null)
            throw new Exception("hullHpNode == null");

        /**
         * Stock turret HP
         * a-20 stock turret HP - 68
         */
        XmlNode turretsNode = rootNode.SelectSingleNode("//turrets0");
        XmlNodeList secondTurretNodes = turretsNode.FirstChild.NextSibling.ChildNodes;
        XmlNode stockTurretHpNode = null;
        foreach (XmlNode node in secondTurretNodes)
            if (node.Name == "maxHealth")
                stockTurretHpNode = node;
        if (stockTurretHpNode == null)
            throw new Exception("stockTurretHpNode == null");

        return nodeToInt(hullHpNode) + nodeToInt(stockTurretHpNode);
    }

    private static int nodeToInt(XmlNode node)
    {
        return Convert.ToInt32(node.InnerText.Replace("\t", ""));
    }
}

