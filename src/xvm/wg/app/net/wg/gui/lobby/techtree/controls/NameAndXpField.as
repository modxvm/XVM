package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;


   public class NameAndXpField extends NodeComponent
   {

      public function NameAndXpField() {
         super();
      }

      private static const statesMap:Object = null;

      public var xpLabel:String = "earnedXPLabel";

      public var changeXpIconToElite:Boolean = false;

      public var nameField:TextField;

      public var xpField:TextField;

      public var xpIcon:XPIcon;

      private var _isInAction:Boolean;

      public function setIsInAction(param1:Boolean) : void {
         this._isInAction = param1;
      }

      override protected function configUI() : void {
         mouseEnabled = mouseChildren = false;
         super.configUI();
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(!(_owner == null) && (isInvalid(InvalidationType.DATA)))
         {
            _loc1_ = this.xpLabel.length > 0?_owner.getNamedLabel(this.xpLabel):"";
            _loc2_ = statesMap[state][_loc1_.length > 0?this._isInAction?2:1:0];
            if(!(currentFrameLabel == _loc2_) && (_labelHash[_loc2_]))
            {
               gotoAndStop(_loc2_);
            }
            this.setNameField(_owner.getItemName());
            this.setXpField(_loc1_);
            if(this.changeXpIconToElite)
            {
               if(_owner.isElite())
               {
                  this.setXpIcon(XpTypeStrings.ELITE_XP_TYPE);
               }
               else
               {
                  this.setXpIcon(XpTypeStrings.EARNED_XP_TYPE);
               }
            }
         }
         super.draw();
      }

      private function setNameField(param1:String) : void {
         if(!(this.nameField == null) && !(param1 == null))
         {
            this.nameField.text = param1;
         }
      }

      private function setXpField(param1:String) : void {
         if(!(this.xpField == null) && !(param1 == null))
         {
            this.xpField.text = param1;
         }
      }

      private function setXpIcon(param1:String) : void {
         if(this.xpIcon != null)
         {
            this.xpIcon.type = param1;
            this.xpIcon.validateNow();
         }
      }
   }

}