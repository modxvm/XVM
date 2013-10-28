package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.questsWindow.data.VehicleBlockVO;
   import scaleform.clik.constants.InvalidationType;


   public class VehicleBlock extends UIComponent
   {
          
      public function VehicleBlock() {
         super();
      }

      public var nationIcon:UILoaderAlt;

      public var typeIcon:UILoaderAlt;

      public var levelMC:MovieClip;

      public var tankSmallIcon:UILoaderAlt;

      public var vehicleTF:TextField;

      private var tankData:VehicleBlockVO = null;

      public function setData(param1:Object) : void {
         this.tankData = new VehicleBlockVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         if(isInvalid(InvalidationType.DATA))
         {
            this.nationIcon.source = this.tankData.nationIconPath;
            this.typeIcon.source = this.tankData.typeIconPath;
            this.levelMC.gotoAndStop(this.tankData.vLevel);
            this.tankSmallIcon.source = this.tankData.vIconSmall;
            this.vehicleTF.text = this.tankData.vName;
         }
      }

      override public function dispose() : void {
         if(this.nationIcon)
         {
            this.nationIcon.dispose();
            this.nationIcon = null;
         }
         if(this.typeIcon)
         {
            this.typeIcon.dispose();
            this.typeIcon = null;
         }
         this.levelMC = null;
         if(this.tankSmallIcon)
         {
            this.tankSmallIcon.dispose();
            this.tankSmallIcon = null;
         }
         if(this.tankData)
         {
            this.tankData.dispose();
            this.tankData = null;
         }
         this.vehicleTF = null;
         super.dispose();
      }
   }

}