package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleTimer;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.fortifications.data.BattleDirectionRendererVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.fortifications.events.JoinFortBattleEvent;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
    
    public class BattleDirectionRenderer extends TableRenderer
    {
        
        public function BattleDirectionRenderer()
        {
            super();
        }
        
        private static var DEFAULT_INFO_WIDTH:int = 135;
        
        private static function checkTooltipOnScroll(param1:Boolean, param2:String) : void
        {
            if(param1)
            {
                if(param2)
                {
                    App.toolTipMgr.showComplex(param2);
                }
                else
                {
                    App.toolTipMgr.hide();
                }
            }
        }
        
        private static var X_OFFSET:int = -5;
        
        private static var Y_OFFSET:int = -2;
        
        private static var TIMER_PADDING:int = 17;
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var battleType:UILoaderAlt;
        
        public var battleDescrTF:TextField;
        
        public var timeTF:TextField;
        
        public var battleInfoTF:TextField;
        
        public var joinBtn:SoundButtonEx;
        
        public var timer:ClanBattleTimer;
        
        private var _isMouseOverBattleType:Boolean = false;
        
        private var _isMouseOverBattleInfo:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.joinBtn.addEventListener(ButtonEvent.CLICK,this.handleJoinClick);
            this.joinBtn.label = FORTIFICATIONS.SORTIE_INTROVIEW_FORTBATTLES_BTNLABEL;
            this.joinBtn.preventAutosizing = true;
            this.battleType.mouseChildren = false;
            this.addListeners();
        }
        
        private function addListeners() : void
        {
            this.battleType.addEventListener(MouseEvent.MOUSE_OVER,this.showBattleTypeTooltip);
            this.battleType.addEventListener(MouseEvent.MOUSE_OUT,this.onBattleTypeRollOut);
            this.battleType.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.battleInfoTF.addEventListener(MouseEvent.MOUSE_OVER,this.showBattleInfoTooltip);
            this.battleInfoTF.addEventListener(MouseEvent.MOUSE_OUT,this.onBattleInfoRollOut);
            this.battleInfoTF.addEventListener(MouseEvent.CLICK,hideTooltip);
        }
        
        override protected function onDispose() : void
        {
            this.removeListeners();
            this.timer.dispose();
            this.timer = null;
            this.battleType.dispose();
            this.battleType = null;
            this.battleDescrTF = null;
            this.timeTF = null;
            this.battleInfoTF = null;
            this.joinBtn.dispose();
            this.joinBtn = null;
            super.onDispose();
        }
        
        private function removeListeners() : void
        {
            this.joinBtn.removeEventListener(ButtonEvent.CLICK,this.handleJoinClick);
            this.battleType.removeEventListener(MouseEvent.MOUSE_OVER,this.showBattleTypeTooltip);
            this.battleType.removeEventListener(MouseEvent.MOUSE_OUT,this.onBattleTypeRollOut);
            this.battleType.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.battleInfoTF.removeEventListener(MouseEvent.MOUSE_OVER,this.showBattleInfoTooltip);
            this.battleInfoTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onBattleInfoRollOut);
            this.battleInfoTF.removeEventListener(MouseEvent.CLICK,hideTooltip);
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = param1;
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            var _loc1_:BattleDirectionRendererVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(_data)
                {
                    _loc1_ = BattleDirectionRendererVO(_data);
                    this.visible = true;
                    this.battleDescrTF.htmlText = _loc1_.description;
                    this.timeTF.autoSize = TextFieldAutoSize.LEFT;
                    this.timeTF.htmlText = _loc1_.battleHour;
                    this.joinBtn.visible = _loc1_.canJoin;
                    this.timeTF.visible = !_loc1_.canJoin;
                    this.battleType.source = _loc1_.battleTypeIcon;
                    this.setBattleInfo(_loc1_.canJoin,_loc1_);
                    checkTooltipOnScroll(this._isMouseOverBattleType,_loc1_.battleTypeTooltip);
                    checkTooltipOnScroll(this._isMouseOverBattleInfo,_loc1_.battleInfoTooltip);
                }
                else
                {
                    this.visible = false;
                }
            }
        }
        
        private function handleJoinClick(param1:ButtonEvent) : void
        {
            var _loc2_:* = 0;
            if(data)
            {
                _loc2_ = BattleDirectionRendererVO(_data).fortBattleID;
                dispatchEvent(new JoinFortBattleEvent(JoinFortBattleEvent.JOIN_FORT_BATTLE,_loc2_));
            }
        }
        
        private function setBattleInfo(param1:Boolean, param2:BattleDirectionRendererVO) : void
        {
            this.battleInfoTF.htmlText = param2.battleInfo;
            this.checkTimer(param2);
        }
        
        private function checkTimer(param1:BattleDirectionRendererVO) : void
        {
            var _loc2_:ClanBattleTimerVO = null;
            var _loc3_:Date = null;
            var _loc4_:* = NaN;
            if(param1.timer)
            {
                this.battleInfoTF.width = DEFAULT_INFO_WIDTH - this.timer.width + TIMER_PADDING;
                this.timer.visible = true;
                _loc2_ = new ClanBattleTimerVO({});
                _loc2_.htmlFormatter = param1.timer.htmlFormatter;
                _loc3_ = App.utils.dateTime.now();
                _loc4_ = App.utils.dateTime.toPyTimestamp(_loc3_);
                _loc2_.deltaTime = param1.timer.battleStartTime - _loc4_;
                this.timer.setData(_loc2_);
                App.utils.commons.moveDsiplObjToEndOfText(this.timer,this.battleInfoTF,X_OFFSET,Y_OFFSET);
            }
            else
            {
                this.battleInfoTF.width = DEFAULT_INFO_WIDTH;
                this.timer.visible = false;
                this.timer.x = 0;
            }
        }
        
        private function showBattleTypeTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            this._isMouseOverBattleType = true;
            if(data)
            {
                _loc2_ = BattleDirectionRendererVO(_data).battleTypeTooltip;
                if(_loc2_)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        private function showBattleInfoTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            this._isMouseOverBattleInfo = true;
            if(data)
            {
                _loc2_ = BattleDirectionRendererVO(_data).battleInfoTooltip;
                if(_loc2_)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        private function onBattleTypeRollOut(param1:MouseEvent) : void
        {
            this._isMouseOverBattleType = false;
            App.toolTipMgr.hide();
        }
        
        private function onBattleInfoRollOut(param1:MouseEvent) : void
        {
            this._isMouseOverBattleInfo = false;
            App.toolTipMgr.hide();
        }
    }
}
