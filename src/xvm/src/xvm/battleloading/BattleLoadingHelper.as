/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
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
            list1.itemRenderer = App.utils.classFactory.getClass("xvm.battleloading_ui::UI_LeftItemRenderer");
            list2.itemRenderer = App.utils.classFactory.getClass("xvm.battleloading_ui::UI_RightItemRenderer");
        }
    }
}
