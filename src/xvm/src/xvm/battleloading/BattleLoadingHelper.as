package xvm.battleloading
{
	/**
     * ...
     * @author sirmax2
     */
    public class BattleLoadingHelper
    {
        import net.wg.gui.components.controls.ReadOnlyScrollingList;
        import net.wg.gui.lobby.battleloading.BattleLoading;

        public static function InitRenderers(page:net.wg.gui.lobby.battleloading.BattleLoading):void
        {
            var list1:ReadOnlyScrollingList = page.form.team1List;
            var list2:ReadOnlyScrollingList = page.form.team2List;
            list1.validateNow();
            list2.validateNow();
            list1.itemRendererName = "xvm.battleloading_ui::UI_LeftItemRenderer";
            list2.itemRendererName = "xvm.battleloading_ui::UI_RightItemRenderer";
            App.utils.scheduler.envokeInNextFrame(function():void
            {
                list1.itemRendererName = "xvm.battleloading_ui::UI_LeftItemRenderer";
                list2.itemRendererName = "xvm.battleloading_ui::UI_RightItemRenderer";
            });
        }
    }

}
