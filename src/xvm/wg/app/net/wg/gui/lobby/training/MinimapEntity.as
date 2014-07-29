package net.wg.gui.lobby.training
{
    import net.wg.infrastructure.base.meta.impl.MinimapEntityMeta;
    import net.wg.infrastructure.base.meta.IMinimapEntityMeta;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IMinimapEntry;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    
    public class MinimapEntity extends MinimapEntityMeta implements IMinimapEntityMeta
    {
        
        public function MinimapEntity()
        {
            super();
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
        }
        
        public var icons:MovieClip;
        
        public var iconsMask:MovieClip;
        
        public function as_updatePoints() : void
        {
            var _loc1_:int = this.icons.numChildren;
            var _loc2_:IMinimapEntry = null;
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = this.icons.getChildAt(_loc3_) as IMinimapEntry;
                if(_loc2_)
                {
                    if(_loc2_.isTeamPoint())
                    {
                        _loc2_.update(null);
                    }
                }
                _loc3_++;
            }
        }
        
        override protected function onDispose() : void
        {
            App.utils.commons.releaseReferences(this.icons);
            this.icons = null;
            this.iconsMask = null;
            super.onDispose();
        }
    }
}
