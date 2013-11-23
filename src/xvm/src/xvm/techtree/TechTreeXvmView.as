/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import flash.utils.*;
    import net.wg.data.gui_items.dossier.AccountDossier;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.TechTreePage;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.techtree.*;

    public class TechTreeXvmView extends XvmViewBase
    {
        public static var vehiclesData:Object = null;

        public function TechTreeXvmView(view:IView)
        {
            super(view);
        }

        public function get page():TechTreePage
        {
            return super.view as TechTreePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        // PRIVATE

        private function init():void
        {
            var accountDossier:AccountDossier = new AccountDossier(null);
            vehiclesData = {};
            for each (var data:TechniqueListVehicleVO in accountDossier.getAllVehiclesList())
                vehiclesData[data.id] = data;

            page.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE, this.handleIndexChange);
            handleIndexChange();
        }

      private function handleIndexChange(e:IndexEvent = null) : void
      {
            page.nationTree.dataProvider.displaySettings.fromObject( {
                nodeRendererName:getQualifiedClassName(UI_NationTreeNodeSkinned),
                isLevelDisplayed:page.nationTree.dataProvider.displaySettings.isLevelDisplayed
            }, null);
            page.nationTree.invalidateData();
        }
    }
}
