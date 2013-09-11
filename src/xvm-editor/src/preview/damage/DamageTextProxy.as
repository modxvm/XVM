package preview.damage
{

import flash.display.MovieClip;

import mx.core.UIComponent;

import preview.*;
import preview.damage.*;

public class DamageTextProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function DamageTextProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

    public function createHolder():UIComponent
    {
        var damageHolder:UIComponent = new UIComponent();
        damageHolder.includeInLayout = false;
        addChild(damageHolder);
        return damageHolder;
    }

    public function get entityName():String
    {
        return xvm.m_entityName;
    }

    //   dst: ally, squadman, allytk, enemytk, enemy
    public function get damageDest():String
    {
        return xvm.m_entityName == 'teamKiller' ? (xvm.m_entityType + "tk") : xvm.m_entityName;
    }

    public function get isBlowedUp():Boolean
    {
        return xvm.isBlowedUp;
    }
}

}
