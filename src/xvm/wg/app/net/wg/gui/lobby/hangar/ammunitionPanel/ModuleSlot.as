package net.wg.gui.lobby.hangar.ammunitionPanel 
{
    import flash.display.*;
    
    public class ModuleSlot extends net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot
    {
        public function ModuleSlot()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.icon) 
            {
                var loc1:*;
                this.icon.mouseChildren = loc1 = false;
                this.icon.mouseEnabled = loc1;
            }
            return;
        }

        public function get slotType():int
        {
            return this._slotType;
        }

        public function set slotType(arg1:int):void
        {
            this._slotType = arg1;
            if (this._slotType > 1) 
            {
                this.icon.gotoAndStop(this.slotType);
            }
            return;
        }

        public function get level():int
        {
            return this._level;
        }

        public function set level(arg1:int):void
        {
            this._level = arg1;
            if (this.level > 0 && levelMC) 
            {
                levelMC.visible = true;
                levelMC.gotoAndStop(this.level);
            }
            else if (levelMC) 
            {
                levelMC.visible = false;
            }
            return;
        }

        protected override function applyIconData(arg1:*):void
        {
            super.applyIconData(arg1);
            if (arg1) 
            {
                this.level = arg1.icon;
            }
            else 
            {
                this.level = 0;
            }
            return;
        }

        internal var _level:int=0;

        internal var _slotType:int=0;

        public var icon:flash.display.MovieClip;
    }
}
