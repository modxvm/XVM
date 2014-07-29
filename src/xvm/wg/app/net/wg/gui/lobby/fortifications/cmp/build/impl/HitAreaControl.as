package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import flash.geom.Point;
    
    public class HitAreaControl extends SoundButtonEx
    {
        
        public function HitAreaControl()
        {
            super();
            hitArea = this.generalBuildingsHit;
        }
        
        public var generalBuildingsHit:MovieClip;
        
        public var trowelHit:MovieClip;
        
        public function setData(param1:String, param2:Number, param3:Boolean) : void
        {
            var _loc4_:* = param2 == FORTIFICATION_ALIASES.STATE_TROWEL;
            var _loc5_:Boolean = param2 == FORTIFICATION_ALIASES.STATE_FOUNDATION || param2 == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF;
            enabled = true;
            if((_loc4_) && !param3)
            {
                enabled = false;
                this.generalBuildingsHit.visible = false;
            }
            else
            {
                this.generalBuildingsHit.visible = !_loc4_;
                if(this.generalBuildingsHit.visible)
                {
                    this.generalBuildingsHit.gotoAndStop(_loc5_?FORTIFICATION_ALIASES.FORT_FOUNDATION:param1);
                }
            }
            this.trowelHit.visible = (_loc4_) && (param3);
            if(this.trowelHit.visible)
            {
                hitArea = this.trowelHit;
            }
            else if(this.generalBuildingsHit.visible)
            {
                hitArea = this.generalBuildingsHit;
            }
            
        }
        
        public function get absPosition() : Point
        {
            return localToGlobal(new Point(0,0));
        }
        
        override protected function onDispose() : void
        {
            this.generalBuildingsHit = null;
            this.trowelHit = null;
            super.onDispose();
        }
    }
}
