package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.infrastructure.base.meta.impl.RetrainCrewWindowMeta;
   import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
   import net.wg.gui.lobby.profile.components.DashLine;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import scaleform.clik.controls.Button;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
   import net.wg.gui.lobby.questsWindow.VehicleBlock;
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.gui.components.common.containers.HorizontalGroupLayout;
   import flash.events.Event;
   import net.wg.utils.ILocale;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import net.wg.data.constants.IconsTypes;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;


   public class RetrainCrewWindow extends RetrainCrewWindowMeta implements IRetrainCrewWindowMeta
   {
          
      public function RetrainCrewWindow() {
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
         canClose = true;
      }

      private static const VEHICLE_BLOCK_INVALID:String = "vehBlockInv";

      private static const SIDE_PADDING:uint = 12;

      private static const RESULT_ICON_PADDING:uint = 19;

      private static const NOT_ENOUGH_MONEY_COLOR:uint = 16711680;

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

      private var initVO:RetrainCrewVO;

      private var enough_money_color:uint = 16777215;

      public var rolesGroup:GroupEx;

      override protected function configUI() : void {
         var _loc2_:* = NaN;
         super.configUI();
         this.enough_money_color = this.result.valueTextField.textColor;
         this.rolesGroup.layout = new HorizontalGroupLayout();
         this.rolesGroup.itemRendererClass = App.utils.classFactory.getClass("RetrainCrewRoleIR_UI");
         this.rolesGroup.addEventListener(Event.RESIZE,this.groupResizeHandler,false,0,true);
         var _loc1_:ILocale = App.utils.locale;
         this.submitBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_SUBMIT);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitClickHandler,false,0,true);
         this.cancelBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_CANCEL);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelClickHandler,false,0,true);
         this.txtTechnics.text = _loc1_.makeString(RETRAIN_CREW.LABEL_ONTHETECHNICS);
         this.txtPercent.text = _loc1_.makeString(RETRAIN_CREW.LABEL_EXPERIENCERETENTION);
         this.result.label = _loc1_.makeString(RETRAIN_CREW.LABEL_RESULT);
         this.separator.x = this.result.x = SIDE_PADDING;
         _loc2_ = _width - SIDE_PADDING * 2;
         this.separator.width = _loc2_;
         this.result.width = _loc2_ - RESULT_ICON_PADDING;
         this.btnsGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.btnsGroupChangeHandler,false,0,true);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(VEHICLE_BLOCK_INVALID))
         {
            this.vehicleBlock.validateNow();
            this.vehicleBlock.discountDL.validateNow();
            this.vehicleBlock.x = Math.round(_width - (this.vehicleBlock.discountDL.x + this.vehicleBlock.discountDL.labelTextField.x + this.vehicleBlock.discountDL.labelTextField.textWidth + RESULT_ICON_PADDING));
         }
      }

      private function btnsGroupChangeHandler(param1:IndexEvent) : void {
         var _loc5_:* = false;
         var _loc2_:SelPriceInfo = SelPriceInfo(param1.data);
         var _loc3_:uint = this.rolesGroup.dataProvider.length;
         this.summIconText.text = _loc3_ + " x " + _loc2_.price;
         this.resultIcon.icon = this.summIconText.icon = _loc2_.currency != IconsTypes.GOLD?IconsTypes.CREDITS:IconsTypes.GOLD;
         var _loc4_:Number = _loc3_ * _loc2_.price;
         this.result.value = _loc4_.toString();
         if(_loc2_.currency == IconsTypes.GOLD)
         {
            _loc5_ = this.btnsGroup.operationData.gold >= _loc4_;
         }
         else
         {
            _loc5_ = this.btnsGroup.operationData.credits >= _loc4_;
         }
         this.result.valueTextColor = _loc5_?this.enough_money_color:NOT_ENOUGH_MONEY_COLOR;
         this.result.value = _loc4_.toString();
         this.submitBtn.enabled = _loc5_;
      }

      private function groupResizeHandler(param1:Event) : void {
         this.rolesGroup.x = _width - this.rolesGroup.width - SIDE_PADDING;
      }

      private function submitClickHandler(param1:ButtonEvent) : void {
         submitS({"operationId":this.btnsGroup.selectedId});
      }

      private function cancelClickHandler(param1:ButtonEvent) : void {
         onWindowCloseS();
      }

      override public function setWindow(param1:IWindow) : void {
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

      override protected function onDispose() : void {
         if(this.initVO)
         {
            this.initVO.dispose();
            this.initVO = null;
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

      public function as_setCommonData(param1:Object) : void {
         this.initVO = new RetrainCrewVO(param1);
         this.vehicleBlock.setData(this.initVO.vehicleBlockVO);
         this.rolesGroup.dataProvider = this.initVO.crewInfoVO;
         this.btnsGroup.crewInfo = this.initVO.crewInfoVO;
         this.btnsGroup.currentVehicleType = this.initVO.vehicleBlockVO.vType;
         this.btnsGroup.currentVehicleIntCD = this.initVO.vehicleBlockVO.vIntCD;
         this.txtCrewMembers.htmlText = App.utils.locale.makeString(RETRAIN_CREW.LABEL_CREWMEMBERS) + " <font color=\'#E9E2BF\' size=\'15\'>" + this.initVO.crewInfoVO.length.toString() + "</font>";
         invalidate(VEHICLE_BLOCK_INVALID);
      }

      public function as_updateData(param1:Object) : void {
         this.btnsGroup.operationData = new RetrainCrewOperationVO(param1);
      }
   }

}