package net.wg.gui.historicalBattles.controls
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.carousels.ICarouselItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.historicalBattles.data.BattleListItemVO;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   import net.wg.gui.utils.ComplexTooltipHelper;
   import flash.filters.ColorMatrixFilter;
   import fl.motion.AdjustColor;


   public class BattleCarouselItemRenderer extends SoundListItemRenderer implements ICarouselItemRenderer
   {
          
      public function BattleCarouselItemRenderer() {
         super();
         toggle = true;
         allowDeselect = false;
      }

      public var infoField:TextField;

      public var image:UILoaderAlt;

      protected var model:BattleListItemVO;

      private var _canBeSelected:Boolean = true;

      override public function setData(param1:Object) : void {
         super.setData(param1);
         this.model = param1 as BattleListItemVO;
         if(this.model)
         {
            label = this.model.name;
         }
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.infoField.text = HISTORICAL_BATTLES.LABEL_SOON;
         this.infoField.visible = false;
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.infoField.visible = this.model.isFuture;
            this.image.source = this.model.image;
            this.image.filters = this.model.isFuture?[this.getBWFilter()]:[];
         }
      }

      override protected function onDispose() : void {
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         var _loc2_:String = null;
         super.handleMouseRollOver(param1);
         if(this.model)
         {
            _loc2_ = new ComplexTooltipHelper().addHeader(this.model.tooltipHeader).addBody(this.model.tooltipDescription).make();
            if(_loc2_.length > 0)
            {
               App.toolTipMgr.showComplex(_loc2_);
            }
         }
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         if(this._canBeSelected)
         {
            super.handleMouseRelease(param1);
         }
      }

      override protected function handleMousePress(param1:MouseEvent) : void {
         super.handleMousePress(param1);
         App.toolTipMgr.hide();
      }

      public function set canBeSelected(param1:Boolean) : void {
         this._canBeSelected = param1;
      }

      public function get canBeSelected() : Boolean {
         return this._canBeSelected;
      }

      private function getBWFilter() : ColorMatrixFilter {
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = 0;
         _loc1_.contrast = 0;
         _loc1_.hue = 0;
         _loc1_.saturation = -100;
         return new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
      }
   }

}