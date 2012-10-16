package preview.damage
{

import flash.display.MovieClip;
import preview.*;
import preview.damage.*;

public class DamageTextProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function DamageTextProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function createHolder():MovieClip
    {
        return xvm.proxy.createEmptyMovieClip("xvm_damageHolder", xvm.proxy.getNextHighestDepth());
    }

    public function get entityName():String
    {
        return xvm.m_entityName;
    }

    //   dst: ally, squadman, allytk, enemytk, enemy
    public function get damageDest():String
    {
        return xvm.m_entityName == 'teamKiller' ? (xvm.proxy.m_team + "tk") : xvm.m_entityName;
    }

    public function get isDead():Boolean
    {
        return xvm.m_isDead;
    }

    public function get isBlowedUp():Boolean
    {
        return xvm.isBlowedUp;
    }

    public function get isColorBlindMode():Boolean
    {
        return ColorsManager.isColorBlindMode;
    }
}

}
