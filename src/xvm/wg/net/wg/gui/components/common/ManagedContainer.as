package net.wg.gui.components.common 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.motion.*;
    import scaleform.gfx.*;
    
    public class ManagedContainer extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IManagedContainer
    {
        public function ManagedContainer()
        {
            this.groupsCounter = {};
            super();
            this.mouseEnabled = false;
            return;
        }

        public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=arg1 as net.wg.infrastructure.base.AbstractView;
            if (arg1 is net.wg.infrastructure.interfaces.IAbstractWindowView) 
            {
                loc2 = net.wg.infrastructure.interfaces.IWindow(App.utils.classFactory.getComponent(net.wg.data.constants.Linkages.WINDOW, net.wg.infrastructure.interfaces.IWindow));
                loc2.sourceView = loc1 as net.wg.infrastructure.interfaces.IAbstractWindowView;
                loc2.sourceView.window = loc2;
                arg1 = flash.display.DisplayObject(loc2);
            }
            if (loc1 && loc1.as_config && loc1.as_config.hasOwnProperty("type")) 
            {
                super.addChild(arg1);
                loc1.playShowTween(arg1);
                if (loc1.as_config.type == net.wg.data.constants.ContainerTypes.WINDOW || loc1.as_config.type == net.wg.data.constants.ContainerTypes.DIALOG) 
                {
                    loc3 = null;
                    if (loc1.as_config.hasOwnProperty("group")) 
                        loc3 = (loc3 = loc1.as_config.group).length ? loc3 : null;
                    if (loc3) 
                    {
                        this.addGroupCounter(loc3, loc1.as_token);
                        this.movieViewToVector(arg1, loc3);
                    }
                }
                if (this.manageFocus) 
                    arg1.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onViewClick, true, 0, true);
            }
            else 
                throw new Error(this.ADD_CHILD_ERROR_STR);
            if (arg1 is net.wg.infrastructure.base.AbstractView) 
                (arg1 as net.wg.infrastructure.base.AbstractView).updateStage(width, height);
            else if (arg1 is net.wg.infrastructure.interfaces.IWindow) 
                (arg1 as net.wg.infrastructure.interfaces.IWindow).sourceView.updateStage(width, height);
            return loc1;
        }

        public override function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=App.utils.asserter;
            loc1.assertNotNull(arg1, "child" + net.wg.data.constants.Errors.CANT_NULL);
            var loc2:*=arg1 as net.wg.infrastructure.base.AbstractView;
            if (arg1 is net.wg.infrastructure.interfaces.IAbstractWindowView) 
            {
                loc3 = net.wg.infrastructure.interfaces.IAbstractWindowView(loc2);
                arg1 = flash.display.DisplayObject(loc3.window);
                loc1.assertNotNull(arg1, "abstractWindowView.window" + net.wg.data.constants.Errors.CANT_NULL);
            }
            if (loc2 && loc2.as_config && loc2.as_config.hasOwnProperty("type")) 
            {
                if (loc2.as_config.type != net.wg.data.constants.ContainerTypes.VIEW) 
                {
                    loc4 = null;
                    if (loc2.as_config.hasOwnProperty("group")) 
                        loc4 = (loc4 = loc2.as_config.group).length ? loc4 : null;
                    if (loc4 && this.groupsCounter.hasOwnProperty(loc4)) 
                    {
                        (loc5 = this.groupsCounter[loc4]).decrement(loc2.as_token);
                        if (loc5.views.length == 0) 
                            delete this.groupsCounter[loc4];
                    }
                }
                if (!loc2.playHideTween(arg1, this.onTweenEnd)) 
                    this.performRemoveChild(arg1);
            }
            else 
                throw new Error(this.REMOVE_CHILD_ERROR_STR);
            return loc2;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            this.removeAllChildren();
            var loc2:*=0;
            var loc3:*=this.groupsCounter;
            for (loc1 in loc3) 
            {
                trace(loc1);
                delete this.groupsCounter[loc1];
            }
            this.groupsCounter = null;
            return;
        }

        public function getTopmostView():flash.display.DisplayObject
        {
            var loc1:*=null;
            if (numChildren) 
            {
                loc1 = getChildAt((numChildren - 1));
                if (loc1 == this._modalBg) 
                    loc1 = null;
            }
            return loc1;
        }

        public function setFocusedView(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (contains(arg1)) 
            {
                App.utils.focusHandler.setFocus(flash.display.InteractiveObject(arg1));
                if (arg1 is net.wg.infrastructure.interfaces.IAbstractWindowView) 
                    loc1 = (arg1 as net.wg.infrastructure.interfaces.IAbstractWindowView).window;
                else 
                    loc1 = arg1 as net.wg.infrastructure.interfaces.IWindow;
                if (loc1) 
                {
                    arg1 = flash.display.DisplayObject(loc1);
                    scaleform.gfx.FocusManager.setModalClip(arg1 as flash.display.Sprite);
                    if (loc1.sourceView.isModal) 
                        this.createModalBg();
                }
                setChildIndex(arg1, (numChildren - 1));
                if (arg1 is net.wg.infrastructure.base.AbstractView) 
                    loc2 = arg1 as net.wg.infrastructure.interfaces.IView;
                else if (loc1) 
                    loc2 = loc1.sourceView as net.wg.infrastructure.interfaces.IView;
                if (loc2) 
                    loc2.setFocus();
                App.containerMgr.lastFocusedView = loc2;
            }
            return;
        }

        protected function createModalBg():void
        {
            if (this._modalBg == null) 
            {
                this._modalBg = flash.display.MovieClip(App.utils.classFactory.getObject(net.wg.data.constants.Linkages.POPUP_MODAL));
                if (this._modalBg == null) 
                {
                    DebugUtils.LOG_DEBUG("Error until getting ");
                    return;
                }
            }
            this._modalBg.width = App.appWidth;
            this._modalBg.height = App.appHeight;
            addChildAt(this._modalBg, numChildren > 0 ? (numChildren - 1) : 0);
            return;
        }

        public function setFocused(arg1:Boolean=false):Boolean
        {
            var loc1:*=null;
            if (this.manageFocus) 
            {
                loc1 = this.getTopmostView();
                if (loc1) 
                    this.setFocusedView(loc1);
                else 
                {
                    App.utils.focusHandler.setFocus(null);
                    scaleform.gfx.FocusManager.setModalClip(null);
                    if (!arg1) 
                        dispatchEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_OUT));
                }
            }
            return !(loc1 == null);
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._modalBg != null) 
            {
                this._modalBg.width = arg1;
                this._modalBg.height = arg2;
            }
            _originalWidth = arg1;
            _originalHeight = arg2;
            setSize(arg1, arg2);
            loc1 = (numChildren - 1);
            while (loc1 > -1) 
            {
                if ((loc2 = getChildAt(loc1)) is net.wg.infrastructure.base.AbstractView) 
                    (loc2 as net.wg.infrastructure.base.AbstractView).updateStage(arg1, arg2);
                else if (loc2 is net.wg.infrastructure.interfaces.IWindow) 
                    (loc2 as net.wg.infrastructure.interfaces.IWindow).sourceView.updateStage(arg1, arg2);
                --loc1;
            }
            return;
        }

        public function onTweenEnd(arg1:scaleform.clik.motion.Tween=null):void
        {
            if (super.getChildByName(flash.display.DisplayObject(arg1.target).name) != null) 
                this.performRemoveChild(flash.display.DisplayObject(arg1.target));
            return;
        }

        public function get manageSize():Boolean
        {
            return this._manageSize;
        }

        public function set manageSize(arg1:Boolean):void
        {
            this._manageSize = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            initSize();
            return;
        }

        protected function removeAllChildren():void
        {
            while (numChildren) 
                removeChildAt((numChildren - 1));
            return;
        }

        protected function superRemoveChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            return super.removeChild(arg1);
        }

        internal function performRemoveChild(arg1:flash.display.DisplayObject):void
        {
            if (arg1 is net.wg.infrastructure.interfaces.IWindow && (arg1 as net.wg.infrastructure.interfaces.IWindow).sourceView.isModal && !(this._modalBg == null)) 
            {
                super.removeChild(this._modalBg);
                this._modalBg = null;
            }
            super.removeChild(arg1);
            if (this.manageFocus) 
                arg1.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onViewClick, true);
            dispatchEvent(new net.wg.gui.events.ManagedContainerEvent(net.wg.gui.events.ManagedContainerEvent.CHILD_REMOVED));
            return;
        }

        internal function addGroupCounter(arg1:String, arg2:String):void
        {
            if (arg1 == null) 
                return;
            if (!this.groupsCounter.hasOwnProperty(arg1)) 
                this.groupsCounter[arg1] = new GroupCounter();
            var loc1:*=this.groupsCounter[arg1];
            loc1.increment(arg2);
            return;
        }

        internal function movieViewToVector(arg1:flash.display.DisplayObject, arg2:String):void
        {
            var loc1:*=this.groupsCounter[arg2];
            if (!loc1) 
                return;
            var loc2:*=arg1.x + (loc1.xAdjust - 1) * this.GROUP_X_OFFSET;
            var loc3:*=arg1.y + (loc1.yAdjust - 1) * this.GROUP_Y_OFFSET;
            var loc4:*=arg1.width;
            var loc5:*=arg1.height;
            if (loc2 < 0) 
            {
                loc2 = 0;
                loc1.isReverceX = false;
            }
            else if (loc2 + loc4 > stage.stageWidth) 
            {
                loc2 = stage.stageWidth - loc4;
                loc1.isReverceX = true;
            }
            if (loc3 < 0) 
            {
                loc3 = 0;
                loc1.isReverceY = false;
            }
            else if (loc3 + loc5 > stage.stageHeight) 
            {
                loc3 = stage.stageHeight - loc5;
                loc1.isReverceY = true;
            }
            arg1.x = loc2;
            arg1.y = loc3;
            return;
        }

        internal function onViewClick(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.DisplayObject(arg1.currentTarget);
            var loc2:*=null;
            if (contains(loc1)) 
            {
                if (loc1 is net.wg.infrastructure.interfaces.IWindow) 
                    loc2 = net.wg.infrastructure.interfaces.IWindow(loc1).sourceView;
                if (loc2) 
                    if (loc2 != App.containerMgr.lastFocusedView) 
                        this.setFocusedView(loc1);
                else 
                {
                    loc2 = this.getTopmostView() as net.wg.infrastructure.interfaces.IView;
                    if (loc2) 
                        App.containerMgr.lastFocusedView = loc2;
                    else 
                        DebugUtils.LOG_WARNING(loc1 + " is Not IView!");
                }
            }
            return;
        }

        internal const ADD_CHILD_ERROR_STR:String="ManagedContainer.addChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

        internal const REMOVE_CHILD_ERROR_STR:String="ManagedContainer.removeChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

        internal const GROUP_X_OFFSET:int=20;

        internal const GROUP_Y_OFFSET:int=20;

        protected var _modalBg:flash.display.DisplayObject=null;

        public var manageFocus:Boolean=true;

        internal var _manageSize:Boolean=true;

        internal var groupsCounter:Object;

        internal var _type:String="conatiner";
    }
}

