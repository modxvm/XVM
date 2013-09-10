package net.wg.gui.components.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.utils.*;
    
    public class ContextMenuItem extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function ContextMenuItem()
        {
            this.subItems = new Array();
            super();
            soundType = net.wg.data.constants.SoundTypes.CONTEXT_MENU;
            useRightButton = false;
            this._items = new Vector.<net.wg.infrastructure.interfaces.IContextItem>();
            return;
        }

        protected override function configUI():void
        {
            if (!constraintsDisabled && this.textFieldSub) 
                constraints.addElement("textFieldSub", this.textFieldSub, scaleform.clik.utils.Constraints.ALL);
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            var loc1:*=this.type;
            switch (loc1) 
            {
                case this.CONTEXT_MENU_ITEM_MAIN:
                    this.arrowMc.visible = false;
                    this.circleMc.visible = false;
                    textField.visible = true;
                    this.textFieldSub.visible = false;
                    break;
                case this.CONTEXT_MENU_ITEM_GROUP:
                    this.arrowMc.visible = true;
                    this.circleMc.visible = false;
                    textField.visible = true;
                    this.textFieldSub.visible = false;
                    break;
                case this.CONTEXT_MENU_ITEM_SUB:
                    this.arrowMc.visible = false;
                    this.circleMc.visible = true;
                    textField.visible = false;
                    this.textFieldSub.visible = true;
                    break;
            }
            return;
        }

        public function set type(arg1:String):void
        {
            if (arg1 == this._type) 
                return;
            this._type = arg1;
            if (enabled) 
                setState("up");
            invalidateState();
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set items(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>):void
        {
            if (!this._items) 
                this._items = new Vector.<net.wg.infrastructure.interfaces.IContextItem>();
            if (arg1 == this._items) 
                return;
            this._items = arg1;
            if (this._items.length > 0) 
                this.type = this.CONTEXT_MENU_ITEM_GROUP;
            else 
                this.type = this.CONTEXT_MENU_ITEM_MAIN;
            return;
        }

        public function get items():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            return this._items;
        }

        public function set isOpened(arg1:Boolean):void
        {
            if (arg1 == this._isOpened) 
                return;
            this._isOpened = arg1;
            if (this.arrowMc.visible) 
                this.arrowMc.gotoAndStop(this._isOpened ? "down" : "up");
            return;
        }

        public function get isOpened():Boolean
        {
            return this._isOpened;
        }

        public override function dispose():void
        {
            return;
        }

        protected override function updateText():void
        {
            super.updateText();
            if (!(_label == null) && !(this.textFieldSub == null)) 
                this.textFieldSub.text = _label;
            return;
        }

        protected override function updateAfterStateChange():void
        {
            if (!initialized) 
                return;
            super.updateAfterStateChange();
            if (!(constraints == null) && !constraintsDisabled && !(this.textFieldSub == null)) 
                constraints.updateElement("textFieldSub", this.textFieldSub);
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            var loc1:*=this.type != this.CONTEXT_MENU_ITEM_SUB ? "" : this.CONTEXT_MENU_ITEM_SUB + "_";
            return _selected ? Vector.<String>([loc1 + "selected_", ""]) : Vector.<String>([loc1]);
        }

        public override function toString():String
        {
            return "[WG ContextMenuItem " + name + "]";
        }

        public const CONTEXT_MENU_ITEM_MAIN:String="main";

        public const CONTEXT_MENU_ITEM_SUB:String="sub";

        public const CONTEXT_MENU_ITEM_GROUP:String="group";

        public var id:String="";

        internal var _type:String="";

        internal var _items:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>;

        public var subItems:Array;

        public var _isOpened:Boolean=false;

        public var arrowMc:flash.display.MovieClip;

        public var circleMc:flash.display.MovieClip;

        public var textFieldSub:flash.text.TextField;
    }
}
