package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortClanStatisticsWindowMeta;
   import net.wg.infrastructure.base.meta.IFortClanStatisticsWindowMeta;
   import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.SortieStatisticsForm;
   import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
   import scaleform.clik.constants.InvalidationType;


   public class FortClanStatisticsWindow extends FortClanStatisticsWindowMeta implements IFortClanStatisticsWindowMeta
   {
          
      public function FortClanStatisticsWindow() {
         super();
         isModal = false;
         isCentered = true;
      }

      public var sortieForm:SortieStatisticsForm;

      private var model:ClanStatsVO;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            window.title = App.utils.locale.makeString(FORTIFICATIONS.FORTCLANSTATISTICSWINDOW_TITLE,{"clanName":this.model.clanName});
            this.sortieForm.model = this.model;
         }
      }

      override protected function onDispose() : void {
         this.sortieForm.dispose();
         this.sortieForm = null;
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         super.onDispose();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      public function as_setData(param1:Object) : void {
         this.model = new ClanStatsVO(param1);
         invalidateData();
      }
   }

}