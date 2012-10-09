using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

class VehicleXmlParser
{
    /**
     * Parses vehicles XML node.
     * Gets turret possibilities, max HP, tank name.
     * Author: ilitvinov87@gmail.com
     */

    private XmlNode rootNode;
    private XmlNode turretsNode;

    public VehicleXmlParser(XmlNode rootNode)
    {
        turretsNode = rootNode.SelectSingleNode("//turrets0");

        if (turretsNode == null)
            throw new Exception("Error: not a vehicles XML file.");
        this.rootNode = rootNode;
    }

    public Boolean hasOnlyOneTurret()
    {
        /**
         * FirstChild is empty - "".
         * 2 turrets - 3 children.
         * 1 turret - 2 children.
         */
        return turretsNode.ChildNodes.Count == 2;
    }

    public Boolean turretUnlocksSomething()
    {
        return getSecondTurretUnlocks() != null;
    }

    public string getVehicleName()
    {
        // from  <a-20.xml><crew>...
        // to    a-20
        return rootNode.Name.ToString().Replace(".xml", "");
    }

    public int getHpStock()
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
        XmlNode stockTurretNode = turretsNode.FirstChild.NextSibling;
        XmlNodeList stockTurretNodes = stockTurretNode.ChildNodes;
        XmlNode stockTurretHpNode = null;
        foreach (XmlNode node in stockTurretNodes)
            if (node.Name == "maxHealth")
            {
                stockTurretHpNode = node;
                break;
            }

        if (stockTurretHpNode == null)
            throw new Exception("stockTurretHpNode == null");

        return nodeToInt(hullHpNode) + nodeToInt(stockTurretHpNode);
    }

    public int getChassisCost()
    {
        XmlNodeList firstChassis = rootNode.SelectSingleNode("//chassis").ChildNodes.Item(1).ChildNodes;

        XmlNode secondChassis = null;
        foreach (XmlNode node in firstChassis)
        {
            if (node.Name == "unlocks")
                secondChassis = node.ChildNodes.Item(1); // <chassis>A-20_mod_1941<cost>\t840\t</cost></chassis>
        }
        
        if (secondChassis == null)
            throw new Exception("Error: no secondChassis at chassis");

        return getCostFromNode(secondChassis);
    }

    public XmlNodeList getSecondTurretUnlocks()
    {
        XmlNodeList secondTurretNodes = turretsNode.LastChild.ChildNodes;
        foreach (XmlNode node in secondTurretNodes)
        {
            if (node.Name == "unlocks")
                return node.ChildNodes;
        }
        return null;
    }

    public List<XmlNode> separateGuns(XmlNodeList unlocks)
    {
        List<XmlNode> guns = new List<XmlNode>();
        for (int i = 1; i < unlocks.Count; i++)  // 1st item is empty
        {
            if (unlocks.Item(i).InnerText.Contains("mm_")) // _75mm_
                guns.Add(unlocks.Item(i));
        }

        return guns;
    }

    public int mostExpensive(List<XmlNode> guns)
    {
        int maxCostValue = 0;
        foreach (XmlNode gun in guns)
            if (maxCostValue < getCostFromNode(gun))
                maxCostValue = getCostFromNode(gun);

        return maxCostValue;
    }

    // -- Private

    private int getCostFromNode(XmlNode node)
    {
        XmlNode cost = node.ChildNodes.Item(1);
        return nodeToInt(cost);
    }

    private int nodeToInt(XmlNode node)
    {
        if (node == null || node.InnerText == "")
            throw new Exception("Error: no node");

        String str = node.InnerText.Replace("\t", "");
        string[] strArr = str.Split('.'); // 450.0 -> [450, 0]
        return Convert.ToInt32(strArr[0]);
    }
}

