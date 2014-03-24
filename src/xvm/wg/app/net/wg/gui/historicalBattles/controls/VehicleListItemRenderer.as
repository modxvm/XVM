package net.wg.gui.historicalBattles.controls
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.historicalBattles.data.VehicleListItemVO;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.geom.Point;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class VehicleListItemRenderer extends SoundListItemRenderer
   {
          
      public function VehicleListItemRenderer() {
         super();
         preventAutosizing = true;
      }

      public var image:UILoaderAlt;

      public var warningIcon:Sprite;

      public var mouseArea:Sprite;

      public var disableFill:BitmapFill;

      protected var model:VehicleListItemVO;

      override protected function configUI() : void {
         super.configUI();
         this.warningIcon.buttonMode = this.warningIcon.useHandCursor = true;
         this.warningIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.warningIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.mouseArea.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.mouseArea.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
      }

      override protected function onDispose() : void {
         this.warningIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.warningIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.warningIcon = null;
         this.mouseArea.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.mouseArea.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.mouseArea = null;
         this.image.dispose();
         this.image = null;
         this.disableFill.dispose();
         this.disableFill = null;
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            textField.text = this.model.name;
            this.image.source = this.model.image;
            this.warningIcon.visible = this.model.showWarning;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.disableFill.visible = this.model?!this.model.enabled:false;
         }
         mouseChildren = true;
      }

      override public function setData(param1:Object) : void {
         this.model = param1 as VehicleListItemVO;
         var _loc2_:Point = new Point(mouseX,mouseY);
         _loc2_ = localToGlobal(_loc2_);
         var _loc3_:Boolean = this.warningIcon.hitTestPoint(_loc2_.x,_loc2_.y,true);
         var _loc4_:Boolean = this.mouseArea.hitTestPoint(_loc2_.x,_loc2_.y,true);
         if(this.model)
         {
            enabled = (this.model.enabled) && (this.model.selectable);
            this.mouseArea.buttonMode = this.mouseArea.useHandCursor = enabled;
            textField.visible = true;
            this.image.visible = true;
            if(_loc3_)
            {
               this.showWarnTT();
               App.cursor.setCursor(Cursors.BUTTON);
            }
            else
            {
               if(_loc4_)
               {
                  this.showBodyTT();
                  App.cursor.setCursor(enabled?Cursors.BUTTON:Cursors.ARROW);
               }
            }
         }
         else
         {
            enabled = false;
            this.mouseArea.buttonMode = this.mouseArea.useHandCursor = false;
            textField.visible = false;
            this.image.visible = false;
            this.warningIcon.visible = false;
            if((_loc3_) || (_loc4_))
            {
               App.toolTipMgr.hide();
               App.cursor.setCursor(Cursors.ARROW);
            }
         }
         invalidateData();
      }

      private function onControlRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         switch(param1.currentTarget)
         {
            case this.warningIcon:
               this.showWarnTT();
               break;
            case this.mouseArea:
               this.showBodyTT();
               break;
         }
      }

      private function showWarnTT() : void {
         this.showComplexTT(this.model.warnTTHeader,this.model.warnTTBody);
      }

      private function showBodyTT() : void {
         if(this.model)
         {
            if(this.model.enabled)
            {
               App.toolTipMgr.showSpecial(Tooltips.HISTORICAL_VEHICLE,null,this.model.intCD);
            }
            else
            {
               this.showComplexTT(App.utils.locale.makeString(TOOLTIPS.HISTORICALBATTLES_VEHICLE_NOTAVAILABLE_HEADER),App.utils.locale.makeString(TOOLTIPS.HISTORICALBATTLES_VEHICLE_NOTAVAILABLE_BODY));
            }
         }
      }

      private function showComplexTT(param1:String, param2:String="") : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
   }

}