import __AS3__.vec.*;


class GroupCounter extends Object
{
    public function GroupCounter()
    {
        super();
        this.views = new Vector.<GroupViewObject>();
        return;
    }

    public function increment(arg1:String):void
    {
        var loc1:*=new GroupViewObject(arg1);
        var loc2:*=this.views.length > 0 ? this.views[(this.views.length - 1)].xAdjust : 0;
        var loc3:*=this.views.length > 0 ? this.views[(this.views.length - 1)].yAdjust : 0;
        var loc4:*=this.isReverceX ? -1 : 1;
        var loc5:*=this.isReverceY ? -1 : 1;
        loc1.xAdjust = loc4 + loc2;
        loc1.yAdjust = loc5 + loc3;
        this.views.push(loc1);
        return;
    }

    public function decrement(arg1:String):void
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=this.views;
        for each (loc1 in loc3) 
        {
            if (loc1.id != arg1) 
                continue;
            this.views.splice(this.views.indexOf(loc1), 1);
            break;
        }
        return;
    }

    public function get xAdjust():int
    {
        return this.views.length > 0 ? this.views[(this.views.length - 1)].xAdjust : 0;
    }

    public function get yAdjust():int
    {
        return this.views.length > 0 ? this.views[(this.views.length - 1)].yAdjust : 0;
    }

    public var views:__AS3__.vec.Vector.<GroupViewObject>=null;

    public var isReverceX:Boolean=false;

    public var isReverceY:Boolean=false;
}

class GroupViewObject extends Object
{
    public function GroupViewObject(arg1:String)
    {
        super();
        this.id = arg1;
        return;
    }

    public var xAdjust:int=0;

    public var yAdjust:int=0;

    public var id:String="";
}