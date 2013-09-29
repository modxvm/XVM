package net.wg.gui.lobby.questsWindow 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ConditionElement extends scaleform.clik.core.UIComponent
    {
        public function ConditionElement()
        {
            super();
            this._tanks = new Vector.<net.wg.gui.lobby.questsWindow.VehicleBlock>();
            return;
        }

        public override function dispose():void
        {
            if (this._tanks) 
            {
                this.clearTanks();
                this._tanks = null;
            }
            if (this._data) 
            {
                this._data.dispose();
                this._data = null;
            }
            super.dispose();
            return;
        }

        public function setData(arg1:Object):void
        {
            this._data = new net.wg.gui.lobby.questsWindow.data.ConditionElementVO(arg1);
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._data) 
            {
                this.descrTF.htmlText = this._data.descr;
                this.descrTF.height = this.descrTF.textHeight + 10;
                this.clearTanks();
                this.createTanks();
                this.layoutTanks();
            }
            return;
        }

        internal function clearTanks():void
        {
            var loc1:*=0;
            while (loc1 < this._tanks.length) 
            {
                this._tanks[loc1].dispose();
                removeChild(this._tanks[loc1]);
                ++loc1;
            }
            this._tanks.splice(0, this._tanks.length);
            return;
        }

        internal function createTanks():void
        {
            var loc3:*=null;
            var loc1:*=this._data.vehicles.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = App.utils.classFactory.getComponent("VehicleBlock_UI", net.wg.gui.lobby.questsWindow.VehicleBlock);
                this._tanks.push(loc3);
                addChild(loc3);
                loc3.setData(this._data.vehicles[loc2]);
                loc3.validateNow();
                ++loc2;
            }
            return;
        }

        internal function layoutTanks():void
        {
            var loc1:*=this._tanks.length ? this._tanks[0].height : 0;
            var loc2:*=Math.round(this.descrTF.y + this.descrTF.textHeight + TEXT_PADDING);
            var loc3:*=0;
            while (loc3 < this._tanks.length) 
            {
                this._tanks[loc3].y = loc2 + loc3 * loc1;
                this._tanks[loc3].x = PADDING;
                ++loc3;
            }
            var loc4:*=this._tanks.length * loc1;
            var loc5:*=0;
            if (loc4 > 0) 
            {
                loc5 = loc2 + loc4 + AFTER_TANKS_PADDING;
            }
            else 
            {
                loc5 = loc2 + ONLY_TEXT_PADDING;
            }
            setSize(this.width, loc5);
            return;
        }

        internal static const PADDING:int=20;

        internal static const TEXT_PADDING:int=5;

        internal static const ONLY_TEXT_PADDING:int=8;

        internal static const AFTER_TANKS_PADDING:int=17;

        public var descrTF:flash.text.TextField;

        internal var _tanks:__AS3__.vec.Vector.<net.wg.gui.lobby.questsWindow.VehicleBlock>=null;

        internal var _data:net.wg.gui.lobby.questsWindow.data.ConditionElementVO=null;
    }
}
