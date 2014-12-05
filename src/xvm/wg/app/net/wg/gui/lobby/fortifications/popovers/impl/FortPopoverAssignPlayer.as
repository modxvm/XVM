package net.wg.gui.lobby.fortifications.popovers.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextButton;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.data.constants.ColorSchemeNames;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class FortPopoverAssignPlayer extends UIComponent
    {
        
        public function FortPopoverAssignPlayer()
        {
            super();
            this.assignBtn.UIID = 85;
            this.assignBtn.textField.x = this.assignBtn.textField.x + TEXT_PADDING;
            this.assignBtn.addEventListener(ButtonEvent.CLICK,this.onClickAssignPlayerHandler);
            this.assignBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.assignBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
        }
        
        private static var TEXT_PADDING:uint = 6;
        
        private static var FOOTHOLD_BTN_PNG:String = "foothold.png";
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var assignLabl:TextField;
        
        public var garrisonLabl:TextField;
        
        public var assignBtn:IconTextButton;
        
        private var playerCount:int = 0;
        
        private var maxPlayerCount:int = -1;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.assignBtn.icon = FOOTHOLD_BTN_PNG;
            this.garrisonLabl.mouseEnabled = false;
            this.assignLabl.mouseEnabled = false;
        }
        
        override protected function onDispose() : void
        {
            this.assignBtn.removeEventListener(ButtonEvent.CLICK,this.onClickAssignPlayerHandler);
            this.assignBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.assignBtn.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.assignBtn.dispose();
            this.assignBtn = null;
            this.assignLabl = null;
            this.garrisonLabl = null;
            super.onDispose();
        }
        
        public function setData(param1:String, param2:String, param3:int, param4:Boolean, param5:int) : void
        {
            this.maxPlayerCount = param5;
            this.playerCount = param3;
            this.assignBtn.label = param3.toString();
            this.setAssignLabel(param1);
            this.garrisonLabl.htmlText = param2;
            this.assignBtn.enabled = !param4;
            if(!this.assignBtn.enabled)
            {
                this.assignBtn.mouseEnabled = this.assignBtn.mouseChildren = true;
            }
            invalidateData();
        }
        
        private function setAssignLabel(param1:String) : void
        {
            var _loc3_:IUserProps = null;
            var _loc2_:Boolean = !(param1 == null) && (param1.length);
            this.assignLabl.visible = _loc2_;
            if(_loc2_)
            {
                _loc3_ = App.utils.commons.getUserProps(param1);
                _loc3_.rgb = IColorScheme(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAM_SELF)).rgb;
                App.utils.commons.formatPlayerName(this.assignLabl,_loc3_);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.layoutLabels();
            }
        }
        
        private function layoutLabels() : void
        {
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc1_:Number = this.assignBtn.x;
            var _loc2_:Number = 3;
            var _loc3_:Number = this.garrisonLabl.textWidth;
            if(this.assignLabl.visible)
            {
                _loc4_ = this.assignLabl.textWidth;
                _loc5_ = _loc1_ - _loc3_ - _loc4_ - _loc2_ * 4;
                this.garrisonLabl.x = Math.round(_loc5_);
                _loc5_ = _loc5_ + (_loc3_ + _loc2_ * 2);
                this.assignLabl.x = Math.round(_loc5_);
            }
            else
            {
                this.garrisonLabl.x = Math.round(_loc1_ - _loc3_ - _loc2_ * 2);
            }
        }
        
        private function onClickAssignPlayerHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.ASSIGN_PLAYERS));
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = new ComplexTooltipHelper().addHeader(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_POPOVER_FIXEDPLAYERSBTN_HEADER)).addBody(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_POPOVER_FIXEDPLAYERSBTN_BODY,{"count":this.playerCount.toString(),
            "maxCount":this.maxPlayerCount.toString()
        })).addNote("",false).make();
        if(_loc2_.length > 0)
        {
            App.toolTipMgr.showComplex(_loc2_);
        }
    }
}
}
