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

    public Boolean turretUnlocksSomeGun()
    {
        return getSecondTurretUnlockNode() != null;
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

        XmlNode unlocks = null;
        foreach (XmlNode node in firstChassis)
        {
            if (node.Name == "unlocks")
                unlocks = node; // <chassis>A-20_mod_1941<cost>\t840\t</cost></chassis>
        }
        if (unlocks == null)
            throw new Exception("Error: no unlocks at chassis");
        
        return getCostFromUnlockNode(unlocks);
    }

    public int getUnlockedGunCost()
    {
        return getCostFromUnlockNode(getSecondTurretUnlockNode());
    }

    // -- Private

    private XmlNode getSecondTurretUnlockNode()
    {
        XmlNodeList secondTurretNodes = turretsNode.LastChild.ChildNodes;
        foreach (XmlNode node in secondTurretNodes)
        {
            if (node.Name == "unlocks")
                return node;
        }
        return null;
    }

    private int getCostFromUnlockNode(XmlNode unlocks)
    {
        XmlNode cost = unlocks.ChildNodes.Item(1).ChildNodes.Item(1);
        return nodeToInt(cost);
    }

    private int nodeToInt(XmlNode node)
    {
        if (node == null || node.InnerXml == "")
            throw new Exception("Error: empty cost node");
        String str = node.InnerText.Replace("\t", "");
        string[] strArr = str.Split('.'); // 450.0 -> [450, 0]
        return Convert.ToInt32(strArr[0]);
    }
}

