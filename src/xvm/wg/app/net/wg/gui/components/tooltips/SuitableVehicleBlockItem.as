package net.wg.gui.components.tooltips
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class SuitableVehicleBlockItem extends UIComponent
   {
          
      public function SuitableVehicleBlockItem() {
         super();
      }

      public var vehicleName:TextField = null;

      public var levelMc:MovieClip = null;

      public var vehicleType:UILoaderAlt = null;

      public var nationIco:UILoaderAlt = null;

      public var vehicleIco:UILoaderAlt = null;

      private var _vName:String = null;

      private var _lNum:Number = NaN;

      private var _vType:String = null;

      private var _nIco:String = null;

      private var _vIco:String = null;

      private var dataDirty:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if(this.dataDirty)
         {
            this.levelMc.gotoAndStop(this._lNum);
            this.vehicleType.source = this._vType;
            this.nationIco.source = this._nIco;
            this.vehicleIco.source = this._vIco;
            this.vehicleName.text = this._vName;
            this.vehicleName.width = this.vehicleName.textWidth + 3;
            this.dataDirty = false;
         }
      }

      public function setData(param1:String, param2:uint, param3:String, param4:String, param5:String) : void {
         this._nIco = param1;
         this._lNum = param2;
         this._vIco = param3;
         this._vType = param4;
         this._vName = param5;
         this.dataDirty = true;
         validateNow();
      }
   }

}