/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.text.*;
    import net.wg.gui.battle.battleloading.renderers.*;

    public class XvmTablePlayerItemRenderer extends TablePlayerItemRenderer
    {
        public function XvmTablePlayerItemRenderer(container:RendererContainer, position:int, isEnemy:Boolean)
        {
            //Logger.add("XvmTablePlayerItemRenderer");
            var vehicleField:TextField = container.vehicleFieldsAlly[position];
            if (!isEnemy)
            {
                vehicleField.x = container.vehicleTypeIconsAlly[position].x - vehicleField.width;
            }
            super(container, position, isEnemy);
        }

        override protected function draw():void
        {
            super.draw();
        }
    }
}
