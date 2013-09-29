package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class AchievmentsCustomBlock extends scaleform.clik.core.UIComponent
    {
        public function AchievmentsCustomBlock()
        {
            super();
            this.items = new Vector.<net.wg.gui.components.tooltips.AchievmentsCustomBlockItem>();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=null;
            super.draw();
            if (this.dataDirty) 
            {
                this.levelName.htmlText = this._level;
                loc1 = this._data.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = App.utils.classFactory.getComponent("AchievmentsCustomBlockItem", net.wg.gui.components.tooltips.AchievmentsCustomBlockItem);
                    this.addChild(loc3);
                    loc3.x = 72;
                    loc3.y = loc2 * 23 + this.Y_OFFSET;
                    loc3.setData(this._data[loc2]);
                    this.items.push(loc3);
                    ++loc2;
                }
                this.dataDirty = false;
            }
            return;
        }

        public function setData(arg1:String, arg2:Array):void
        {
            this._level = arg1;
            this._data = arg2;
            this.dataDirty = true;
            validateNow();
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            if (this.items) 
            {
                while (this.items.length > 0) 
                {
                    loc1 = this.items.pop();
                    this.removeChild(loc1);
                    loc1 = null;
                }
            }
            return;
        }

        internal var _data:Array=null;

        internal var _level:String=null;

        public var levelName:flash.text.TextField;

        internal var Y_OFFSET:Number=1;

        internal var dataDirty:Boolean=false;

        internal var items:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.AchievmentsCustomBlockItem>=null;
    }
}
