package net.wg.gui.lobby.training 
{
    import flash.display.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.utils.*;
    
    public class MinimapEntity extends net.wg.infrastructure.base.meta.impl.MinimapEntityMeta implements net.wg.infrastructure.base.meta.IMinimapEntityMeta
    {
        public function MinimapEntity()
        {
            super();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            return;
        }

        public function as_updatePoints():void
        {
            var loc1:*=this.icons.numChildren;
            var loc2:*=null;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc2 = this.icons.getChildAt(loc3) as net.wg.infrastructure.interfaces.IMinimapEntry;
                if (loc2) 
                {
                    if (loc2.isTeamPoint()) 
                    {
                        loc2.update(null);
                    }
                }
                ++loc3;
            }
            return;
        }

        protected override function onDispose():void
        {
            App.utils.commons.releaseReferences(this.icons);
            this.icons = null;
            this.iconsMask = null;
            super.onDispose();
            return;
        }

        public var icons:flash.display.MovieClip;

        public var iconsMask:flash.display.MovieClip;
    }
}
