package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class ViewStack extends scaleform.clik.core.UIComponent
    {
        public function ViewStack()
        {
            super();
            this.cachedViews = {};
            this.container = new flash.display.Sprite();
            this.addChild(this.container);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            tabEnabled = false;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                var loc1:*;
                this.container.height = loc1 = 5;
                this.container.width = loc1;
                width = _width;
                height = _height;
            }
            this.container.scaleX = 1 / scaleX;
            this.container.scaleY = 1 / scaleY;
            return;
        }

        public function get targetGroup():String
        {
            return this._targetGroup.name;
        }

        public function set targetGroup(arg1:String):void
        {
            var loc1:*=null;
            if (arg1 != "") 
            {
                this.assertTargetGroup(arg1);
                loc1 = net.wg.infrastructure.interfaces.IGroupedControl(parent[arg1]);
                this.groupRef = loc1;
            }
            return;
        }

        public function set groupRef(arg1:net.wg.infrastructure.interfaces.IGroupedControl):void
        {
            var loc1:*=arg1;
            if (this._targetGroup != loc1) 
            {
                if (this._targetGroup != null) 
                {
                    this._targetGroup.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
                }
                this._targetGroup = loc1;
                if (this._targetGroup != null) 
                {
                    this._targetGroup.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
                    this.changeView();
                }
            }
            return;
        }

        internal function assertTargetGroup(arg1:String):void
        {
            if (!App.utils) 
            {
                return;
            }
            var loc1:*="component with instance \'" + arg1 + "\'";
            var loc2:*=App.utils.asserter;
            loc2.assert(parent.hasOwnProperty(arg1), "container \'" + parent + "\' has no " + loc1, net.wg.infrastructure.exceptions.ArgumentException);
            loc2.assert(parent[arg1] is net.wg.infrastructure.interfaces.IGroupedControl, "container \'" + parent + "\'  must implements IGroupController interface");
            var loc3:*=net.wg.infrastructure.interfaces.IGroupedControl(parent[arg1]);
            return;
        }

        internal function onChangeViewHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.changeView();
            return;
        }

        internal function changeView():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._targetGroup.selectedItem != null) 
            {
                loc1 = this._targetGroup.data;
                if (loc1 != null) 
                {
                    if (loc1.hasOwnProperty("linkage")) 
                    {
                        if (loc1.linkage != null) 
                        {
                            this.show(loc1.linkage);
                        }
                    }
                    else 
                    {
                        loc2 = "renderers data for View stack must have a linkage property!";
                        DebugUtils.LOG_DEBUG(loc2);
                    }
                }
            }
            return;
        }

        public function show(arg1:String):flash.display.MovieClip
        {
            if (this.currentView != null) 
            {
                if (this.currentView["__cached__"] != true) 
                {
                    this.container.removeChild(this.currentView);
                    (this.currentView as net.wg.infrastructure.interfaces.entity.IDisposable).dispose();
                    this.currentView = null;
                }
                else 
                {
                    this.currentView.visible = false;
                }
            }
            var loc1:*=this.createView(arg1);
            this.currentView = loc1;
            this._currentLinkage = arg1;
            if (loc1 != null) 
            {
                loc1.visible = true;
            }
            invalidate();
            return loc1;
        }

        internal function createView(arg1:String):scaleform.clik.core.UIComponent
        {
            var loc2:*=null;
            var loc1:*=null;
            if (this.cachedViews[arg1] == null) 
            {
                if (App.utils) 
                {
                    loc1 = App.utils.classFactory.getComponent(arg1, scaleform.clik.core.UIComponent);
                    App.utils.asserter.assert(loc1 is net.wg.infrastructure.interfaces.IViewStackContent, "view must implements IViewStackContent");
                }
                else 
                {
                    loc2 = flash.utils.getDefinitionByName(arg1) as Class;
                    loc1 = new loc2() as scaleform.clik.core.UIComponent;
                }
                loc1.visible = false;
                this.container.addChild(loc1);
                loc1.validateNow();
                dispatchEvent(new net.wg.gui.events.ViewStackEvent(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, net.wg.infrastructure.interfaces.IViewStackContent(loc1), arg1));
                if (!(loc1 == null) && this.cache) 
                {
                    loc1["__cached__"] = true;
                    this.cachedViews[arg1] = loc1;
                    loc1 = loc1;
                }
            }
            else 
            {
                loc1 = this.cachedViews[arg1];
            }
            dispatchEvent(new net.wg.gui.events.ViewStackEvent(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, net.wg.infrastructure.interfaces.IViewStackContent(loc1), arg1));
            return loc1;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._targetGroup != null) 
            {
                this._targetGroup.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
                this._targetGroup = null;
            }
            if (this.container) 
            {
                if (this.cache) 
                {
                    var loc3:*=0;
                    var loc4:*=this.cachedViews;
                    for (loc2 in loc4) 
                    {
                        delete this.cachedViews[loc2];
                    }
                    this.cachedViews = null;
                }
                while (this.container.numChildren > 0) 
                {
                    loc1 = net.wg.infrastructure.interfaces.entity.IDisposable(this.container.getChildAt(0));
                    loc1.dispose();
                    this.container.removeChildAt(0);
                }
                this.removeChild(this.container);
                this.container = null;
            }
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG ViewStack " + name + "]";
        }

        public function get currentLinkage():String
        {
            return this._currentLinkage;
        }

        public var cache:Boolean=false;

        public var cachedViews:Object;

        internal var depth:Number=0;

        internal var _targetGroup:net.wg.infrastructure.interfaces.IGroupedControl=null;

        public var currentView:flash.display.MovieClip;

        internal var _currentLinkage:String;

        protected var container:flash.display.Sprite;
    }
}
