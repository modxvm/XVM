package scaleform.clik.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class CoreList extends scaleform.clik.core.UIComponent
    {
        public function CoreList()
        {
            super();
            return;
        }

        protected function updateSelectedIndex():void
        {
            return;
        }

        protected function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            return arg2 / 20 >> 0;
        }

        protected function drawLayout():void
        {
            return;
        }

        protected function drawRenderers(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (this._itemRenderer == null) 
            {
                trace("Renderer class not defined.");
                return;
            }
            loc1 = this._renderers.length;
            while (loc1 < this._totalRenderers) 
            {
                if ((loc3 = this.createRenderer(loc1)) == null) 
                    break;
                this._renderers.push(loc3);
                this.container.addChild(loc3 as flash.display.DisplayObject);
                ++loc1;
            }
            loc2 = this._renderers.length;
            --loc1;
            while (loc1 >= this._totalRenderers) 
            {
                if ((loc3 = this.getRendererAt(loc1)) != null) 
                {
                    this.cleanUpRenderer(loc3);
                    loc4 = loc3 as flash.display.DisplayObject;
                    if (this.container.contains(loc4)) 
                        this.container.removeChild(loc4);
                }
                this._renderers.splice(loc1, 1);
                --loc1;
            }
            return;
        }

        protected function createRenderer(arg1:uint):scaleform.clik.interfaces.IListItemRenderer
        {
            var loc1:*=new this._itemRenderer() as scaleform.clik.interfaces.IListItemRenderer;
            if (loc1 == null) 
            {
                trace("Renderer class could not be created.");
                return null;
            }
            this.setupRenderer(loc1);
            return loc1;
        }

        protected function setupRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = this;
            arg1.focusTarget = this;
            arg1.tabEnabled = false;
            arg1.doubleClickEnabled = true;
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleItemClick, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent, false, 0, true);
            if (this._usingExternalRenderers) 
                arg1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, false, 0, true);
            return;
        }

        protected override function initialize():void
        {
            this.dataProvider = new scaleform.clik.data.DataProvider();
            super.initialize();
            return;
        }

        protected function cleanUpRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = null;
            arg1.focusTarget = null;
            arg1.doubleClickEnabled = false;
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleItemClick);
            arg1.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            return;
        }

        protected function dispatchItemEvent(arg1:flash.events.Event):Boolean
        {
            var loc1:*=null;
            var loc7:*=arg1.type;
            switch (loc7) 
            {
                case scaleform.clik.events.ButtonEvent.PRESS:
                    loc1 = scaleform.clik.events.ListEvent.ITEM_PRESS;
                    break;
                case scaleform.clik.events.ButtonEvent.CLICK:
                    loc1 = scaleform.clik.events.ListEvent.ITEM_CLICK;
                    break;
                case flash.events.MouseEvent.ROLL_OVER:
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OVER;
                    break;
                case flash.events.MouseEvent.ROLL_OUT:
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OUT;
                    break;
                case flash.events.MouseEvent.DOUBLE_CLICK:
                    loc1 = scaleform.clik.events.ListEvent.ITEM_DOUBLE_CLICK;
                    break;
                default:
                    return true;
            }
            var loc2:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc3:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc3 = (arg1 as scaleform.clik.events.ButtonEvent).controllerIdx;
            else if (arg1 is scaleform.gfx.MouseEventEx) 
                loc3 = (arg1 as scaleform.gfx.MouseEventEx).mouseIdx;
            var loc4:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc4 = (arg1 as scaleform.clik.events.ButtonEvent).buttonIdx;
            else if (arg1 is scaleform.gfx.MouseEventEx) 
                loc4 = (arg1 as scaleform.gfx.MouseEventEx).buttonIdx;
            var loc5:*=false;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc5 = (arg1 as scaleform.clik.events.ButtonEvent).isKeyboard;
            var loc6:*=new scaleform.clik.events.ListEvent(loc1, false, true, loc2.index, 0, loc2.index, loc2, this.dataProvider.requestItemAt(loc2.index), loc3, loc4, loc5);
            return dispatchEvent(loc6);
        }

        protected function handleDataChange(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected function handleItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=(arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer).index;
            if (isNaN(loc1)) 
                return;
            if (this.dispatchItemEvent(arg1)) 
                this.selectedIndex = loc1;
            return;
        }

        protected function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            this.scrollList(arg1.delta > 0 ? 1 : -1);
            return;
        }

        protected function scrollList(arg1:int):void
        {
            return;
        }

        protected function setState(... rest):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (rest.length == 1) 
            {
                loc3 = rest[0].toString();
                if (!(this._state == loc3) && _labelHash[loc3]) 
                {
                    var loc5:*;
                    this._newFrame = loc5 = loc3;
                    this._state = loc5;
                    invalidateState();
                }
                return;
            }
            var loc1:*=rest.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc4 = rest[loc2].toString();
                if (_labelHash[loc4]) 
                {
                    this._newFrame = loc5 = loc4;
                    this._state = loc5;
                    invalidateState();
                    break;
                }
                ++loc2;
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

        public function get itemRendererName():String
        {
            return this._itemRendererName;
        }

        public function set itemRendererName(arg1:String):void
        {
            if (_inspector && arg1 == "" || arg1 == "") 
                return;
            var loc1:*=flash.utils.getDefinitionByName(arg1) as Class;
            if (loc1 == null) 
                trace("Error: " + this + ", The class " + arg1 + " cannot be found in your library. Please ensure it is there.");
            else 
                this.itemRenderer = loc1;
            return;
        }

        public function get itemRenderer():Class
        {
            return this._itemRenderer;
        }

        public function set itemRenderer(arg1:Class):void
        {
            this._itemRenderer = arg1;
            this.invalidateRenderers();
            return;
        }

        public function set itemRendererInstanceName(arg1:String):void
        {
            var loc3:*=null;
            if (arg1 == null || arg1 == "" || parent == null) 
                return;
            var loc1:*=0;
            var loc2:*=new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
            while (++loc1) 
            {
                if ((loc3 = parent.getChildByName(arg1 + loc1) as scaleform.clik.interfaces.IListItemRenderer) == null) 
                {
                    if (loc1 == 0) 
                        continue;
                    break;
                }
                loc2.push(loc3);
            }
            if (loc2.length == 0) 
            {
                if (componentInspectorSetting) 
                    return;
                loc2 = null;
            }
            this.itemRendererList = loc2;
            return;
        }

        public function set itemRendererList(arg1:__AS3__.vec.Vector.<scaleform.clik.interfaces.IListItemRenderer>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._usingExternalRenderers) 
            {
                loc1 = this._renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.cleanUpRenderer(this.getRendererAt(loc2));
                    ++loc2;
                }
            }
            this._usingExternalRenderers = !(arg1 == null);
            this._renderers = arg1;
            if (this._usingExternalRenderers) 
            {
                loc1 = this._renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.setupRenderer(this.getRendererAt(loc2));
                    ++loc2;
                }
                this._totalRenderers = this._renderers.length;
            }
            this.invalidateRenderers();
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            if (this._selectedIndex == arg1) 
                return;
            this._selectedIndex = arg1;
            this.invalidateSelectedIndex();
            dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.INDEX_CHANGE, true, false, this._selectedIndex, -1, -1, this.getRendererAt(this._selectedIndex), this.dataProvider.requestItemAt(this._selectedIndex)));
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            super.enabled = arg1;
            this.setState(super.enabled ? "default" : "disabled");
            if (this._renderers != null) 
            {
                loc1 = this._renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    (loc3 = this.getRendererAt(loc2)).enabled = this.enabled;
                    ++loc2;
                }
            }
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

        public function get availableWidth():Number
        {
            return _width;
        }

        public function get availableHeight():Number
        {
            return _height;
        }

        public function scrollToIndex(arg1:uint):void
        {
            return;
        }

        public function scrollToSelected():void
        {
            this.scrollToIndex(this._selectedIndex);
            return;
        }

        public function itemToLabel(arg1:Object):String
        {
            if (arg1 == null) 
                return "";
            if (this._labelFunction != null) 
                return this._labelFunction(arg1);
            if (!(this._labelField == null) && this._labelField in arg1 && !(arg1[this._labelField] == null)) 
                return arg1[this._labelField];
            return arg1.toString();
        }

        public function getRendererAt(arg1:uint, arg2:int=0):scaleform.clik.interfaces.IListItemRenderer
        {
            if (this._renderers == null) 
                return null;
            var loc1:*=arg1 - arg2;
            if (loc1 >= this._renderers.length) 
                return null;
            return this._renderers[loc1] as scaleform.clik.interfaces.IListItemRenderer;
        }

        public function invalidateRenderers():void
        {
            invalidate(scaleform.clik.constants.InvalidationType.RENDERERS);
            return;
        }

        public function invalidateSelectedIndex():void
        {
            invalidate(scaleform.clik.constants.InvalidationType.SELECTED_INDEX);
            return;
        }

        public override function toString():String
        {
            return "[CLIK CoreList " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.container == null) 
            {
                this.container = new flash.display.Sprite();
                addChild(this.container);
            }
            tabEnabled = _focusable && this.enabled;
            tabChildren = false;
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, false, 0, true);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SELECTED_INDEX)) 
                this.updateSelectedIndex();
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                if (this._newFrame) 
                {
                    gotoAndPlay(this._newFrame);
                    this._newFrame = null;
                }
            if (!this._usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS)) 
            {
                if (this._renderers != null) 
                {
                    loc2 = this._renderers.length;
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        loc3 = this.getRendererAt(loc1);
                        this.cleanUpRenderer(loc3);
                        loc4 = loc3 as flash.display.DisplayObject;
                        if (this.container.contains(loc4)) 
                            this.container.removeChild(loc4);
                        ++loc1;
                    }
                }
                this._renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
                invalidateData();
            }
            if (!this._usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                (loc5 = App.utils.events).disableDisposingForObj(this.container);
                removeChild(this.container);
                setActualSize(_width, _height);
                this.container.scaleX = 1 / scaleX;
                this.container.scaleY = 1 / scaleY;
                this._totalRenderers = this.calculateRendererTotal(this.availableWidth, this.availableHeight);
                addChild(this.container);
                loc5.enableDisposingForObj(this.container);
                invalidateData();
            }
            if (!this._usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.drawRenderers(this._totalRenderers);
                this.drawLayout();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                this.refreshData();
            return;
        }

        protected override function changeFocus():void
        {
            if (_focused || _displayFocus) 
                this.setState("focused", "default");
            else 
                this.setState("default");
            return;
        }

        protected function refreshData():void
        {
            return;
        }

        protected var _selectedIndex:int=-1;

        protected var _newSelectedIndex:int=-1;

        protected var _dataProvider:scaleform.clik.interfaces.IDataProvider;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _itemRenderer:Class;

        protected var _renderers:__AS3__.vec.Vector.<scaleform.clik.interfaces.IListItemRenderer>;

        protected var _usingExternalRenderers:Boolean=false;

        protected var _totalRenderers:uint=0;

        protected var _state:String="default";

        protected var _newFrame:String;

        public var container:flash.display.Sprite;

        protected var _itemRendererName:String="DefaultListItemRenderer";
    }
}
