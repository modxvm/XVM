package com.xvm.battle.sixthSense {
import com.xfw.Logger;
import com.xvm.infrastructure.XvmViewBase;
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.gui.battle.random.views.BattlePage;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.interfaces.IView;

public class SixthSenseXvmView extends XvmViewBase {


    public function SixthSenseXvmView(view:IView) {
        super(view);
    }

    public override function onAfterPopulate(e:LifeCycleEvent):void {
        super.onAfterPopulate(e);
        init();
    }

    private function init():void {
        const page:BattlePage = super.view as BattlePage;

        if (page) {
            page.unregisterComponent(BATTLE_VIEW_ALIASES.SIXTH_SENSE);
            var currentIndex:int = page.getChildIndex(page.sixthSense);
            page.removeChild(page.sixthSense);
            var customSixthSense:UI_SixthSense = new UI_SixthSense();
            customSixthSense.x = page.sixthSense.x;
            customSixthSense.y = page.sixthSense.y;
            customSixthSense.visible = page.sixthSense.visible;
            page.sixthSense = customSixthSense;
            page.addChildAt(page.sixthSense, currentIndex);
            page.xfw_registerComponent(page.sixthSense, BATTLE_VIEW_ALIASES.SIXTH_SENSE);
        } else {
            Logger.err(new Error("SixthSenseXvmView#init : view is not BattlePage"));
        }
    }
}
}
