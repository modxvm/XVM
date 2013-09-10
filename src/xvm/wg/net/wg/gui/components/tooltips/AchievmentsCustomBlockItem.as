package net.wg.gui.components.tooltips 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class AchievmentsCustomBlockItem extends scaleform.clik.core.UIComponent
    {
        public function AchievmentsCustomBlockItem()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (this.dataDirty) 
            {
                if (this._name) 
                    this.vehicleName.text = this._name;
                if (!isNaN(this._nation)) 
                {
                    loc1 = "../maps/icons/filters/nations/" + App.utils.getNationNamesS()[this._nation] + ".png";
                    this.nationIco.source = loc1;
                }
                if (this._type) 
                    this.vehicleType.source = "../maps/icons/filters/tanks/" + this._type + ".png";
                this.dataDirty = false;
            }
            return;
        }

        public function setData(arg1:Object):void
        {
            this._data = arg1;
            this._nation = this._data.nation;
            this._name = this._data.name;
            this._type = this._data.type;
            this.dataDirty = true;
            validateNow();
            return;
        }

        public override function toString():String
        {
            return "[WG AchievmentsCustomBlockItem " + name + "]";
        }

        internal var _data:Object=null;

        public var nationIco:net.wg.gui.components.controls.UILoaderAlt;

        public var vehicleType:net.wg.gui.components.controls.UILoaderAlt;

        public var vehicleName:flash.text.TextField;

        internal var dataDirty:Boolean=false;

        internal var _nation:Number=NaN;

        internal var _name:String=null;

        internal var _type:String=null;
    }
}
