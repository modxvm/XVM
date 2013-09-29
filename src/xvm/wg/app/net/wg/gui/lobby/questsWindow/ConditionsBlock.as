package net.wg.gui.lobby.questsWindow 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ConditionsBlock extends scaleform.clik.core.UIComponent
    {
        public function ConditionsBlock()
        {
            super();
            this._elements = new Vector.<net.wg.gui.lobby.questsWindow.ConditionElement>();
            return;
        }

        public override function dispose():void
        {
            if (this._elements) 
            {
                this.clearElements();
                this._elements = null;
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
            this._data = new net.wg.gui.lobby.questsWindow.data.ConditionsVO(arg1);
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._data) 
            {
                this.titleTF.text = this._data.title;
                this.clearElements();
                this.createElements();
                this.layoutElements();
            }
            return;
        }

        internal function clearElements():void
        {
            var loc1:*=0;
            while (loc1 < this._elements.length) 
            {
                this._elements[loc1].dispose();
                removeChild(this._elements[loc1]);
                ++loc1;
            }
            this._elements.splice(0, this._elements.length);
            return;
        }

        internal function createElements():void
        {
            var loc3:*=null;
            var loc1:*=this._data.elements.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = App.utils.classFactory.getComponent("ConditionElement_UI", net.wg.gui.lobby.questsWindow.ConditionElement);
                this._elements.push(loc3);
                addChild(loc3);
                loc3.setData(this._data.elements[loc2]);
                loc3.validateNow();
                ++loc2;
            }
            return;
        }

        internal function layoutElements():void
        {
            var loc1:*=Math.round(this._data.title ? this.titleTF.y + this.titleTF.textHeight + 4 : PADDING);
            var loc2:*=0;
            while (loc2 < this._elements.length) 
            {
                if (loc2 != 0) 
                {
                    this._elements[loc2].y = this._elements[(loc2 - 1)].y + this._elements[(loc2 - 1)].height;
                }
                else 
                {
                    this._elements[loc2].y = loc1;
                }
                ++loc2;
            }
            if (this._elements.length > 0) 
            {
                this.line.y = Math.round(this._elements[(this._elements.length - 1)].y + this._elements[(this._elements.length - 1)].height);
            }
            else 
            {
                this.line.y = loc1 + PADDING;
            }
            var loc3:*=Math.round(this.line.y + this.line.height);
            setSize(this.width, loc3);
            return;
        }

        internal static const PADDING:int=20;

        public var titleTF:flash.text.TextField;

        internal var _data:net.wg.gui.lobby.questsWindow.data.ConditionsVO=null;

        internal var _elements:__AS3__.vec.Vector.<net.wg.gui.lobby.questsWindow.ConditionElement>=null;

        public var line:flash.display.MovieClip;
    }
}
