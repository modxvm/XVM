package net.wg.gui.prebattle.squad
{
    import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
    import net.wg.gui.components.advanced.InviteIndicator;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.data.VO.ExtendedUserVO;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    
    public class SquadSlotRenderer extends VoiceRallySlotRenderer
    {
        
        public function SquadSlotRenderer()
        {
            super();
        }
        
        public var inviteIndicator:InviteIndicator = null;
        
        private var _isCreator:Boolean = false;
        
        override protected function configUI() : void
        {
            tooltipSubscribeListOfControls.push(statusIndicator);
            super.configUI();
            commander.visible = false;
            statusIndicator.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
        }
        
        override protected function onDispose() : void
        {
            statusIndicator.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            super.onDispose();
        }
        
        override public function set slotData(param1:IRallySlotVO) : void
        {
            visible = Boolean(param1);
            super.slotData = param1;
        }
        
        override public function setStatus(param1:int) : String
        {
            var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
            if(param1 < STATUSES.length && (param1))
            {
                _loc2_ = STATUSES[param1];
            }
            statusIndicator.status = _loc2_;
            return _loc2_;
        }
        
        override protected function onContextMenuAreaClick(param1:MouseEvent) : void
        {
            var _loc2_:ExtendedUserVO = null;
            var _loc3_:* = false;
            var _loc4_:IUserContextMenuGenerator = null;
            if(App.utils.commons.isRightButton(param1))
            {
                _loc2_ = slotData?slotData.player as ExtendedUserVO:null;
                if((_loc2_) && (!_loc2_.himself) && _loc2_.accID > -1)
                {
                    _loc3_ = _loc2_.dbID > -1;
                    _loc4_ = new SquadWindowCIGenerator(_loc3_,this.isCreator);
                    App.contextMenuMgr.showUserContextMenu(this,_loc2_,_loc4_);
                }
            }
        }
        
        override protected function initControlsState() : void
        {
            if(!helper)
            {
                return;
            }
            super.initControlsState();
        }
        
        override public function updateComponents() : void
        {
            if(!helper)
            {
                return;
            }
            super.updateComponents();
        }
        
        public function set isCreator(param1:Boolean) : void
        {
            this._isCreator = param1;
        }
        
        public function get isCreator() : Boolean
        {
            return this._isCreator;
        }
    }
}
