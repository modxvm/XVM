package net.wg.app.impl 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.app.impl.base.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.infrastructure.helpers.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.infrastructure.managers.impl.*;
    import net.wg.infrastructure.managers.utils.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public final class Application extends net.wg.app.impl.base.AbstractApplication
    {
        public function Application()
        {
            this.browserBgClassValue = net.wg.app.impl.Application_browserBgClassValue;
            this._librariesList = Vector.<String>(["windows.swf", "toolTips.swf"]);
            super();
            scaleform.gfx.Extensions.enabled = true;
            scaleform.gfx.Extensions.noInvisibleAdvance = true;
            scaleform.clik.core.CLIK.disableNullFocusMoves = true;
            return;
        }

        protected override function getNewContainerManager():net.wg.infrastructure.managers.IContainerManager
        {
            return new net.wg.infrastructure.managers.impl.ContainerManager();
        }

        protected override function getNewColorSchemeManager():net.wg.infrastructure.managers.IColorSchemeManager
        {
            return new net.wg.infrastructure.managers.impl.ColorSchemeManager();
        }

        protected override function getNewContextMenuManager():net.wg.infrastructure.managers.IContextMenuManager
        {
            return new net.wg.infrastructure.managers.impl.ContextMenuManager();
        }

        protected override function getNewClassManager():flash.display.Sprite
        {
            return new net.wg.infrastructure.managers.impl.ClassManager();
        }

        protected override function getNewGuiItemsManager():net.wg.infrastructure.managers.IGuiItemsManager
        {
            return new net.wg.infrastructure.managers.impl.GuiItemsManager();
        }

        protected override function getNewVoiceChatManager():net.wg.infrastructure.managers.IVoiceChatManager
        {
            return new net.wg.infrastructure.managers.impl.VoiceChatManager();
        }

        protected override function getNewGameInputManager():net.wg.utils.IGameInputManager
        {
            return new net.wg.infrastructure.managers.impl.GameInputManager();
        }

        protected override function onAppConfiguring():void
        {
            super.onAppConfiguring();
            this._loader = new net.wg.infrastructure.helpers.LibraryLoader(this._libraries);
            this._loader.load(this._librariesList);
            return;
        }

        protected override function onPopUpManagerInit():void
        {
            super.onPopUpManagerInit();
            addChildAt(utils.popupMgr.popupCanvas, this.getTooltipsLayerIndex());
            return;
        }

        protected override function getRegCmdName():String
        {
            return APP_REG_CMD;
        }

        protected override function initStage(arg1:flash.events.Event=null):void
        {
            gameInputMgr.initStage(this.stage);
            super.initStage(arg1);
            return;
        }

        internal function getTooltipsLayerIndex():Number
        {
            return getChildIndex(this._toolTips);
        }

        public function as_traceObject(arg1:*):void
        {
            DebugUtils.LOG_DEBUG("traceObject", arg1);
            return;
        }

        public override function get browserBgClass():Class
        {
            return this.browserBgClassValue;
        }

        public override function get systemMessages():flash.display.DisplayObjectContainer
        {
            return this._systemMessages;
        }

        protected override function getNewUtils():net.wg.utils.IUtils
        {
            var loc1:*=new net.wg.infrastructure.managers.utils.impl.Utils(new net.wg.infrastructure.managers.utils.impl.Asserter(), new net.wg.infrastructure.managers.utils.impl.Scheduler(), new net.wg.infrastructure.managers.utils.impl.Locale(), new net.wg.infrastructure.managers.utils.impl.WGJSON(), new net.wg.infrastructure.managers.utils.impl.HelpLayout(), new net.wg.infrastructure.managers.utils.impl.ClassFactory(), new net.wg.infrastructure.managers.utils.impl.PopupManager(), new net.wg.infrastructure.managers.utils.impl.Commons(), new net.wg.infrastructure.managers.utils.impl.FocusHandlerEx(), new net.wg.infrastructure.managers.utils.impl.EventCollector(), new net.wg.infrastructure.managers.utils.impl.IME());
            loc1.setNations(new net.wg.infrastructure.managers.utils.impl.Nations(loc1));
            return loc1;
        }

        protected override function createContainers():void
        {
            this._libraries = new flash.display.MovieClip();
            this._serviceLayout = new net.wg.gui.components.common.ManagedContainer();
            this._serviceLayout.type = net.wg.data.constants.ContainerTypes.SERVICE_LAYOUT;
            this._views = new net.wg.gui.components.common.MainViewContainer();
            this._views.type = net.wg.data.constants.ContainerTypes.VIEW;
            this._windows = new net.wg.gui.components.common.ManagedContainer();
            this._windows.type = net.wg.data.constants.ContainerTypes.WINDOW;
            this._systemMessages = new flash.display.Sprite();
            this._dialogs = new net.wg.gui.components.common.ManagedContainer();
            this._dialogs.type = net.wg.data.constants.ContainerTypes.DIALOG;
            this._toolTips = new flash.display.MovieClip();
            this._cursorCtnr = new net.wg.gui.components.common.CursorManagedContainer();
            this._waitingCtnr = new net.wg.gui.components.common.WaitingManagedContainer();
            super.createContainers();
            return;
        }

        protected override function disposeContainers():void
        {
            super.disposeContainers();
            this._views.dispose();
            this._views = null;
            this._libraries = null;
            this._windows.dispose();
            this._windows = null;
            this._dialogs.dispose();
            this._dialogs = null;
            this._systemMessages = null;
            this._toolTips = null;
            this._serviceLayout.dispose();
            this._serviceLayout = null;
            this._cursorCtnr.dispose();
            this._cursorCtnr = null;
            this._waitingCtnr.dispose();
            this._waitingCtnr = null;
            return;
        }

        protected override function onDispose():void
        {
            this._loader.dispose();
            this._loader = null;
            super.onDispose();
            return;
        }

        protected override function getContainers():__AS3__.vec.Vector.<flash.display.DisplayObject>
        {
            new Vector.<flash.display.DisplayObject>(10)[0] = this._libraries;
            new Vector.<flash.display.DisplayObject>(10)[1] = this._views;
            new Vector.<flash.display.DisplayObject>(10)[2] = this._windows;
            new Vector.<flash.display.DisplayObject>(10)[3] = this._systemMessages;
            new Vector.<flash.display.DisplayObject>(10)[4] = this._dialogs;
            new Vector.<flash.display.DisplayObject>(10)[5] = utils.IME.getContainer();
            new Vector.<flash.display.DisplayObject>(10)[6] = this._toolTips;
            new Vector.<flash.display.DisplayObject>(10)[7] = this._serviceLayout;
            new Vector.<flash.display.DisplayObject>(10)[8] = this._cursorCtnr;
            new Vector.<flash.display.DisplayObject>(10)[9] = this._waitingCtnr;
            var loc1:*=new Vector.<flash.display.DisplayObject>(10);
            return loc1;
        }

        protected override function getNewEnvironment():net.wg.infrastructure.managers.IEnvironmentManager
        {
            return net.wg.infrastructure.managers.impl.EnvironmentManager.getInstance();
        }

        protected override function getNewSoundManager():net.wg.infrastructure.managers.ISoundManager
        {
            return new net.wg.infrastructure.managers.impl.SoundManager();
        }

        protected override function getNewTooltipManager():net.wg.infrastructure.managers.ITooltipMgr
        {
            return new net.wg.infrastructure.managers.impl.ToolTipManager(this._toolTips);
        }

        public static const APP_REG_CMD:String="registerApplication";

        public var browserBgClassValue:Class;

        internal var _librariesList:__AS3__.vec.Vector.<String>;

        internal var _loader:net.wg.infrastructure.helpers.LibraryLoader=null;

        internal var _libraries:flash.display.MovieClip;

        internal var _serviceLayout:net.wg.gui.components.common.ManagedContainer;

        internal var _views:net.wg.gui.components.common.MainViewContainer;

        internal var _windows:net.wg.gui.components.common.ManagedContainer;

        internal var _systemMessages:flash.display.Sprite;

        internal var _dialogs:net.wg.gui.components.common.ManagedContainer;

        internal var _toolTips:flash.display.MovieClip;

        internal var _cursorCtnr:net.wg.gui.components.common.ManagedContainer;

        internal var _waitingCtnr:net.wg.gui.components.common.ManagedContainer;
    }
}
