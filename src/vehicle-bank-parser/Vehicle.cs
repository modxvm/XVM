using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

class Vehicle
{
   /**
    * Can not define rootNode modules vulnerability status.
    */
    public const short ONLY_ONE_TURRET = 0;

   /**
    * Top turret does not unlock new gun.
    * Player with stock turret can mount top gun.
    * Low vulnerability.
    */
    public const short TOP_TURRET_SINGLE = 1;

   /**
    * Top turret unlocks new gun.
    * Player with stock turret can not mount top gun.
    * High vulnerability.
    */
    public const short TOP_TURRET_UNLOCKS_TOP_GUN = 2;

    public string name;
    public int hpstock;
    public short status;

    public Vehicle(string name, int hpstock, short status)
    {
        this.name = name;
        this.hpstock = hpstock;
        this.status = status;
    }
}

