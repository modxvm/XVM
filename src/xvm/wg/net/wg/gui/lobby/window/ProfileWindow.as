package net.wg.gui.lobby.window 
{
    import flash.display.*;
    import net.wg.data.*;
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    
    public class ProfileWindow extends net.wg.infrastructure.base.meta.impl.ProfileWindowMeta implements net.wg.infrastructure.base.meta.IProfileWindowMeta
    {
        public function ProfileWindow()
        {
            this.maskObj = new flash.display.MovieClip();
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = true;
            showWindowBg = false;
            addChild(this.maskObj);
            return;
        }

        protected override function configUI():void
        {
            var loc1:*;
            super.configUI();
            try 
            {
                registerComponent(this.tabNavigator, net.wg.data.Aliases.PROFILE_TAB_NAVIGATOR);
            }
            catch (e:Error)
            {
                trace(e);
            }
            this.tabNavigator.viewStack.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onSectionViewShowed, false, 0, true);
            this.tabNavigator.centerOffset = net.wg.gui.lobby.profile.ProfileConstants.WINDOW_CENTER_OFFSET;
            addEventListener(net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent.DATA_STATUS_CHANGED, this.techniqueVehicleDataChangeHandler, false, 0, true);
            return;
        }

        internal function onSectionViewShowed(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            this.footer.visible = arg1.view is net.wg.gui.lobby.profile.pages.summary.ProfileSummary;
            return;
        }

        internal function techniqueVehicleDataChangeHandler(arg1:net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent):void
        {
            showWaiting = arg1.dataUnderUpdating;
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            this.initData = new net.wg.gui.lobby.window.ProfileInitVO(arg1);
            invalidate(INIT_DATA_INV);
            return;
        }

        public function as_update(arg1:Object):void
        {
            var loc1:*=arg1 ? arg1.toString() : null;
            var loc2:*=new net.wg.data.gui_items.dossier.AccountDossier(loc1);
            this.tabNavigator.viewStack.updateData(loc2);
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                invalidate(INIT_DATA_INV);
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            super.draw();
            if (isInvalid(INIT_DATA_INV) && window && this.initData) 
            {
                loc1 = this.initData.clanName == net.wg.data.constants.Values.EMPTY_STR ? this.initData.clanName : " [" + this.initData.clanName + "] ";
                net.wg.gui.components.windows.Window(window).title = this.initData.name + loc1;
                loc2 = this.initData.clanName == net.wg.data.constants.Values.EMPTY_STR ? "" : this.initData.clanLabel + " " + "<b>" + loc1 + "</b>" + this.initData.clanNameDescr + ". " + this.initData.clanPosition + ".";
                this.footer.setTexts(loc2, this.initData.registrationDate + ". " + this.initData.lastBattleDate + ".");
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc3 = this.maskObj.graphics;
                loc3.clear();
                loc3.beginFill(6710886);
                loc3.drawRect(0, 0, _width, _height);
                loc3.endFill();
                if (!this.mask) 
                {
                    this.mask = this.maskObj;
                }
                this.tabNavigator.setAvailableSize(_width, _height);
            }
            return;
        }

        protected override function onDispose():void
        {
            this.tabNavigator.viewStack.removeEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onSectionViewShowed);
            removeEventListener(net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent.DATA_STATUS_CHANGED, this.techniqueVehicleDataChangeHandler);
            super.onDispose();
            return;
        }

        public static const INIT_DATA_INV:String="initDataInv";

        public var tabNavigator:net.wg.gui.lobby.profile.ProfileTabNavigator;

        public var maskObj:flash.display.MovieClip;

        public var footer:net.wg.gui.lobby.profile.components.ProfileWindowFooter;

        internal var initData:net.wg.gui.lobby.window.ProfileInitVO;
    }
}
