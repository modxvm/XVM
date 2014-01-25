package net.wg.gui.prebattle.controls
{
   import net.wg.gui.prebattle.squad.SquadItemRenderer;
   import flash.text.TextField;
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import scaleform.gfx.TextFieldEx;
   import net.wg.data.constants.Values;


   public class TeamMemberRenderer extends SquadItemRenderer
   {
          
      public function TeamMemberRenderer() {
         useRightButton = true;
         super();
      }

      public var numberField:TextField;

      public var commander_icon:UIComponent;

      public var status_icon:UIComponent;

      public var wrong_limits:UIComponent;

      public var vehicle_type_icon:UIComponent;

      private var _isVehicleValid:Boolean = true;

      override protected function onDispose() : void {
         super.onDispose();
         this.commander_icon.dispose();
         this.status_icon.dispose();
         this.wrong_limits.dispose();
         this.vehicle_type_icon.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override public function setData(param1:Object) : void {
         if(param1 != null)
         {
            param1 = new PlayerPrbInfoVO(param1);
         }
         super.setData(param1);
         if(param1)
         {
            setSpeakers(PlayerPrbInfoVO(param1).isPlayerSpeaking,true);
         }
      }

      override protected function showToolTips() : void {
         var _loc1_:String = model.accID == -1?MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE:this.isVehicleValid?getToolTipData():model.himself?TOOLTIPS.MEMBERS_VEHICLELEVELLIMITS_BODY:getToolTipData();
         if((_loc1_) && _loc1_.length > 0)
         {
            App.toolTipMgr.show(_loc1_);
         }
      }

      override protected function afterSetData() : void {
         var _loc1_:String = null;
         var _loc3_:String = null;
         this.commander_icon.visible = this.status_icon.visible = this.vehicle_type_icon.visible = false;
         updatePlayerName();
         if(!model)
         {
            return;
         }
         _loc1_ = model.getStateString();
         if(_loc1_ != PrebattleStateString.UNKNOWN)
         {
            statusString = _loc1_;
            this.status_icon.visible = true;
            status.visible = true;
            status.gotoAndPlay(_loc1_);
            if(this.status_icon.currentLabels.indexOf(_loc1_,0))
            {
               this.status_icon.gotoAndPlay(_loc1_);
            }
            if(_loc1_ == PrebattleStateString.OFFLINE)
            {
               this.status_icon.gotoAndPlay(PrebattleStateString.NOT_READY);
            }
            if(this.hitTestPoint(mouseX,mouseY,true))
            {
               _loc3_ = getToolTipData();
               if(_loc3_.length > 0)
               {
                  App.toolTipMgr.showSpecial(_loc3_,null);
               }
            }
            if(model.vType)
            {
               this.vehicle_type_icon.visible = true;
               this.vehicle_type_icon.gotoAndPlay(model.vType);
            }
            else
            {
               this.vehicle_type_icon.visible = false;
            }
            if(model.isCreator)
            {
               this.commander_icon.visible = true;
               this.status_icon.visible = false;
            }
         }
         else
         {
            setSpeakers(false,true);
            status.gotoAndPlay("invite");
            _loc1_ = null;
         }
         updateVoiceWave();
         var _loc2_:Number = model.getCurrentColor();
         if(!isNaN(_loc2_))
         {
            textField.textColor = _loc2_;
            vehicleNameField.textColor = _loc2_;
            this.numberField.textColor = _loc2_;
            vehicleLevelField.textColor = _loc2_;
         }
         vehicleNameField.text = model.vShortName;
         this.updateValidVehicleState(this.isVehicleValid);
         if(isNaN(model.orderNumber))
         {
            this.numberField.visible = false;
         }
         else
         {
            this.numberField.text = String(model.orderNumber);
         }
         this.updateAfterStateChange();
      }

      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         if(!initialized)
         {
            return;
         }
         if((model) && (model.isCreator))
         {
            this.commander_icon.visible = true;
            this.status_icon.visible = false;
         }
         if((model) && (model.vType))
         {
            this.vehicle_type_icon.visible = true;
            this.vehicle_type_icon.gotoAndPlay(model.vType);
         }
         else
         {
            this.vehicle_type_icon.visible = false;
         }
         TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(vehicleNameField,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.numberField,TextFieldEx.VALIGN_TOP);
         vehicleNameField.text = model?model.vShortName:Values.EMPTY_STR;
         this.numberField.text = model?String(model.orderNumber):Values.EMPTY_STR;
         var _loc1_:Number = model?model.getCurrentColor():Number.NaN;
         if(!isNaN(_loc1_))
         {
            textField.textColor = _loc1_;
            vehicleNameField.textColor = _loc1_;
            this.numberField.textColor = _loc1_;
            vehicleLevelField.textColor = _loc1_;
         }
         this.updateValidVehicleState((this._isVehicleValid) && !(vehicleLevelField.text == null) && (this.visible));
         constraints.updateElement("status",status);
         constraints.updateElement("vehicleNameField",vehicleNameField);
      }

      public function get isVehicleValid() : Boolean {
         return this._isVehicleValid;
      }

      public function set isVehicleValid(param1:Boolean) : void {
         this._isVehicleValid = param1;
         this.updateValidVehicleState(param1);
      }

      private function updateValidVehicleState(param1:Boolean) : void {
         if((model) && (isNaN(model.accID)))
         {
            return;
         }
         this.wrong_limits.visible = !param1;
         if(param1)
         {
            vehicleLevelField.htmlText = Values.EMPTY_STR;
            vehicleLevelField.text = model?model.vLevel:Values.EMPTY_STR;
         }
         else
         {
            vehicleLevelField.text = Values.EMPTY_STR;
            vehicleLevelField.htmlText = model?"<font color=\"#ff0000\">" + model.vLevel + "</font>":Values.EMPTY_STR;
         }
      }
   }

}