package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.ContextMenuManagerMeta;
    import net.wg.infrastructure.managers.IContextMenuManager;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import net.wg.infrastructure.interfaces.IContextMenuListener;
    import flash.display.DisplayObject;
    import net.wg.data.daapi.ContextMenuOptionsVO;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.utils.IClassFactory;
    import net.wg.data.constants.Linkages;
    import flash.geom.Point;
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    import net.wg.data.daapi.PlayerInfo;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class ContextMenuManager extends ContextMenuManagerMeta implements IContextMenuManager
    {
        
        public function ContextMenuManager()
        {
            super();
        }
        
        private var _currentMenu:IContextMenu = null;
        
        private var _handler:Function = null;
        
        private var _listener:IContextMenuListener = null;
        
        private var _extraHandler:Function = null;
        
        public function showNewWrapper(param1:String, param2:String, param3:DisplayObject, param4:Object = null, param5:IContextMenuListener = null) : void
        {
            this._listener = param5;
            this.showNew(param1,param2,param3,param4);
        }
        
        public function showNew(param1:String, param2:String, param3:DisplayObject, param4:Object = null) : void
        {
            this.hide();
            this._handler = this.onItemSelect;
            this._currentMenu = this.constructMenu(null,param3);
            requestOptionsS(param1,param2,param4);
        }
        
        override protected function setOptions(param1:ContextMenuOptionsVO) : void
        {
            //assert(this._currentMenu,"Current context menu is null in setOptions call");
            this._currentMenu.build(param1.options,this._currentMenu.clickPoint);
        }
        
        private function onItemSelect(param1:ContextMenuEvent) : void
        {
            onOptionSelectS(param1.id);
            if(this._listener)
            {
                this._listener.onOptionSelect(param1.id);
            }
        }
        
        public function show(param1:Vector.<IContextItem>, param2:DisplayObject, param3:Function = null, param4:Object = null) : IContextMenu
        {
            this.hide();
            this._handler = param3;
            this._currentMenu = this.constructMenu(param1,param2);
            if(param4)
            {
                this._currentMenu.setMemberItemData(param4);
            }
            return this._currentMenu;
        }
        
        protected function constructMenu(param1:Vector.<IContextItem>, param2:DisplayObject) : IContextMenu
        {
            var _loc3_:IClassFactory = App.utils.classFactory;
            var _loc4_:IContextMenu = _loc3_.getComponent(Linkages.CONTEXT_MENU,IContextMenu);
            var _loc5_:DisplayObject = DisplayObject(_loc4_);
            var _loc6_:Point = param2.localToGlobal(new Point(param2.mouseX,param2.mouseY));
            App.utils.popupMgr.show(_loc5_,_loc6_.x,_loc6_.y);
            _loc4_.build(param1,_loc6_);
            if(this._handler != null)
            {
                _loc5_.addEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.onContextMenuAction);
            }
            _loc5_.addEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.closeEventHandler);
            _loc5_.stage.addEventListener(Event.RESIZE,this.closeEventHandler);
            return _loc4_;
        }
        
        public function showUserContextMenu(param1:DisplayObject, param2:Object, param3:IUserContextMenuGenerator, param4:Function = null) : IContextMenu
        {
            var _loc5_:PlayerInfo = null;
            var _loc6_:* = NaN;
            var _loc7_:Vector.<IContextItem> = null;
            if(param2.uid > -1 && !param2.himself)
            {
                _loc5_ = new PlayerInfo(_getUserInfoS(param2.uid,param2.userName));
                _loc6_ = _getDenunciationsS();
                _loc7_ = param3.generateData(_loc5_,_loc6_);
                this._extraHandler = param4;
                return this.show(_loc7_,param1,this.handleUserContextMenu,param2);
            }
            return null;
        }
        
        public function showFortificationCtxMenu(param1:DisplayObject, param2:Vector.<IContextItem>, param3:Object = null) : IContextMenu
        {
            return this.show(param2,param1,this.handleUserContextMenu,param3);
        }
        
        public function canGiveLeadershipTo(param1:Number) : Boolean
        {
            return canGiveLeadershipS(param1);
        }
        
        public function canInviteThe(param1:Number) : Boolean
        {
            return canInviteS(param1);
        }
        
        public function hide() : void
        {
            var _loc1_:DisplayObject = null;
            if(this._currentMenu != null)
            {
                _loc1_ = DisplayObject(this._currentMenu);
                if(!(this._handler == null) && (_loc1_.hasEventListener(ContextMenuEvent.ON_ITEM_SELECT)))
                {
                    _loc1_.removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.onContextMenuAction);
                    this._handler = null;
                }
                if(_loc1_.hasEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE))
                {
                    _loc1_.removeEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.closeEventHandler);
                }
                if((_loc1_.stage) && (_loc1_.stage.hasEventListener(Event.RESIZE)))
                {
                    _loc1_.stage.removeEventListener(Event.RESIZE,this.closeEventHandler);
                }
                if(this._currentMenu is IDisposable)
                {
                    IDisposable(this._currentMenu).dispose();
                }
                App.utils.popupMgr.popupCanvas.removeChild(_loc1_);
                this._currentMenu = null;
                this._extraHandler = null;
                this._listener = null;
            }
            if(!disposed)
            {
                onHideS();
            }
        }
        
        public function dispose() : void
        {
            this.hide();
        }
        
        private function handleUserContextMenu(param1:ContextMenuEvent) : void
        {
            var _loc2_:Object = param1.memberItemData;
            switch(param1.id)
            {
                case "userInfo":
                    showUserInfoS(_loc2_.uid,_loc2_.userName);
                    break;
                case "offend":
                case "flood":
                case "blackmail":
                case "swindle":
                case "notFairPlay":
                case "forbiddenNick":
                case "bot":
                    appealS(_loc2_.uid,_loc2_.userName,param1.id);
                    break;
                case "createPrivateChannel":
                    createPrivateChannelS(_loc2_.uid,_loc2_.userName);
                    break;
                case "addToFriends":
                    addFriendS(_loc2_.uid,_loc2_.userName);
                    break;
                case "removeFromFriends":
                    removeFriendS(_loc2_.uid);
                    break;
                case "addToIgnored":
                    setIgnoredS(_loc2_.uid,_loc2_.userName);
                    break;
                case "removeFromIgnored":
                    unsetIgnoredS(_loc2_.uid);
                    break;
                case "copyToClipBoard":
                    copyToClipboardS(_loc2_.userName);
                    break;
                case "setMuted":
                    setMutedS(_loc2_.uid,_loc2_.userName);
                    break;
                case "unsetMuted":
                    unsetMutedS(_loc2_.uid);
                    break;
                case "kickPlayerFromPrebattle":
                    kickPlayerFromPrebattleS(_loc2_.kickId);
                    break;
                case "kickPlayerFromUnit":
                    kickPlayerFromUnitS(_loc2_.kickId);
                    break;
                case "giveLeadership":
                    giveLeadershipS(_loc2_.uid);
                    break;
                case "createSquad":
                    createSquadS(_loc2_.uid);
                    break;
                case "invite":
                    inviteS(_loc2_.uid,_loc2_);
                    break;
                case "ctxActionDirectionControl":
                    fortDirectionS();
                    break;
                case "ctxActionAssignPlayers":
                    fortAssignPlayersS(_loc2_);
                    break;
                case "ctxActionModernization":
                    fortModernizationS(_loc2_);
                    break;
                case "ctxActionDestroy":
                    fortDestroyS(_loc2_);
                    break;
                case "ctxActionPrepareOrder":
                    fortPrepareOrderS(_loc2_);
                    break;
            }
            if(this._extraHandler != null)
            {
                this._extraHandler(param1);
            }
            this.hide();
        }
        
        private function closeEventHandler(param1:Event) : void
        {
            this.hide();
        }
        
        private function onContextMenuAction(param1:ContextMenuEvent) : void
        {
            if(this._handler != null)
            {
                this._handler(param1);
                this.hide();
            }
        }
    }
}
