package net.wg.gui.lobby.profile.components
{
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;


   public class LditBattles extends LineDescrIconText
   {
          
      public function LditBattles() {
         super();
      }

      private var _wins:String;

      private var _losses:String;

      private var _draws:String;

      override protected function showToolTip(param1:IToolTipParams) : void {
         var _loc2_:Object = null;
         if(tooltip)
         {
            _loc2_ =
               {
                  "wins":"<b>" + this._wins + "</b>",
                  "losses":"<b>" + this._losses + "</b>",
                  "draws":"<b>" + this._draws + "</b>"
               }
            ;
            App.toolTipMgr.showComplexWithParams(tooltip,new ToolTipParams({},_loc2_));
         }
      }

      public function setValues(param1:String, param2:String, param3:String) : void {
         this._wins = param1;
         this._losses = param2;
         this._draws = param3;
      }

      override public function dispose() : void {
         super.dispose();
      }
   }

}