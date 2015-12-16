/**
 * XVM - squad window
 * @author Pavel Máca
 */
package xvm.squad
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.prebattle.squads.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class SquadXvmView extends XvmViewBase
    {
        private static const XVM_SQUAD_UPDATE_TIERS:String = 'xvm_squad.as_update_tiers';
        private static const XVM_SQUAD_WINDOW_POPULATED:String = 'xvm_squad.window_populated';
        private static const XVM_SQUAD_WINDOW_DISPOSED:String = 'xvm_squad.window_disposed';

        public function SquadXvmView(view:IView)
        {
            super(view);
        }

        public function get page():SquadWindow
        {
            return super.view as SquadWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //page.squadView.memberList.itemRenderer = UI_SquadItemRenderer;
            //page.memberList.addEventListener(Defines.E_ITEM_UPDATED, onMemberListItemUpdated);
            Xfw.addCommandListener(XVM_SQUAD_UPDATE_TIERS, updateTiers);
            Xfw.cmd(XVM_SQUAD_WINDOW_POPULATED)
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            Xfw.removeCommandListener(XVM_SQUAD_UPDATE_TIERS, updateTiers);
            Xfw.cmd(XVM_SQUAD_WINDOW_DISPOSED)
        }

        // PRIVATE

        private function updateTiers(tiers_text:String):void
        {
            page.window.title = App.utils.locale.makeString("#menu:headerButtons/battle/types/squad") + tiers_text;
        }

        /* old

        private function onMemberListItemUpdated():void
        {
            App.utils.scheduler.cancelTask(updateWindowProperties);
            App.utils.scheduler.scheduleOnNextFrame(updateWindowProperties);
        }

        private function updateWindowProperties():void
        {
            var tMin:int = 0;
            var tMax:int = 0;

            for (var i:int = 0; i < page.memberList.dataProvider.length; ++i)
            {
                var data:Object = page.memberList.dataProvider[i];
                if (data == null || data.vShortName == null)
                    continue;
                var vdata:VehicleData = VehicleInfo.getByLocalizedShortName(data.vShortName);
                if (vdata == null)
                    continue;
                if (tMin < vdata.tierLo)
                    tMin = vdata.tierLo;
                if (tMax < vdata.tierHi)
                    tMax = vdata.tierHi;
            }

            Window(page.window).title = App.utils.locale.makeString("#menu:headerButtons/battle/types/squad") +
                (tMin > 0 ? " - " + Locale.get("Squad battle tiers") + ": " + tMin + ".." + tMax : "");
        }
        */
    }

}
