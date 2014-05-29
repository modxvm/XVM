package net.wg.gui.components.tooltips.sortie
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.data.constants.IconsTypes;
   import scaleform.clik.constants.InvalidationType;


   public class SortieDivisionBlock extends UIComponent
   {
          
      public function SortieDivisionBlock() {
         super();
      }

      private static const DEFRES_COLOR:int = 10656624;

      public var divisionHeaderTF:TextField;

      public var levelsTF:TextField;

      public var bonusTF:TextField;

      public var levelsIT:IconText;

      public var bonusIT:IconText;

      private var _division:String = "";

      private var _divisionLvls:String = "";

      private var _divisionBonus:String = "";

      override protected function configUI() : void {
         super.configUI();
         this.levelsTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_VEHLEVEL;
         this.bonusTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_BONUS;
         this.bonusIT.icon = IconsTypes.DEFRES;
         this.bonusIT.textColor = DEFRES_COLOR;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.divisionHeaderTF.text = this._division;
            this.levelsIT.text = this._divisionLvls;
            this.bonusIT.text = this._divisionBonus;
         }
      }

      override protected function onDispose() : void {
         if(this.levelsIT)
         {
            this.levelsIT.dispose();
            this.levelsIT = null;
         }
         if(this.bonusIT)
         {
            this.bonusIT.dispose();
            this.bonusIT = null;
         }
         this.divisionHeaderTF = null;
         this.levelsIT = null;
         this.bonusIT = null;
      }

      public function get division() : String {
         return this._division;
      }

      public function set division(param1:String) : void {
         this._division = param1;
         invalidateData();
      }

      public function get divisionLvls() : String {
         return this._divisionLvls;
      }

      public function set divisionLvls(param1:String) : void {
         this._divisionLvls = param1;
         invalidateData();
      }

      public function get divisionBonus() : String {
         return this._divisionBonus;
      }

      public function set divisionBonus(param1:String) : void {
         this._divisionBonus = param1;
         invalidateData();
      }
   }

}