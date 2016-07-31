package com.xvm.battle.minimap
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.BattleState;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.types.cfg.CMinimap;
    import flash.events.Event;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;
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
            var idx:int = page.getChildIndex(page.minimap);
            page.removeChild(page.minimap);
            var component:UI_Minimap = new UI_Minimap();
            component.x = page.minimap.x;
            component.y = page.minimap.y;
            page.minimap = component;
            page.addChildAt(page.minimap, idx);
            page.xfw_registerComponent(page.minimap, BATTLE_VIEW_ALIASES.MINIMAP);
            // restore event handlers setted up in the BaseBattlePage.configUI()
            component.addEventListener(MinimapEvent.SIZE_CHANGED, page.xfw_onMiniMapChangeHandler);
            component.addEventListener(MinimapEvent.VISIBILITY_CHANGED, page.xfw_onMiniMapChangeHandler);
        }
    }
}
