package net.wg.infrastructure.managers.impl 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.utils.*;
    
    public class ContextMenuManager extends net.wg.infrastructure.base.meta.impl.ContextMenuManagerMeta implements net.wg.infrastructure.managers.IContextMenuManager
    {
        public function ContextMenuManager()
        {
            super();
            return;
        }

        public function show(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>, arg2:flash.display.DisplayObject, arg3:Function=null, arg4:Object=null):net.wg.infrastructure.interfaces.IContextMenu
        {
            this.hide();
            this._handler = arg3;
            var loc1:*=App.utils.classFactory;
            this._currentMenu = loc1.getComponent(net.wg.data.constants.Linkages.CONTEXT_MENU, net.wg.infrastructure.interfaces.IContextMenu);
            App.utils.popupMgr.show(flash.display.DisplayObject(this._currentMenu), arg2.mouseX, arg2.mouseY);
            var loc2:*=arg2.localToGlobal(new flash.geom.Point(arg2.mouseX, arg2.mouseY));
            this._currentMenu.build(arg1, loc2.x, loc2.y);
            if (arg4) 
            {
                this._currentMenu.setMemberItemData(arg4);
            }
            if (this._handler != null) 
            {
                flash.display.DisplayObject(this._currentMenu).addEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.onContextMenuAction);
            }
            flash.display.DisplayObject(this._currentMenu).addEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE, this.destroy);
            flash.display.DisplayObject(this._currentMenu).stage.addEventListener(flash.events.Event.RESIZE, this.destroy);
            return this._currentMenu;
        }

        public function showUserContextMenu(arg1:flash.display.DisplayObject, arg2:Object, arg3:net.wg.infrastructure.interfaces.IUserContextMenuGenerator, arg4:Function=null):net.wg.infrastructure.interfaces.IContextMenu
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=null;
            if (arg2.uid > -1 && !arg2.himself) 
            {
                loc1 = new net.wg.data.daapi.PlayerInfo(_getUserInfoS(arg2.uid, arg2.userName));
                loc2 = _getDenunciationsS();
                loc3 = arg3.generateData(loc1, loc2);
                this._extraHandler = arg4;
                return this.show(loc3, arg1, this.handleUserContextMenu, arg2);
            }
            return null;
        }

        internal function handleUserContextMenu(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=arg1.memberItemData;
            var loc2:*=arg1.id;
            switch (loc2) 
            {
                case "userInfo":
                {
                    showUserInfoS(loc1.uid, loc1.userName);
                    break;
                }
                case "offend":
                case "flood":
                case "openingOfAllyPos":
                case "allyEjection":
                case "notFairPlay":
                case "teamKill":
                case "bot":
                {
                    appealS(loc1.uid, loc1.userName, arg1.id);
                    break;
                }
                case "createPrivateChannel":
                {
                    createPrivateChannelS(loc1.uid, loc1.userName);
                    break;
                }
                case "addToFriends":
                {
                    addFriendS(loc1.uid, loc1.userName);
                    break;
                }
                case "removeFromFriends":
                {
                    removeFriendS(loc1.uid);
                    break;
                }
                case "addToIgnored":
                {
                    setIgnoredS(loc1.uid, loc1.userName);
                    break;
                }
                case "removeFromIgnored":
                {
                    unsetIgnoredS(loc1.uid);
                    break;
                }
                case "copyToClipBoard":
                {
                    copyToClipboardS(loc1.userName);
                    break;
                }
                case "setMuted":
                {
                    setMutedS(loc1.uid, loc1.userName);
                    break;
                }
                case "unsetMuted":
                {
                    unsetMutedS(loc1.uid);
                    break;
                }
                case "kickPlayer":
                {
                    kickPlayerS(loc1.accID);
                    break;
                }
                default:
                {
                    if (this._extraHandler != null) 
                    {
                        this._extraHandler(arg1);
                    }
                }
            }
            this.hide();
            return;
        }

        internal function destroy(arg1:flash.events.Event):void
        {
            this.hide();
            return;
        }

        internal function onContextMenuAction(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            if (this._handler != null) 
            {
                this._handler(arg1);
                this.hide();
            }
            return;
        }

        public function hide():void
        {
            if (this._currentMenu != null) 
            {
                if (!(this._handler == null) && flash.display.DisplayObject(this._currentMenu).hasEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT)) 
                {
                    flash.display.DisplayObject(this._currentMenu).removeEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.onContextMenuAction);
                    this._handler = null;
                }
                if (flash.display.DisplayObject(this._currentMenu).hasEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE)) 
                {
                    flash.display.DisplayObject(this._currentMenu).removeEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE, this.destroy);
                }
                if (flash.display.DisplayObject(this._currentMenu).stage.hasEventListener(flash.events.Event.RESIZE)) 
                {
                    flash.display.DisplayObject(this._currentMenu).stage.removeEventListener(flash.events.Event.RESIZE, this.destroy);
                }
                if (this._currentMenu is net.wg.infrastructure.interfaces.entity.IDisposable) 
                {
                    net.wg.infrastructure.interfaces.entity.IDisposable(this._currentMenu).dispose();
                }
                App.utils.popupMgr.popupCanvas.removeChild(flash.display.DisplayObject(this._currentMenu));
                this._currentMenu = null;
                this._extraHandler = null;
            }
            return;
        }

        public function dispose():void
        {
            this.hide();
            return;
        }

        internal var _currentMenu:net.wg.infrastructure.interfaces.IContextMenu=null;

        internal var _handler:Function=null;

        internal var _extraHandler:Function=null;

        internal var _data:Object=null;
    }
}
