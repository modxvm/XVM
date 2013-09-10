package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.events.*;
    
    public class ButtonGroup extends flash.events.EventDispatcher implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function ButtonGroup(arg1:String, arg2:flash.display.DisplayObjectContainer)
        {
            super();
            this.name = arg1;
            this.weakScope = new flash.utils.Dictionary(true);
            this.weakScope[arg2] = null;
            this._children = [];
            return;
        }

        public function get length():uint
        {
            return this._children.length;
        }

        public function get data():Object
        {
            return this.selectedButton.data;
        }

        public function get selectedIndex():int
        {
            return this._children.indexOf(this.selectedButton);
        }

        public function get scope():flash.display.DisplayObjectContainer
        {
            var loc2:*=null;
            var loc1:*=null;
            var loc3:*=0;
            var loc4:*=this.scope;
            for (loc2 in loc4) 
            {
                loc1 = loc2 as flash.display.DisplayObjectContainer;
                break;
            }
            return loc1;
        }

        public function addButton(arg1:scaleform.clik.controls.Button):void
        {
            this.removeButton(arg1);
            this._children.push(arg1);
            if (arg1.selected) 
                this.updateSelectedButton(arg1, true);
            arg1.addEventListener(flash.events.Event.SELECT, this.handleSelect, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClick, false, 0, true);
            arg1.addEventListener(flash.events.Event.REMOVED, this.handleRemoved, false, 0, true);
            return;
        }

        public function removeButton(arg1:scaleform.clik.controls.Button):void
        {
            var loc1:*=this._children.indexOf(arg1);
            if (loc1 == -1) 
                return;
            this._children.splice(loc1, 1);
            arg1.removeEventListener(flash.events.Event.SELECT, this.handleSelect, false);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClick, false);
            arg1.removeEventListener(flash.events.Event.REMOVED, this.handleRemoved, false);
            return;
        }

        public function getButtonAt(arg1:int):scaleform.clik.controls.Button
        {
            return this._children[arg1] as scaleform.clik.controls.Button;
        }

        public function setSelectedButtonByIndex(arg1:uint, arg2:Boolean=true):Boolean
        {
            var loc1:*=false;
            var loc2:*;
            if ((loc2 = this._children[arg1] as scaleform.clik.controls.Button) != null) 
            {
                loc2.selected = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function clearSelectedButton():void
        {
            this.updateSelectedButton(null);
            return;
        }

        public function hasButton(arg1:scaleform.clik.controls.Button):Boolean
        {
            return this._children.indexOf(arg1) > -1;
        }

        public override function toString():String
        {
            return "[CLIK ButtonGroup " + this.name + " (" + this._children.length + ")]";
        }

        protected function handleSelect(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target as scaleform.clik.controls.Button;
            if (loc1.selected) 
                this.updateSelectedButton(loc1, true);
            else 
                this.updateSelectedButton(loc1, false);
            return;
        }

        protected function updateSelectedButton(arg1:scaleform.clik.controls.Button, arg2:Boolean=true):void
        {
            if (arg2 && arg1 == this.selectedButton) 
                return;
            var loc1:*=!arg2 && arg1 == this.selectedButton && arg1.allowDeselect;
            var loc2:*=this.selectedButton;
            if (arg2) 
                this.selectedButton = arg1;
            if (arg2 && !(loc2 == null)) 
                loc2.selected = false;
            if (loc1) 
                this.selectedButton = null;
            else if (!arg2) 
                return;
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        protected function handleClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(arg1);
            return;
        }

        protected function handleRemoved(arg1:flash.events.Event):void
        {
            this.removeButton(arg1.target as scaleform.clik.controls.Button);
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._children;
            for each (loc1 in loc3) 
            {
                loc1.removeEventListener(flash.events.Event.SELECT, this.handleSelect, false);
                loc1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClick, false);
                loc1.removeEventListener(flash.events.Event.REMOVED, this.handleRemoved, false);
            }
            if (this._children) 
            {
                this._children.splice(0, this._children.length);
                this._children = null;
            }
            return;
        }

        public static function getGroup(arg1:String, arg2:flash.display.DisplayObjectContainer):scaleform.clik.controls.ButtonGroup
        {
            var loc1:*=groups[arg2];
            if (loc1 == null) 
            {
                var loc3:*;
                groups[arg2] = loc3 = new Object();
                loc1 = loc3;
            }
            var loc2:*;
            if ((loc2 = loc1[arg1.toLowerCase()]) == null) 
            {
                loc1[arg1.toLowerCase()] = loc3 = new ButtonGroup(arg1, arg2);
                loc2 = loc3;
            }
            return loc2;
        }

        
        {
            groups = new flash.utils.Dictionary(true);
        }

        public var name:String;

        protected var weakScope:flash.utils.Dictionary;

        public var selectedButton:scaleform.clik.controls.Button;

        protected var _children:Array;

        public static var groups:flash.utils.Dictionary;
    }
}
