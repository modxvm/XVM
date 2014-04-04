package net.wg.gui.lobby.hangar.maintenance
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ShellsSet;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.hangar.maintenance.data.HistoricalAmmoVO;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.InvalidationType;


   public class AmmoBlockOverlay extends UIComponent
   {
          
      public function AmmoBlockOverlay() {
         super();
         this.priceLabelTF = this.priceBlockMC.priceLabelTF;
         this.priceNoteTF = this.priceBlockMC.priceNoteTF;
         this.priceTF = this.priceBlockMC.priceTF;
         this.shellsSet = this.priceBlockMC.shellsSet;
      }

      private static const TEXT_OFFSET:Number = 10;

      public var headerTF:TextField;

      public var descriptionTF:TextField;

      public var noteTF:TextField;

      public var priceLabelTF:TextField;

      public var priceTF:TextField;

      public var priceNoteTF:TextField;

      public var shellsSet:ShellsSet;

      public var priceBlockMC:MovieClip;

      protected var model:HistoricalAmmoVO;

      public function setData(param1:HistoricalAmmoVO) : void {
         this.model = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.priceLabelTF.autoSize = TextFieldAutoSize.LEFT;
         this.priceNoteTF.autoSize = TextFieldAutoSize.LEFT;
         this.priceTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.text = HISTORICAL_BATTLES.AMMOPRESET_HEADER;
         this.descriptionTF.text = HISTORICAL_BATTLES.AMMOPRESET_DESCRIPTION;
         this.noteTF.text = HISTORICAL_BATTLES.AMMOPRESET_NOTE;
         this.priceLabelTF.text = HISTORICAL_BATTLES.AMMOPRESET_PRICELABEL;
         this.priceNoteTF.text = HISTORICAL_BATTLES.AMMOPRESET_PRICENOTE;
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.priceTF.htmlText = this.model.price;
            this.shellsSet.setData(this.model.shells,this.model.battleID);
            this.shellsSet.validateNow();
            this.priceNoteTF.x = this.priceLabelTF.x = this.shellsSet.actualWidth + TEXT_OFFSET;
            this.priceTF.x = this.priceLabelTF.x + this.priceLabelTF.width + TEXT_OFFSET;
            this.priceBlockMC.x = width - this.priceBlockMC.width >> 1;
         }
      }

      override protected function onDispose() : void {
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         this.shellsSet.dispose();
         this.shellsSet = null;
         super.onDispose();
      }
   }

}