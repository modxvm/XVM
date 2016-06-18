/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class BattleXvmView extends XvmViewBase
    {
        public function BattleXvmView(view:IView)
        {
            super(view);
        }

        /*public function get page():BattleLoading
        {
            return super.view as BattleLoading;
        }*/

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            Logger.add("onAfterPopulate: " + view.as_alias);
            Logger.addObject(view, 2);
        }

        // PRIVATE

    }
}
