package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import scaleform.clik.constants.*;
    
    public class TypeAndLevelField extends net.wg.gui.lobby.techtree.controls.NodeComponent
    {
        public function TypeAndLevelField()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            var loc1:*;
            mouseChildren = loc1 = false;
            mouseEnabled = loc1;
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            if (!(_owner == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc1 = _owner.getItemType();
                this.visible = loc1.length > 0;
                loc2 = _owner.isElite() ? "elite_" + loc1 : loc1;
                if (!(currentFrameLabel == loc2) && _labelHash[loc2]) 
                    gotoAndStop(loc2);
                loc3 = _owner.getLevel();
                if (!(this.levelIcon == null) && !(this.levelIcon.currentFrame == loc3)) 
                {
                    this.levelIcon.visible = loc3 > -1;
                    if (loc3 > -1 && !(this.levelIcon.currentFrame == loc3)) 
                        this.levelIcon.gotoAndStop(loc3);
                }
            }
            super.draw();
            return;
        }

        public var levelIcon:flash.display.MovieClip;
    }
}
