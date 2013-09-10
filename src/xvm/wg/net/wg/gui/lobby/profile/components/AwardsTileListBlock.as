package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class AwardsTileListBlock extends scaleform.clik.core.UIComponent
    {
        public function AwardsTileListBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(flash.events.Event.RESIZE, this.tileResizeHandler, false, 0, true);
            this.tileList.direction = scaleform.clik.constants.DirectionMode.VERTICAL;
            this.tileList.columnCount = 12;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(DATA_PROVIDER_INV)) 
            {
                this.applyDataChanges();
            }
            if (isInvalid(LABEL_INV)) 
            {
                this.applyLabel();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.applySizeChanges();
            }
            return;
        }

        protected function applyLabel():void
        {
            this.textField.text = this._labelText;
            return;
        }

        protected function applySizeChanges():void
        {
            _height = this.tileList.y + this.tileList.height;
            return;
        }

        protected function applyDataChanges():void
        {
            this.tileList.dataProvider = new scaleform.clik.data.DataProvider(this._dataProvider);
            invalidate(LABEL_INV);
            return;
        }

        internal function tileResizeHandler(arg1:flash.events.Event):void
        {
            this.applySizeChanges();
            return;
        }

        public function set labelText(arg1:String):void
        {
            this._labelText = arg1;
            invalidate(LABEL_INV);
            return;
        }

        public function get dataProvider():Array
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:Array):void
        {
            this._dataProvider = arg1;
            invalidate(DATA_PROVIDER_INV);
            return;
        }

        public override function dispose():void
        {
            if (this.tileList) 
            {
                this.tileList.dispose();
                this.tileList = null;
            }
            if (this.dataProvider) 
            {
                this.dataProvider = null;
            }
            super.dispose();
            return;
        }

        public function get labelText():String
        {
            return this._labelText;
        }

        protected static const DATA_PROVIDER_INV:String="dpInv";

        protected static const LABEL_INV:String="lblInv";

        public var textField:flash.text.TextField;

        internal var _labelText:String="";

        public var tileList:net.wg.gui.lobby.profile.components.ResizableTileList;

        protected var _dataProvider:Array;
    }
}
