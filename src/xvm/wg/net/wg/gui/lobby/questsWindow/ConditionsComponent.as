package net.wg.gui.lobby.questsWindow 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ConditionsComponent extends scaleform.clik.core.UIComponent
    {
        public function ConditionsComponent()
        {
            this._data = [];
            super();
            this._blocks = new Vector.<net.wg.gui.lobby.questsWindow.ConditionsBlock>();
            return;
        }

        public override function dispose():void
        {
            if (this._blocks) 
            {
                this.clearBlocks();
                this._blocks = null;
            }
            if (this._data) 
            {
                this._data.splice(0, this._data.length);
                this._data = null;
            }
            super.dispose();
            return;
        }

        public function setData(arg1:Array):void
        {
            this._data = arg1;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._data) 
            {
                this.clearBlocks();
                this.createBlocks();
                this.layoutBlocks();
            }
            return;
        }

        internal function clearBlocks():void
        {
            var loc1:*=0;
            while (loc1 < this._blocks.length) 
            {
                this._blocks[loc1].dispose();
                removeChild(this._blocks[loc1]);
                ++loc1;
            }
            this._blocks.splice(0, this._blocks.length);
            return;
        }

        internal function createBlocks():void
        {
            var loc3:*=null;
            var loc1:*=this._data.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = App.utils.classFactory.getComponent("ConditionsBlock_UI", net.wg.gui.lobby.questsWindow.ConditionsBlock);
                this._blocks.push(loc3);
                addChild(loc3);
                loc3.setData(this._data[loc2]);
                if (loc2 == (loc1 - 1)) 
                {
                    loc3.line.visible = false;
                }
                loc3.validateNow();
                ++loc2;
            }
            return;
        }

        internal function layoutBlocks():void
        {
            var loc1:*=1;
            while (loc1 < this._blocks.length) 
            {
                this._blocks[loc1].y = this._blocks[(loc1 - 1)].y + this._blocks[(loc1 - 1)].height;
                ++loc1;
            }
            var loc2:*=this._blocks.length > 0 ? this._blocks[(this._blocks.length - 1)].height + this._blocks[(this._blocks.length - 1)].y + BOTTOM_PADDING : 0;
            this.line.y = (loc2 - 1);
            this.line.visible = this._blocks.length > 0;
            setSize(this.width, loc2);
            return;
        }

        internal static const BOTTOM_PADDING:int=5;

        internal var _data:Array;

        internal var _blocks:__AS3__.vec.Vector.<net.wg.gui.lobby.questsWindow.ConditionsBlock>=null;

        public var line:flash.display.MovieClip;
    }
}
