package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.sortie.SortieDivisionBlock;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.VO.SortieDivisionVO;
   import scaleform.clik.utils.Padding;


   public class ToolTipSortieDivision extends ToolTipBase
   {
          
      public function ToolTipSortieDivision() {
         super();
         this.headerTF = content.headerTF;
         this.descrTF = content.descrTF;
         this.infoTF = content.infoTF;
         this.middleDiv = content.middleDiv;
         this.championDiv = content.championDiv;
         this.absoluteDiv = content.absoluteDiv;
         contentMargin = new Padding(9,13,1,13);
      }

      private static const TEXT_PADDING:int = 5;

      private static const LEFT_SEP_PADDING:int = 14;

      private static const INFO_PADDING:int = 3;

      public var headerTF:TextField = null;

      public var descrTF:TextField = null;

      public var infoTF:TextField = null;

      public var middleDiv:SortieDivisionBlock = null;

      public var championDiv:SortieDivisionBlock = null;

      public var absoluteDiv:SortieDivisionBlock = null;

      private function addSeparatorWithMargin() : Separator {
         var _loc1_:Separator = null;
         _loc1_ = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition ^ 0;
         _loc1_.x = LEFT_SEP_PADDING;
         separators.push(_loc1_);
         topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         return _loc1_;
      }

      override protected function redraw() : void {
         var _loc2_:* = 0;
         var _loc3_:ILocale = null;
         var _loc1_:SortieDivisionVO = new SortieDivisionVO(_data);
         _loc2_ = bgShadowMargin.left + contentMargin.left;
         _loc3_ = App.utils.locale;
         separators = new Vector.<Separator>();
         this.headerTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_TITLE);
         this.headerTF.width = this.headerTF.textWidth + TEXT_PADDING;
         this.headerTF.x = _loc2_;
         this.headerTF.y = topPosition ^ 0;
         topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
         this.descrTF.y = topPosition;
         this.descrTF.x = _loc2_;
         this.descrTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_DESCRIPTION);
         this.descrTF.height = this.descrTF.textHeight + TEXT_PADDING;
         topPosition = this.descrTF.y + this.descrTF.height + Utils.instance.MARGIN_AFTER_BLOCK;
         this.middleDiv.y = topPosition;
         this.middleDiv.x = _loc2_;
         this.middleDiv.division = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_MIDDLEDIVISION);
         this.middleDiv.divisionLvls = _loc1_.middleDivisLevels;
         this.middleDiv.divisionBonus = _loc1_.middleDivisBonus;
         topPosition = topPosition + this.middleDiv.height;
         this.championDiv.y = topPosition;
         this.championDiv.x = _loc2_;
         this.championDiv.division = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_CHAMPIONDIVISION);
         this.championDiv.divisionLvls = _loc1_.champDivisLevels;
         this.championDiv.divisionBonus = _loc1_.champDivisBonus;
         topPosition = topPosition + this.championDiv.height;
         this.absoluteDiv.y = topPosition;
         this.absoluteDiv.x = _loc2_;
         this.absoluteDiv.division = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_ABSOLUTEDIVISION);
         this.absoluteDiv.divisionLvls = _loc1_.absoluteDivisLevels;
         this.absoluteDiv.divisionBonus = _loc1_.absoluteDivisBonus;
         topPosition = topPosition + this.absoluteDiv.height;
         var _loc4_:Separator = this.addSeparatorWithMargin();
         this.infoTF.x = _loc2_;
         this.infoTF.y = topPosition - INFO_PADDING;
         this.infoTF.text = _loc3_.makeString(TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_INFO);
         this.infoTF.height = this.infoTF.textHeight + TEXT_PADDING;
         super.redraw();
      }

      override protected function onDispose() : void {
         this.headerTF = null;
         this.descrTF = null;
         this.infoTF = null;
         if(this.middleDiv)
         {
            this.middleDiv.dispose();
            this.middleDiv = null;
         }
         if(this.championDiv)
         {
            this.championDiv.dispose();
            this.championDiv = null;
         }
         if(this.absoluteDiv)
         {
            this.absoluteDiv.dispose();
            this.absoluteDiv = null;
         }
         super.onDispose();
      }
   }

}