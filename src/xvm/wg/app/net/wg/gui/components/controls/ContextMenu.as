package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import scaleform.clik.utils.Padding;
    import net.wg.infrastructure.interfaces.IContextItem;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.utils.ExcludeTweenManager;
    import net.wg.utils.IClassFactory;
    import net.wg.data.constants.ContextMenuConstants;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.data.VO.SeparateItem;
    import fl.transitions.easing.Strong;
    
    public class ContextMenu extends UIComponent implements IContextMenu
    {
        
        public function ContextMenu()
        {
            this._padding = new Padding();
            this._bgShadowBorder = new Padding(8,37,16,35);
            this._hitAreMargin = new Padding(3,3,3,3);
            this._memberItemData = {};
            this.tweenManager = new ExcludeTweenManager();
            super();
            this.padding = new Padding(0,0,0,0);
        }
        
        private var MARGIN:Number = 0;
        
        private var _padding:Padding;
        
        private var _data:Vector.<IContextItem> = null;
        
        public var bgMc:MovieClip;
        
        private var _bgShadowBorder:Padding;
        
        private var _hitAreMargin:Padding;
        
        private var FIRST_ELEM_TOP_PADDING:Number = 9;
        
        private var LAST_ELEM_BOTTOM_PADDING:Number = 9;
        
        private var startX:Number;
        
        private var startY:Number;
        
        private var showHideSubTween:Tween;
        
        private var expandTween:Tween;
        
        public var groupItemSelected:ContextMenuItem;
        
        private var items:Array;
        
        private var _memberItemData:Object;
        
        private var tweenManager:ExcludeTweenManager;
        
        public var hit:MovieClip = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            if(this.hit)
            {
                hitArea = this.hit;
            }
            if(this.bgMc)
            {
                this.bgMc.mouseEnabled = false;
                this.bgMc.mouseChildren = false;
                this.bgMc.tabEnabled = false;
                this.bgMc.tabChildren = false;
            }
        }
        
        public function build(param1:Vector.<IContextItem>, param2:Number, param3:Number) : void
        {
            var _loc4_:Vector.<IContextItem> = null;
            var _loc5_:uint = 0;
            var _loc6_:uint = 0;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:* = NaN;
            var _loc11_:uint = 0;
            var _loc12_:uint = 0;
            var _loc13_:IClassFactory = null;
            var _loc14_:ContextMenuItemSeparate = null;
            var _loc15_:ContextMenuItem = null;
            var _loc16_:IContextItem = null;
            this._data = param1;
            if(this._data)
            {
                _loc4_ = this._data;
                _loc7_ = this.MARGIN + this._bgShadowBorder.left;
                _loc8_ = this.MARGIN + this._bgShadowBorder.top + this.FIRST_ELEM_TOP_PADDING;
                _loc9_ = _loc7_;
                _loc10_ = _loc8_;
                _loc11_ = 0;
                _loc12_ = 0;
                this.items = new Array();
                _loc13_ = App.utils.classFactory;
                _loc5_ = 0;
                while(_loc5_ < _loc4_.length)
                {
                    _loc14_ = null;
                    _loc15_ = null;
                    _loc16_ = _loc4_[_loc5_];
                    if(_loc16_.id == ContextMenuConstants.SEPARATE)
                    {
                        _loc14_ = _loc13_.getComponent(Linkages.CONTEXT_MENU_SEPARATE,ContextMenuItemSeparate);
                        _loc14_.index = _loc5_;
                        _loc14_.id = _loc16_.id;
                        _loc14_.x = _loc9_;
                        _loc14_.y = _loc10_;
                        _loc10_ = _loc10_ + (_loc14_.height + this.padding.bottom + this.padding.top);
                        this.items.push(_loc14_);
                    }
                    else
                    {
                        _loc15_ = _loc13_.getComponent(Linkages.CONTEXT_MENU_ITEM,ContextMenuItem,_loc16_.initData);
                        _loc15_.index = _loc5_;
                        _loc15_.items = _loc4_[_loc5_].submenu?_loc4_[_loc5_].submenu.slice(0,_loc4_[_loc5_].submenu.length):new Vector.<IContextItem>();
                        _loc15_.addEventListener(ButtonEvent.CLICK,this.onItemClick);
                        _loc15_.id = _loc16_.id;
                        _loc15_.label = _loc16_.label;
                        _loc11_ = Math.max(_loc11_,_loc15_.width);
                        _loc15_.x = _loc9_;
                        _loc15_.y = _loc10_;
                        _loc10_ = _loc10_ + (_loc15_.height + this.padding.bottom + this.padding.top);
                        if(_loc15_.items.length > 0)
                        {
                            this.createSubItems(_loc15_);
                        }
                        this.items.push(_loc15_);
                    }
                    this.addChild(_loc14_ != null?_loc14_:_loc15_);
                    _loc5_++;
                }
                _loc5_ = 0;
                while(_loc5_ < this.items.length)
                {
                    this.items[_loc5_].width = _loc11_;
                    _loc5_++;
                }
                _loc12_ = _loc10_ - this.MARGIN - this.padding.bottom - this.padding.top - this._bgShadowBorder.top - this.FIRST_ELEM_TOP_PADDING;
                this.bgMc.width = _loc11_ + this.MARGIN * 2 + this._bgShadowBorder.left + this._bgShadowBorder.right ^ 0;
                this.bgMc.height = _loc12_ + this.MARGIN * 2 + this._bgShadowBorder.top + this._bgShadowBorder.bottom + this.FIRST_ELEM_TOP_PADDING + this.LAST_ELEM_BOTTOM_PADDING ^ 0;
                this.hit.x = _loc7_ - this._hitAreMargin.left;
                this.hit.y = _loc8_ - this.FIRST_ELEM_TOP_PADDING - this._hitAreMargin.top;
                this.hit.width = this.bgMc.width - (this._bgShadowBorder.horizontal + this.MARGIN * 2) + this._hitAreMargin.horizontal;
                this.hit.height = this.bgMc.height - (this._bgShadowBorder.vertical + this.MARGIN * 2) + this._hitAreMargin.vertical;
                this.x = param2 - this._bgShadowBorder.left;
                this.y = param3 - this._bgShadowBorder.top;
                if(this.y + this.bgMc.height > App.instance.appHeight)
                {
                    this.y = this.y - this.hit.height + this._hitAreMargin.vertical ^ 0;
                }
                if(this.y < 0)
                {
                    this.y = this._bgShadowBorder.top;
                }
                if(this.x + this.bgMc.width > App.instance.appWidth)
                {
                    this.x = this.x - this.hit.width + this._hitAreMargin.horizontal ^ 0;
                }
                if(this.x < 0)
                {
                    this.x = this._bgShadowBorder.left;
                }
                this.startX = this.x;
                this.startY = this.y;
            }
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
        }
        
        private function mouseDownHandler(param1:MouseEvent) : void
        {
            if(!this.hit.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
            {
                dispatchEvent(new ContextMenuEvent(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE));
            }
        }
        
        private function createSubItems(param1:ContextMenuItem) : void
        {
            var _loc6_:IContextItem = null;
            var _loc7_:ContextMenuItem = null;
            var _loc2_:Number = param1.x;
            var _loc3_:Number = param1.y + param1.height + this.padding.top + this.padding.bottom - this.FIRST_ELEM_TOP_PADDING;
            var _loc4_:IClassFactory = App.utils.classFactory;
            var _loc5_:uint = 0;
            while(_loc5_ < param1.items.length)
            {
                if(!(param1.items[_loc5_] is SeparateItem))
                {
                    _loc6_ = param1.items[_loc5_];
                    _loc7_ = _loc4_.getComponent(Linkages.CONTEXT_MENU_ITEM,ContextMenuItem,_loc6_.initData);
                    _loc7_.index = _loc5_;
                    _loc7_.type = _loc7_.CONTEXT_MENU_ITEM_SUB;
                    _loc7_.id = _loc6_.id;
                    _loc7_.label = _loc6_.label;
                    _loc7_.addEventListener(ButtonEvent.CLICK,this.onItemClick);
                    _loc7_.x = _loc2_;
                    _loc7_.y = _loc3_;
                    _loc3_ = _loc3_ + (_loc7_.height + this.padding.top + this.padding.bottom);
                    _loc7_.visible = false;
                    _loc7_.alpha = 0;
                    param1.subItems.push(_loc7_);
                    this.addChild(_loc7_);
                }
                _loc5_++;
            }
        }
        
        private function onItemClick(param1:ButtonEvent) : void
        {
            var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
            this.beginAnimExpand(_loc2_);
            if(_loc2_.type != _loc2_.CONTEXT_MENU_ITEM_GROUP)
            {
                dispatchEvent(new ContextMenuEvent(ContextMenuEvent.ON_ITEM_SELECT,_loc2_.id,this._data,this._memberItemData));
            }
        }
        
        private function beginAnimExpand(param1:ContextMenuItem) : void
        {
            this.tweenManager.unregisterAll();
            if((this.groupItemSelected) && this.groupItemSelected == param1)
            {
                if(this.groupItemSelected.isOpened)
                {
                    this.hideSub(this.groupItemSelected);
                }
                else
                {
                    this.showSub(this.groupItemSelected);
                }
            }
            else
            {
                if((this.groupItemSelected) && (this.groupItemSelected.isOpened))
                {
                    this.hideSub(this.groupItemSelected);
                }
                this.groupItemSelected = param1;
                this.showSub(this.groupItemSelected);
            }
            this.expand(this.groupItemSelected);
        }
        
        private function expand(param1:ContextMenuItem) : void
        {
            var _loc2_:uint = param1.index + 1;
            var _loc3_:uint = 0;
            var _loc4_:uint = 0;
            var _loc5_:Function = Strong.easeInOut;
            var _loc6_:Number = this.MARGIN + this._bgShadowBorder.top;
            if(param1.isOpened)
            {
                _loc3_ = 0;
                while(_loc3_ < param1.subItems.length)
                {
                    _loc4_ = _loc4_ + (param1.subItems[_loc3_].height + this.padding.top + this.padding.bottom);
                    _loc3_++;
                }
            }
            var _loc7_:Number = 0;
            var _loc8_:Number = 0;
            _loc7_ = _loc4_;
            _loc3_ = 0;
            while(_loc3_ < this.items.length)
            {
                _loc7_ = _loc7_ + (this.items[_loc3_].height + this.padding.top + this.padding.bottom);
                _loc3_++;
            }
            if(this.startY + _loc7_ + this.MARGIN + this._bgShadowBorder.top + this._bgShadowBorder.bottom > App.appHeight)
            {
                _loc8_ = App.appHeight - (this.startY + _loc7_ + this.MARGIN + this._bgShadowBorder.top + this._bgShadowBorder.bottom);
            }
            _loc3_ = 0;
            while(_loc3_ < this.items.length)
            {
                if(_loc3_ == _loc2_)
                {
                    _loc6_ = _loc6_ + _loc4_;
                }
                this.tweenManager.registerAndLaunch(300,this.items[_loc3_],{"y":_loc6_},{"paused":false,
                "onComplete":this.onHideTweenComplete,
                "ease":_loc5_
            });
            _loc6_ = _loc6_ + (this.items[_loc3_].height + this.padding.top + this.padding.bottom);
            _loc3_++;
        }
        var _loc9_:Number = _loc6_ + this.MARGIN + this._bgShadowBorder.bottom - this.padding.bottom - this.padding.top ^ 0;
        this.tweenManager.registerAndLaunch(300,this.bgMc,{"height":_loc9_},{"paused":false,
        "onComplete":this.onHideTweenComplete,
        "ease":_loc5_
    });
    this.tweenManager.registerAndLaunch(300,this,{"y":this.startY + _loc8_},{"paused":false,
    "onComplete":this.onHideTweenComplete,
    "ease":_loc5_
});
}

private function showSub(param1:ContextMenuItem) : void
{
var _loc3_:ContextMenuItem = null;
param1.isOpened = true;
var _loc2_:uint = 0;
while(_loc2_ < param1.subItems.length)
{
    _loc3_ = ContextMenuItem(param1.subItems[_loc2_]);
    _loc3_.visible = true;
    this.showHideSubTween = this.tweenManager.registerAndLaunch(300,_loc3_,{"alpha":1},{"paused":false,
    "onComplete":this.fSubAnimComplete,
    "ease":Strong.easeIn
});
_loc2_++;
}
}

private function hideSub(param1:ContextMenuItem) : void
{
var _loc3_:ContextMenuItem = null;
param1.isOpened = false;
var _loc2_:uint = 0;
while(_loc2_ < param1.subItems.length)
{
_loc3_ = ContextMenuItem(param1.subItems[_loc2_]);
this.showHideSubTween = this.tweenManager.registerAndLaunch(300,_loc3_,{"alpha":0},{"paused":false,
"onComplete":this.fSubAnimComplete,
"ease":Strong.easeOut
});
_loc2_++;
}
}

private function onHideTweenComplete(param1:Tween) : void
{
this.tweenManager.unregister(param1);
}

private function fSubAnimComplete(param1:Tween) : void
{
var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
if(_loc2_.alpha == 0)
{
_loc2_.visible = false;
}
this.tweenManager.unregister(param1);
}

public function get padding() : Padding
{
return this._padding;
}

public function set padding(param1:Padding) : void
{
this._padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
}

override protected function onDispose() : void
{
var _loc3_:uint = 0;
var _loc4_:uint = 0;
super.onDispose();
if(App.instance.stage.hasEventListener(MouseEvent.MOUSE_DOWN))
{
App.instance.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
}
this.tweenManager.unregisterAll();
var _loc1_:uint = 0;
var _loc2_:uint = this.numChildren;
if(this.items)
{
_loc3_ = 0;
while(_loc3_ < this.items.length)
{
if(this.items[_loc3_].subItems)
{
    _loc4_ = 0;
    while(_loc4_ < this.items[_loc3_].subItems.length)
    {
        if(this.items[_loc3_].subItems[_loc4_].hasEventListener(ButtonEvent.CLICK))
        {
            this.items[_loc3_].subItems[_loc4_].removeEventListener(ButtonEvent.CLICK,this.onItemClick);
        }
        this.removeChild(this.items[_loc3_].subItems[_loc4_]);
        _loc4_++;
    }
}
if(this.items[_loc3_].hasEventListener(ButtonEvent.CLICK))
{
    this.items[_loc3_].removeEventListener(ButtonEvent.CLICK,this.onItemClick);
}
this.removeChild(this.items[_loc3_]);
_loc3_++;
}
}
}

public function setMemberItemData(param1:Object) : void
{
this._memberItemData = param1;
}

override public function toString() : String
{
return "[Wargaming ContextMenu " + name + "]";
}
}
}
