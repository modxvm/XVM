/**
 * XVM - squad window
 * @author Pavel Máca
 */
package xvm.squad
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import com.xfw.utils.*;
    import com.xfw.types.veh.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;

    public class SquadXvmView extends XvmViewBase
    {
        public function SquadXvmView(view:IView)
        {
            super(view);
        }

        public function get page():SquadWindow
        {
            return super.view as SquadWindow;
        }

        /* TODO:0.9.4
        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            page.squadView.memberList.itemRenderer = UI_SquadItemRenderer;
            page.memberList.addEventListener(Defines.E_ITEM_UPDATED, onMemberListItemUpdated);
        }

        private function onMemberListItemUpdated():void
        {
            App.utils.scheduler.cancelTask(updateWindowProperties);
            App.utils.scheduler.envokeInNextFrame(updateWindowProperties);
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
