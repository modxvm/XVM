package net.wg.gui.lobby.training
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import flash.text.TextField;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import flash.geom.ColorTransform;
   import scaleform.clik.constants.InvalidationType;
   
   public class PlayerElement extends UIComponent implements IUpdatable
   {
      
      public function PlayerElement() {
         super();
      }
      
      private static const GOLD_COLOR:Number = 16761699;
      
      private static const NAME_COLOR:Number = 13224374;
      
      private static const VEHICLE_COLOR:Number = 8092009;
      
      public var iconLoader:UILoaderAlt;
      
      public var nameField:UserNameField;
      
      public var vehicleField:TextField;
      
      public var vehicleLevelField:TextField;
      
      public var stateField:TextField;
      
      private var data:TrainingRoomRendererVO;
      
      private var defColorTrans:ColorTransform;
      
      override protected function configUI() : void {
         super.configUI();
         this.defColorTrans = this.iconLoader.transform.colorTransform;
      }
      
      public function update(param1:Object) : void {
         if(param1)
         {
            this.data = TrainingRoomRendererVO(param1);
            invalidate(InvalidationType.DATA);
         }
      }
      
      override protected function onDispose() : void {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.nameField.dispose();
         this.nameField = null;
         this.vehicleField = null;
         this.vehicleLevelField = null;
         this.stateField = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         this.defColorTrans = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         var _loc1_:ColorTransform = null;
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.nameField.userVO = this.data;
               this.vehicleField.text = this.data.vShortName;
               this.stateField.text = this.data.stateString;
               this.vehicleLevelField.text = this.data.vLevel;
               this.iconLoader.visible = true;
               if(this.iconLoader.source != this.data.icon)
               {
                  this.iconLoader.source = this.data.icon;
               }
               enabled = true;
               this.nameField.textColor = NAME_COLOR;
               this.vehicleField.textColor = VEHICLE_COLOR;
               _loc1_ = new ColorTransform();
               if(!enabled)
               {
                  _loc1_.alphaMultiplier = 0.7;
                  _loc1_.redMultiplier = 0.1;
                  _loc1_.blueMultiplier = 0.1;
                  _loc1_.greenMultiplier = 0.1;
               }
               else if(this.data.himself)
               {
                  this.nameField.textColor = GOLD_COLOR;
                  this.vehicleField.textColor = GOLD_COLOR;
                  _loc1_.redOffset = 21;
                  _loc1_.greenOffset = 9;
                  _loc1_.blueMultiplier = 0.51;
                  _loc1_.greenMultiplier = 0.87;
               }
               else
               {
                  _loc1_ = this.defColorTrans;
               }
               
               this.iconLoader.transform.colorTransform = _loc1_;
            }
            else
            {
               this.nameField.userVO = null;
               this.vehicleField.text = "";
               this.vehicleLevelField.text = "";
               this.iconLoader.visible = false;
               enabled = false;
            }
         }
      }
   }
}
