package scaleform.clik.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;

    public class ButtonBar extends scaleform.clik.core.UIComponent
    {
        public function ButtonBar()
        {
            super();
            return;
        }

        public function getButtonAt(arg1:int):scaleform.clik.controls.Button
        {
            if (arg1 >= 0 && arg1 < this._renderers.length)
                return this._renderers[arg1];
            return null;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc5:*=NaN;
            if (arg1.handled)
                return;
            var loc1:*=this._renderers[this._selectedIndex] as scaleform.clik.controls.Button;
            if (loc1 != null)
            {
                loc1.handleInput(arg1);
                if (arg1.handled)
                    return;
            }
            var loc2:*=arg1.details;
            var loc3:*;
            if (!(loc3 = loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD))
                return;
            var loc4:*=false;
            var loc6:*=loc2.navEquivalent;
            switch (loc6)
            {
                case scaleform.clik.constants.NavigationCode.LEFT:
                    if (this._direction == DIRECTION_HORIZONTAL)
                    {
                        loc5 = (this._selectedIndex - 1);
                        loc4 = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.RIGHT:
                    if (this._direction == DIRECTION_HORIZONTAL)
                    {
                        loc5 = this._selectedIndex + 1;
                        loc4 = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.UP:
                    if (this._direction == DIRECTION_VERTICAL)
                    {
                        loc5 = (this._selectedIndex - 1);
                        loc4 = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    if (this._direction == DIRECTION_VERTICAL)
                    {
                        loc5 = this._selectedIndex + 1;
                        loc4 = true;
                    }
                    break;
                default:
                    break;
            }
            if (loc4)
                if ((loc5 = Math.max(0, Math.min((this._dataProvider.length - 1), loc5))) != this._selectedIndex)
                {
                    this.selectedIndex = loc5;
                    arg1.handled = true;
                }
            return;
        }

        public override function toString():String
        {
            return "[CLIK ButtonBar " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            tabEnabled = _focusable && this.enabled;
            if (this._group == null)
                this._group = new scaleform.clik.controls.ButtonGroup(name + "Group", this);
            this._group.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleButtonGroupChange, false, 0, true);
            if (this.container == null)
            {
                this.container = new flash.display.MovieClip();
                addChild(this.container);
            }
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS) || isInvalid(scaleform.clik.constants.InvalidationType.DATA) || isInvalid(scaleform.clik.constants.InvalidationType.SETTINGS) || isInvalid(scaleform.clik.constants.InvalidationType.SIZE))
            {
                loc1 = App.utils.events;
                loc1.disableDisposingForObj(this.container);
                removeChild(this.container);
                setActualSize(_width, _height);
                this.container.scaleX = 1 / scaleX;
                this.container.scaleY = 1 / scaleY;
                addChild(this.container);
                loc1.enableDisposingForObj(this.container);
                this.updateRenderers();
            }
            return;
        }

        public function set autoSize(arg1:String):void
        {
            if (arg1 == this._autoSize)
                return;
            this._autoSize = arg1;
            var loc1:*=0;
            while (loc1 < this._renderers.length)
            {
                (this._renderers[loc1] as this._itemRendererClass).autoSize = this._autoSize;
                ++loc1;
            }
            this.invalidateSettings();
            return;
        }

        protected function refreshData():void
        {
            this.selectedIndex = Math.min((this._dataProvider.length - 1), this._selectedIndex);
            if (this._dataProvider)
                this._dataProvider.requestItemRange(0, (this._dataProvider.length - 1), this.populateData);
            return;
        }

        protected function updateRenderers():void
        {
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=false;
            var loc8:*=0;
            var loc9:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=-1;
            if (this._renderers[0] is this._itemRendererClass)
                while (this._renderers.length > this._dataProvider.length)
                {
                    loc5 = (this._renderers.length - 1);
                    if (this.container.contains(this._renderers[loc5]))
                        this.container.removeChild(this._renderers[loc5]);
                    this._renderers.splice(loc5--, 1);
                }
            else
            {
                while (this.container.numChildren > 0)
                    this.container.removeChildAt(0);
                this._renderers.length = 0;
            }
            var loc4:*=0;
            while (loc4 < this._dataProvider.length && loc3 == -1)
            {
                loc7 = false;
                if (loc4 < this._renderers.length)
                    loc6 = this._renderers[loc4];
                else
                {
                    loc6 = new this._itemRendererClass();
                    this.setupRenderer(loc6, loc4);
                    loc7 = true;
                }
                this.populateRendererData(loc6, loc4);
                if (this._autoSize == flash.text.TextFieldAutoSize.NONE && this._buttonWidth > 0)
                    loc6.width = this._buttonWidth;
                else if (this._autoSize != flash.text.TextFieldAutoSize.NONE)
                    loc6.autoSize = this._autoSize;
                loc6.validateNow();
                if (this._direction != DIRECTION_HORIZONTAL)
                    if (_height > loc6.height + this._spacing + loc2)
                    {
                        loc6.x = 0;
                        loc6.y = loc2;
                        loc2 = loc2 + (loc6.height + this._spacing);
                    }
                    else
                    {
                        loc3 = loc4;
                        loc6 = null;
                    }
                else if (_width > loc6.width + this._spacing + loc1)
                {
                    loc6.y = 0;
                    loc6.x = loc1;
                    loc1 = loc1 + (loc6.width + this._spacing);
                }
                else
                {
                    loc3 = loc4;
                    loc6 = null;
                }
                if (loc7 && !(loc6 == null))
                {
                    loc6.group = this._group;
                    this.container.addChild(loc6);
                    this._renderers.push(loc6);
                }
                ++loc4;
            }
            if (loc3 > -1)
            {
                loc8 = (this._renderers.length - 1);
                while (loc8 >= loc3)
                {
                    loc9 = this._renderers[loc8];
                    if (loc9)
                    {
                        if (this.container.contains(loc9))
                            this.container.removeChild(loc9);
                        this._renderers.splice(loc8, 1);
                    }
                    --loc8;
                }
            }
            this.selectedIndex = Math.min((this._dataProvider.length - 1), this._selectedIndex);
            return;
        }

        protected function populateData(arg1:Array):void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < this._renderers.length)
            {
                loc2 = this._renderers[loc1] as scaleform.clik.controls.Button;
                this.populateRendererData(loc2, loc1);
                loc2.validateNow();
                ++loc1;
            }
            return;
        }

        protected function setupRenderer(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            arg1.owner = this;
            arg1.focusable = false;
            arg1.focusTarget = this;
            arg1.toggle = true;
            arg1.allowDeselect = false;
            return;
        }

        protected function handleButtonGroupChange(arg1:flash.events.Event):void
        {
            if (this._group.selectedIndex != this.selectedIndex)
            {
                this.selectedIndex = this._group.selectedIndex;
                dispatchEvent(new scaleform.clik.events.ButtonBarEvent(scaleform.clik.events.ButtonBarEvent.BUTTON_SELECT, false, true, this._selectedIndex, arg1.target as scaleform.clik.controls.Button));
            }
            return;
        }

        protected function handleDataChange(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function changeFocus():void
        {
            var loc1:*=this._renderers[this._selectedIndex] as scaleform.clik.controls.Button;
            if (loc1 == null)
                return;
            loc1.displayFocus = _focused > 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.dataProvider = new scaleform.clik.data.DataProvider();
            this._renderers = [];
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (this.enabled == arg1)
                return;
            super.enabled = arg1;
            var loc1:*=0;
            while (loc1 < this._renderers.length)
            {
                if (this._itemRendererClass)
                    (this._renderers[loc1] as this._itemRendererClass).enabled = arg1;
                else
                    (this._renderers[loc1] as scaleform.clik.core.UIComponent).enabled = arg1;
                ++loc1;
            }
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            super.focusable = arg1;
            return;
        }

        public function get dataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (this._dataProvider == arg1)
                return;
            if (this._dataProvider != null)
                this._dataProvider.removeEventListener(flash.events.Event.CHANGE, this.handleDataChange, false);
            this._dataProvider = arg1;
            if (this._dataProvider == null)
                return;
            this._dataProvider.addEventListener(flash.events.Event.CHANGE, this.handleDataChange, false, 0, true);
            invalidateData();
            return;
        }

        public function set itemRendererName(arg1:String):void
        {
            var value:String;
            var classRef:Class;

            var loc1:*;
            classRef = null;
            value = arg1;
            if (_inspector && value == "Button" || value == "")
                return;
            try
            {
                classRef = flash.utils.getDefinitionByName(value) as Class;
            }
            catch (error:*)
            {
                throw new Error("The class " + value + " cannot be found in your library. Please ensure it exists.");
            }
            if (classRef != null)
            {
                this._itemRendererClass = classRef;
                invalidate();
            }
            return;
        }

        public function get spacing():Number
        {
            return this._spacing;
        }

        public function set spacing(arg1:Number):void
        {
            this._spacing = arg1;
            this.invalidateSettings();
            return;
        }

        public function get direction():String
        {
            return this._direction;
        }

        public function set direction(arg1:String):void
        {
            this._direction = arg1;
            this.invalidateSettings();
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        protected function populateRendererData(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            arg1.label = this.itemToLabel(this._dataProvider.requestItemAt(arg2));
            arg1.data = this._dataProvider.requestItemAt(arg2);
            arg1.selected = arg2 == this.selectedIndex;
            return;
        }

        public function get buttonWidth():Number
        {
            return this._buttonWidth;
        }

        public function set buttonWidth(arg1:Number):void
        {
            this._buttonWidth = arg1;
            invalidate();
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            if (arg1 == this._selectedIndex)
                return;
            var loc1:*=this._selectedIndex;
            var loc2:*=this._renderers[loc1] as scaleform.clik.controls.Button;
            if (loc2)
                loc2.selected = false;
            this._selectedIndex = arg1;
            loc2 = this._renderers[this._selectedIndex] as scaleform.clik.controls.Button;
            if (loc2)
                loc2.selected = true;
            dispatchEvent(new scaleform.clik.events.IndexEvent(scaleform.clik.events.IndexEvent.INDEX_CHANGE, true, true, this._selectedIndex, loc1, this._dataProvider[this._selectedIndex]));
            return;
        }

        public function get selectedItem():Object
        {
            return this._dataProvider.requestItemAt(this._selectedIndex);
        }

        public function get data():Object
        {
            return this.selectedItem.data;
        }

        public function get labelField():String
        {
            return this._labelField;
        }

        public function set labelField(arg1:String):void
        {
            this._labelField = arg1;
            invalidateData();
            return;
        }

        public function get labelFunction():Function
        {
            return this._labelFunction;
        }

        public function set labelFunction(arg1:Function):void
        {
            this._labelFunction = arg1;
            invalidateData();
            return;
        }

        public function invalidateSettings():void
        {
            invalidate(scaleform.clik.constants.InvalidationType.SETTINGS);
            return;
        }

        public function itemToLabel(arg1:Object):String
        {
            if (arg1 == null)
                return "";
            if (this._labelFunction != null)
                return this._labelFunction(arg1);
            if (arg1 is String)
                return arg1 as String;
            if (!(this._labelField == null) && !(arg1[this._labelField] == null))
                return arg1[this._labelField];
            return arg1.toString();
        }

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        protected var _autoSize:String="none";

        protected var _buttonWidth:Number=0;

        protected var _dataProvider:scaleform.clik.interfaces.IDataProvider;

        protected var _direction:String="horizontal";

        protected var _group:scaleform.clik.controls.ButtonGroup;

        protected var _itemRendererClass:Class;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _renderers:Array;

        protected var _spacing:Number=0;

        protected var _selectedIndex:Number=-1;

        public var container:flash.display.MovieClip;

        protected var _itemRenderer:String="Button";
    }
}
