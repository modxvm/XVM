package net.wg.gui.lobby.retrainCrewWindow
{
    import net.wg.infrastructure.base.meta.impl.RetrainCrewWindowMeta;
    import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
    import net.wg.gui.components.advanced.DashLine;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import scaleform.clik.controls.Button;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
    import net.wg.gui.lobby.questsWindow.VehicleBlock;
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.common.containers.HorizontalGroupLayout;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
    import net.wg.data.constants.IconsTypes;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import scaleform.clik.utils.Padding;
    
    public class RetrainCrewWindow extends RetrainCrewWindowMeta implements IRetrainCrewWindowMeta
    {
        
        public function RetrainCrewWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            canClose = true;
        }
        
        private static var VEHICLE_BLOCK_INVALID:String = "vehBlockInv";
        
        private static var CREW_BLOCK_INVALID:String = "crewBlockInv";
        
        private static var PRICE_INVALID:String = "priceInv";
        
        private static var SIDE_PADDING:uint = 12;
        
        private static var RESULT_ICON_PADDING:uint = 19;
        
        private static var NOT_ENOUGH_MONEY_COLOR:uint = 16711680;
        
        public var btnsGroup:RetrainCrewMainButtons;
        
        public var separator:DashLine;
        
        public var txtCrewMembers:TextField;
        
        public var txtPercent:TextField;
        
        public var txtTechnics:TextField;
        
        public var summIconText:IconText;
        
        public var resultIcon:IconText;
        
        public var submitBtn:Button;
        
        public var cancelBtn:Button;
        
        public var shadowSeparator:MovieClip;
        
        public var result:ColoredDeshLineTextItem;
        
        public var vehicleBlock:VehicleBlock;
        
        private var initVehicleVO:RetrainCrewVehicleVO;
        
        private var initCrewVO:RetrainCrewBlockVO;
        
        private var initCrewOperationVO:RetrainCrewOperationVO;
        
        private var enough_money_color:uint = 16777215;
        
        public var rolesGroup:GroupEx;
        
        override protected function configUI() : void
        {
            var _loc1_:ILocale = null;
            super.configUI();
            this.enough_money_color = this.result.valueTextField.textColor;
            this.rolesGroup.layout = new HorizontalGroupLayout();
            this.rolesGroup.itemRendererClass = App.utils.classFactory.getClass("RetrainCrewRoleIR_UI");
            this.rolesGroup.addEventListener(Event.RESIZE,this.groupResizeHandler,false,0,true);
            _loc1_ = App.utils.locale;
            this.submitBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_SUBMIT);
            this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitClickHandler,false,0,true);
            this.cancelBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_CANCEL);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelClickHandler,false,0,true);
            this.txtTechnics.text = _loc1_.makeString(RETRAIN_CREW.LABEL_ONTHETECHNICS);
            this.txtPercent.text = _loc1_.makeString(RETRAIN_CREW.LABEL_EXPERIENCERETENTION);
            this.result.label = _loc1_.makeString(RETRAIN_CREW.LABEL_RESULT);
            this.separator.x = this.result.x = SIDE_PADDING;
            var _loc2_:Number = _width - SIDE_PADDING * 2;
            this.separator.width = _loc2_;
            this.result.width = _loc2_ - RESULT_ICON_PADDING;
            this.btnsGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.btnsGroupChangeHandler,false,0,true);
        }
        
        override protected function draw() : void
        {
            var _loc2_:QuestsDashlineItem = null;
            var _loc3_:SelPriceInfo = null;
            var _loc4_:uint = 0;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            var _loc7_:* = false;
            super.draw();
            if((isInvalid(VEHICLE_BLOCK_INVALID)) && (this.initVehicleVO))
            {
                this.vehicleBlock.validateNow();
                _loc2_ = this.vehicleBlock.discountDL;
                _loc2_.validateNow();
                this.vehicleBlock.x = Math.round(_width - (_loc2_.x + _loc2_.labelTextField.x + _loc2_.labelTextField.textWidth + RESULT_ICON_PADDING));
            }
            var _loc1_:ILocale = App.utils.locale;
            if((isInvalid(CREW_BLOCK_INVALID)) && (this.initCrewVO))
            {
                this.rolesGroup.dataProvider = this.initCrewVO.crewInfoVO;
                this.txtCrewMembers.htmlText = _loc1_.makeString(RETRAIN_CREW.LABEL_CREWMEMBERS) + " <font color=\'#E9E2BF\' size=\'15\'>" + this.initCrewVO.crewInfoVO.length.toString() + "</font>";
                invalidate(PRICE_INVALID);
            }
            if((isInvalid(PRICE_INVALID)) && (this.initCrewVO.priceInfo))
            {
                _loc3_ = this.initCrewVO.priceInfo;
                _loc4_ = this.rolesGroup.dataProvider.length;
                _loc5_ = 0;
                this.resultIcon.icon = this.summIconText.icon = _loc3_.isGold?IconsTypes.GOLD:IconsTypes.CREDITS;
                _loc6_ = _loc3_.price;
                if(this.btnsGroup.selectedId != -1)
                {
                    if(_loc3_.currency == IconsTypes.GOLD)
                    {
                        _loc7_ = this.btnsGroup.operationData.gold >= _loc6_;
                        _loc5_ = this.initCrewOperationVO.tankmanCost[this.btnsGroup.selectedId].gold;
                    }
                    else
                    {
                        _loc7_ = this.btnsGroup.operationData.credits >= _loc6_;
                        _loc5_ = this.initCrewOperationVO.tankmanCost[this.btnsGroup.selectedId].credits;
                    }
                    this.summIconText.text = _loc4_ + " x " + _loc1_.integer(_loc5_);
                    this.result.valueTextColor = _loc7_?IconsTypes.getTextColor(this.resultIcon.icon):NOT_ENOUGH_MONEY_COLOR;
                    this.submitBtn.enabled = _loc7_;
                }
                this.result.value = _loc1_.integer(_loc6_);
            }
        }
        
        private function btnsGroupChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:Object = null;
            if(param1.index != -1)
            {
                _loc2_ = changeRetrainTypeS(param1.index);
                this.initCrewVO = new RetrainCrewBlockVO(_loc2_);
                invalidate(CREW_BLOCK_INVALID);
            }
            else
            {
                this.summIconText.text = "0 x 0";
                this.result.valueTextColor = this.enough_money_color;
                this.result.value = "0";
                this.submitBtn.enabled = false;
            }
        }
        
        private function groupResizeHandler(param1:Event) : void
        {
            this.rolesGroup.x = _width - this.rolesGroup.width - SIDE_PADDING;
        }
        
        private function submitClickHandler(param1:ButtonEvent) : void
        {
            submitS({"operationId":this.btnsGroup.selectedId});
        }
        
        private function cancelClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        override public function setWindow(param1:IWindow) : void
        {
            super.setWindow(param1);
            window.title = App.utils.locale.makeString(RETRAIN_CREW.WINDOW_TITLE);
            var _loc2_:Padding = window.contentPadding as Padding;
            var _loc3_:Number = this.cancelBtn.height;
            _loc2_.bottom = _loc2_.bottom - (this.shadowSeparator.y + this.shadowSeparator.height - (_loc3_ + this.cancelBtn.y));
            param1.contentPadding = _loc2_;
            var _loc4_:* = param1.formBgPadding;
            _loc4_.bottom = _loc4_.bottom + (_loc3_ + 4);
            param1.formBgPadding = _loc4_;
        }
        
        override protected function onDispose() : void
        {
            if(this.initVehicleVO)
            {
                this.initVehicleVO.dispose();
                this.initVehicleVO = null;
            }
            if(this.initCrewVO)
            {
                this.initCrewVO.dispose();
                this.initCrewVO = null;
            }
            this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitClickHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelClickHandler);
            this.btnsGroup.dispose();
            this.btnsGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.btnsGroupChangeHandler);
            if(this.rolesGroup)
            {
                this.rolesGroup.removeEventListener(Event.RESIZE,this.groupResizeHandler);
                this.rolesGroup.dispose();
                if(this.rolesGroup.parent)
                {
                    this.rolesGroup.parent.removeChild(this.rolesGroup);
                }
                this.rolesGroup = null;
            }
            super.onDispose();
        }
        
        public function as_setCommonData(param1:Object) : void
        {
            this.initVehicleVO = new RetrainCrewVehicleVO(param1);
            this.vehicleBlock.setData(this.initVehicleVO.vehicleBlockVO);
            this.initCrewVO = new RetrainCrewBlockVO(param1);
            this.rolesGroup.dataProvider = this.initCrewVO.crewInfoVO;
            this.btnsGroup.crewInfo = this.initCrewVO.crewInfoVO;
            this.btnsGroup.currentVehicleType = this.initVehicleVO.vehicleBlockVO.vType;
            this.btnsGroup.currentVehicleIntCD = this.initVehicleVO.vehicleBlockVO.vIntCD;
            this.txtCrewMembers.htmlText = App.utils.locale.makeString(RETRAIN_CREW.LABEL_CREWMEMBERS) + " <font color=\'#E9E2BF\' size=\'15\'>" + this.initCrewVO.crewInfoVO.length.toString() + "</font>";
            invalidate(VEHICLE_BLOCK_INVALID);
        }
        
        public function as_updateData(param1:Object) : void
        {
            this.initCrewOperationVO = new RetrainCrewOperationVO(param1);
            this.btnsGroup.operationData = this.initCrewOperationVO;
        }
    }
}
