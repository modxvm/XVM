/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.shared.minimap
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.display.DisplayObject;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.views.*;
    import net.wg.gui.battle.views.minimap.*;
    import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
    import net.wg.gui.battle.views.minimap.events.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class MinimapXvmView extends XvmViewBase
    {
        public function MinimapXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BaseBattlePage
        {
            return super.view as BaseBattlePage;
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

            var minimapEntryController:MinimapEntryController = MinimapEntryController.instance;

            var scalableEntries:Vector.<DisplayObject> = XfwUtils.getPrivateField(minimapEntryController, "xfw_scalableEntries");
            while (scalableEntries.length)
            {
                minimapEntryController.unregisterScalableEntry(scalableEntries[0], true);
            }

            var vehicleEntries:Vector.<IVehicleMinimapEntry> = XfwUtils.getPrivateField(minimapEntryController, "xfw_vehicleEntries");
            while (vehicleEntries.length)
            {
                minimapEntryController.unregisterVehicleEntry(vehicleEntries[0]);
            }

            var vehicleLabelEntries:Vector.<IVehicleMinimapEntry> = XfwUtils.getPrivateField(minimapEntryController, "xfw_vehicleLabelsEntries");
            vehicleLabelEntries.splice(0, vehicleLabelEntries.length);

            var idx:int = page.getChildIndex(page.minimap);
            page.removeChild(page.minimap);
            var component:UI_Minimap = new UI_Minimap();
            component.x = page.minimap.x;
            component.y = page.minimap.y;
            component.visible = page.minimap.visible;
            page.minimap = component;
            page.addChildAt(page.minimap, idx);
            //page.minimap.validateNow(); // TODO: remove? brokes initial size restoring

            XfwUtils.getPrivateField(page, 'xfw_registerComponent')(page.minimap, BATTLE_VIEW_ALIASES.MINIMAP);

            // restore event handlers setted up in the BaseBattlePage.configUI()
            component.addEventListener(MinimapEvent.TRY_SIZE_CHANGED, onMiniMapTrySizeChangeHandler, false, 0, true);
            component.addEventListener(MinimapEvent.SIZE_CHANGED, XfwUtils.getPrivateField(page,"xfw_onMiniMapChangeHandler"), false, 0, true);
            component.addEventListener(MinimapEvent.VISIBILITY_CHANGED, XfwUtils.getPrivateField(page, "xfw_onMiniMapChangeHandler"), false, 0, true);
        }

        private function onMiniMapTrySizeChangeHandler(e:MinimapEvent):void
        {
            if (Config.config.minimap.enabled)
            {
                page.minimap.setAllowedSizeIndex(e.sizeIndex);
            }
            else
            {
                XfwUtils.getPrivateField(page, 'xfw_onMiniMapTrySizeChangeHandler')(e);
            }
        }
    }
}
