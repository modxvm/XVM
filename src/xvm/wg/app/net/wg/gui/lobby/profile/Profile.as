package net.wg.gui.lobby.profile 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class Profile extends net.wg.infrastructure.base.meta.impl.ProfileMeta implements net.wg.infrastructure.base.meta.IProfileMeta
    {
        public function Profile()
        {
            super();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onCloseProfileS();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            registerComponent(this.tabNavigator, net.wg.data.Aliases.PROFILE_TAB_NAVIGATOR);
            this.tabNavigator.centerOffset = net.wg.gui.lobby.profile.ProfileConstants.MAIN_CENTER_OFFSET;
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        public function as_update(arg1:Object):void
        {
            var loc1:*=arg1 ? arg1.toString() : null;
            var loc2:*=new net.wg.data.gui_items.dossier.AccountDossier(loc1);
            this.tabNavigator.viewStack.updateData(loc2);
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            setViewSize(arg1, arg2);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.background.width = _width;
                this.background.height = _height;
                this.tabNavigator.setAvailableSize(_width, _height - this.tabNavigator.y);
                this.headerBackground.x = _width - this.headerBackground.width >> 1;
                this.mainBackground.x = _width - this.mainBackground.width >> 1;
            }
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            super.onDispose();
            return;
        }

        public var background:flash.display.Sprite;

        public var headerBackground:flash.display.Sprite;

        public var mainBackground:flash.display.Sprite;

        public var tabNavigator:net.wg.gui.lobby.profile.ProfileTabNavigator;
    }
}
