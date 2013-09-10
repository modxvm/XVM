package net.wg.gui.components.controls 
{
    import __AS3__.vec.*;
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.motion.*;
    import scaleform.clik.utils.*;
    
    public class ContextMenu extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IContextMenu
    {
        public function ContextMenu()
        {
            this._padding = new scaleform.clik.utils.Padding();
            this.bgShadowBorder = new scaleform.clik.utils.Padding(4, 6, 8, 6);
            this._memberItemData = {};
            this.tweenManager = new net.wg.gui.utils.ExcludeTweenManager();
            super();
            this.padding = new scaleform.clik.utils.Padding(0, 0, 0, 0);
            return;
        }

        public function build(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>, arg2:Number, arg3:Number):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            this._data = arg1;
            if (this._data) 
            {
                loc1 = this._data;
                loc4 = this.MARGIN + this.bgShadowBorder.left;
                loc5 = this.MARGIN + this.bgShadowBorder.top;
                loc6 = 0;
                loc7 = 0;
                this.items = new Array();
                loc8 = App.utils.classFactory;
                loc2 = 0;
                while (loc2 < loc1.length) 
                {
                    loc9 = null;
                    loc10 = null;
                    if (loc1[loc2] is net.wg.data.VO.SeparateItem) 
                    {
                        (loc9 = loc8.getComponent(net.wg.data.constants.Linkages.CONTEXT_MENU_SEPARATE, net.wg.gui.components.controls.ContextMenuItemSeparate)).index = loc2;
                        loc9.id = loc1[loc2].id;
                        loc9.x = loc4;
                        loc9.y = loc5;
                        loc5 = loc5 + (loc9.height + this.padding.bottom + this.padding.top);
                        this.items.push(loc9);
                    }
                    else 
                    {
                        loc11 = loc1[loc2];
                        (loc10 = loc8.getComponent(net.wg.data.constants.Linkages.CONTEXT_MENU_ITEM, net.wg.gui.components.controls.ContextMenuItem, loc11.initData)).index = loc2;
                        loc10.items = loc1[loc2].submenu ? loc1[loc2].submenu.slice(1, loc1[loc2].submenu.length) : new Vector.<net.wg.infrastructure.interfaces.IContextItem>();
                        loc10.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemClick);
                        loc10.id = loc11.id;
                        loc10.label = loc11.label;
                        loc6 = Math.max(loc6, loc10.width);
                        loc10.x = loc4;
                        loc10.y = loc5;
                        loc5 = loc5 + (loc10.height + this.padding.bottom + this.padding.top);
                        if (loc10.items.length > 0) 
                            this.createSubItems(loc10);
                        this.items.push(loc10);
                    }
                    this.addChild(loc9 == null ? loc10 : loc9);
                    ++loc2;
                }
                loc2 = 0;
                while (loc2 < this.items.length) 
                {
                    this.items[loc2].width = loc6;
                    ++loc2;
                }
                loc7 = loc5 - this.MARGIN - this.padding.bottom - this.padding.top - this.bgShadowBorder.top;
                this.bgMc.width = loc6 + this.MARGIN * 2 + this.bgShadowBorder.left + this.bgShadowBorder.right ^ 0;
                this.bgMc.height = loc7 + this.MARGIN * 2 + this.bgShadowBorder.top + this.bgShadowBorder.bottom ^ 0;
                x = arg2;
                y = arg3;
                if (y + this.bgMc.height > App.instance.appHeight) 
                    y = y - this.bgMc.height ^ 0;
                if (y < 0) 
                    y = this.bgShadowBorder.top;
                if (x + this.bgMc.width > App.instance.appWidth) 
                    x = x - this.bgMc.width ^ 0;
                if (x < 0) 
                    x = this.bgShadowBorder.left;
                this.startX = this.x;
                this.startY = this.y;
            }
            App.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
            return;
        }

        internal function mouseDownHandler(arg1:flash.events.MouseEvent):void
        {
            if (!this.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) 
                dispatchEvent(new net.wg.gui.events.ContextMenuEvent(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE));
            return;
        }

        internal function createSubItems(arg1:net.wg.gui.components.controls.ContextMenuItem):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=arg1.x;
            var loc2:*=arg1.y + arg1.height + this.padding.top + this.padding.bottom;
            var loc3:*=App.utils.classFactory;
            var loc4:*=0;
            while (loc4 < arg1.items.length) 
            {
                if (!(arg1.items[loc4] is net.wg.data.VO.SeparateItem)) 
                {
                    loc5 = arg1.items[loc4];
                    (loc6 = loc3.getComponent(net.wg.data.constants.Linkages.CONTEXT_MENU_ITEM, net.wg.gui.components.controls.ContextMenuItem, loc5.initData)).index = loc4;
                    loc6.type = loc6.CONTEXT_MENU_ITEM_SUB;
                    loc6.id = loc5.id;
                    loc6.label = loc5.label;
                    loc6.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemClick);
                    loc6.x = loc1;
                    loc6.y = loc2;
                    loc2 = loc2 + (loc6.height + this.padding.top + this.padding.bottom);
                    loc6.visible = false;
                    loc6.alpha = 0;
                    arg1.subItems.push(loc6);
                    this.addChild(loc6);
                }
                ++loc4;
            }
            return;
        }

        internal function onItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.ContextMenuItem(arg1.target);
            this.beginAnimExpand(loc1);
            if (loc1.type != loc1.CONTEXT_MENU_ITEM_GROUP) 
                dispatchEvent(new net.wg.gui.events.ContextMenuEvent(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, loc1.id, this._data, this._memberItemData));
            return;
        }

        internal function beginAnimExpand(arg1:net.wg.gui.components.controls.ContextMenuItem):void
        {
            this.tweenManager.unregisterAll();
            if (this.groupItemSelected && this.groupItemSelected == arg1) 
                if (this.groupItemSelected.isOpened) 
                    this.hideSub(this.groupItemSelected);
                else 
                    this.showSub(this.groupItemSelected);
            else 
            {
                if (this.groupItemSelected && this.groupItemSelected.isOpened) 
                    this.hideSub(this.groupItemSelected);
                this.groupItemSelected = arg1;
                this.showSub(this.groupItemSelected);
            }
            this.expand(this.groupItemSelected);
            return;
        }

        internal function expand(arg1:net.wg.gui.components.controls.ContextMenuItem):void
        {
            var loc1:*=arg1.index + 1;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=fl.transitions.easing.Strong.easeInOut;
            var loc5:*=this.MARGIN + this.bgShadowBorder.top;
            if (arg1.isOpened) 
            {
                loc2 = 0;
                while (loc2 < arg1.subItems.length) 
                {
                    loc3 = loc3 + (arg1.subItems[loc2].height + this.padding.top + this.padding.bottom);
                    ++loc2;
                }
            }
            var loc6:*=0;
            var loc7:*=0;
            loc6 = loc3;
            loc2 = 0;
            while (loc2 < this.items.length) 
            {
                loc6 = loc6 + (this.items[loc2].height + this.padding.top + this.padding.bottom);
                ++loc2;
            }
            if (this.startY + loc6 + this.MARGIN + this.bgShadowBorder.top + this.bgShadowBorder.bottom > App.appHeight) 
                loc7 = App.appHeight - (this.startY + loc6 + this.MARGIN + this.bgShadowBorder.top + this.bgShadowBorder.bottom);
            loc2 = 0;
            while (loc2 < this.items.length) 
            {
                if (loc2 == loc1) 
                    loc5 = loc5 + loc3;
                this.tweenManager.registerAndLaunch(300, this.items[loc2], {"y":loc5}, {"paused":false, "onComplete":this.onHideTweenComplete, "ease":loc4});
                loc5 = loc5 + (this.items[loc2].height + this.padding.top + this.padding.bottom);
                ++loc2;
            }
            var loc8:*=loc5 + this.MARGIN + this.bgShadowBorder.bottom - this.padding.bottom - this.padding.top ^ 0;
            this.tweenManager.registerAndLaunch(300, this.bgMc, {"height":loc8}, {"paused":false, "onComplete":this.onHideTweenComplete, "ease":loc4});
            this.tweenManager.registerAndLaunch(300, this, {"y":this.startY + loc7}, {"paused":false, "onComplete":this.onHideTweenComplete, "ease":loc4});
            return;
        }

        internal function showSub(arg1:net.wg.gui.components.controls.ContextMenuItem):void
        {
            var loc2:*=null;
            arg1.isOpened = true;
            var loc1:*=0;
            while (loc1 < arg1.subItems.length) 
            {
                loc2 = net.wg.gui.components.controls.ContextMenuItem(arg1.subItems[loc1]);
                loc2.visible = true;
                this.showHideSubTween = this.tweenManager.registerAndLaunch(300, loc2, {"alpha":1}, {"paused":false, "onComplete":this.fSubAnimComplete, "ease":fl.transitions.easing.Strong.easeIn});
                ++loc1;
            }
            return;
        }

        internal function hideSub(arg1:net.wg.gui.components.controls.ContextMenuItem):void
        {
            var loc2:*=null;
            arg1.isOpened = false;
            var loc1:*=0;
            while (loc1 < arg1.subItems.length) 
            {
                loc2 = net.wg.gui.components.controls.ContextMenuItem(arg1.subItems[loc1]);
                this.showHideSubTween = this.tweenManager.registerAndLaunch(300, loc2, {"alpha":0}, {"paused":false, "onComplete":this.fSubAnimComplete, "ease":fl.transitions.easing.Strong.easeOut});
                ++loc1;
            }
            return;
        }

        internal function onHideTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.tweenManager.unregister(arg1);
            return;
        }

        internal function fSubAnimComplete(arg1:scaleform.clik.motion.Tween):void
        {
            var loc1:*=net.wg.gui.components.controls.ContextMenuItem(arg1.target);
            if (loc1.alpha == 0) 
                loc1.visible = false;
            this.tweenManager.unregister(arg1);
            return;
        }

        public function get padding():scaleform.clik.utils.Padding
        {
            return this._padding;
        }

        public function set padding(arg1:scaleform.clik.utils.Padding):void
        {
            this._padding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public override function dispose():void
        {
            var loc3:*=0;
            var loc4:*=0;
            super.dispose();
            if (App.instance.stage.hasEventListener(flash.events.MouseEvent.MOUSE_DOWN)) 
                App.instance.stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
            this.tweenManager.unregisterAll();
            var loc1:*=0;
            var loc2:*=this.numChildren;
            if (this.items) 
            {
                loc3 = 0;
                while (loc3 < this.items.length) 
                {
                    if (this.items[loc3].subItems) 
                    {
                        loc4 = 0;
                        while (loc4 < this.items[loc3].subItems.length) 
                        {
                            if (this.items[loc3].subItems[loc4].hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                                this.items[loc3].subItems[loc4].removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemClick);
                            this.removeChild(this.items[loc3].subItems[loc4]);
                            ++loc4;
                        }
                    }
                    if (this.items[loc3].hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                        this.items[loc3].removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemClick);
                    this.removeChild(this.items[loc3]);
                    ++loc3;
                }
            }
            return;
        }

        public function setMemberItemData(arg1:Object):void
        {
            this._memberItemData = arg1;
            return;
        }

        public override function toString():String
        {
            return "[Wargaming ContextMenu " + name + "]";
        }

        internal var MARGIN:Number=0;

        internal var _padding:scaleform.clik.utils.Padding;

        internal var _data:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>=null;

        public var bgMc:flash.display.MovieClip;

        public var bgShadowBorder:scaleform.clik.utils.Padding;

        internal var startX:Number;

        internal var startY:Number;

        internal var showHideSubTween:scaleform.clik.motion.Tween;

        internal var expandTween:scaleform.clik.motion.Tween;

        public var groupItemSelected:net.wg.gui.components.controls.ContextMenuItem;

        internal var items:Array;

        internal var _memberItemData:Object;

        internal var tweenManager:net.wg.gui.utils.ExcludeTweenManager;
    }
}
