/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;
    import net.wg.gui.battle.views.minimap.*;
    import net.wg.gui.battle.views.minimap.events.*;

    public class MinimapXvmView extends XvmViewBase
    {
        public function MinimapXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            page.unregisterComponent(BATTLE_VIEW_ALIASES.MINIMAP);
            while (MinimapEntryController.instance.xfw_scalableEntries.length)
            {
                MinimapEntryController.instance.unregisterScalableEntry(MinimapEntryController.instance.xfw_scalableEntries[0], true);
            }
            while (MinimapEntryController.instance.xfw_vehicleEntries.length)
            {
                MinimapEntryController.instance.unregisterVehicleEntry(MinimapEntryController.instance.xfw_vehicleEntries[0]);
            }
            MinimapEntryController.instance.xfw_vehicleLabelsEntries.splice(0, MinimapEntryController.instance.xfw_vehicleLabelsEntries.length);
            var idx:int = page.getChildIndex(page.minimap);
            page.removeChild(page.minimap);
            var component:UI_Minimap = new UI_Minimap();
            component.x = page.minimap.x;
            component.y = page.minimap.y;
            component.visible = page.minimap.visible;
            page.minimap = component;
            page.addChildAt(page.minimap, idx);
            //page.minimap.validateNow(); // TODO: remove? brokes initial size restoring
            page.xfw_registerComponent(page.minimap, BATTLE_VIEW_ALIASES.MINIMAP);
            // restore event handlers setted up in the BaseBattlePage.configUI()
            component.addEventListener(MinimapEvent.TRY_SIZE_CHANGED, onMiniMapTrySizeChangeHandler, false, 0, true);
            component.addEventListener(MinimapEvent.SIZE_CHANGED, page.xfw_onMiniMapChangeHandler, false, 0, true);
            component.addEventListener(MinimapEvent.VISIBILITY_CHANGED, page.xfw_onMiniMapChangeHandler, false, 0, true);
        }

        private function onMiniMapTrySizeChangeHandler(e:MinimapEvent):void
        {
            if (Config.config.minimap.enabled)
            {
                page.minimap.setAllowedSizeIndex(e.sizeIndex);
            }
            else
            {
                page.xfw_onMiniMapTrySizeChangeHandler(e);
            }
        }
    }
}
