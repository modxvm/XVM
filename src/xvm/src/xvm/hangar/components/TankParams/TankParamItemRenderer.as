/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.components.TankParams
{
    import com.xvm.*;
    import net.wg.gui.lobby.hangar.ParamsVO;

    public class TankParamItemRenderer extends TankParam
    {
        public function TankParamItemRenderer()
        {
            //Logger.add("TankParamItemRenderer");
            super();
        }

        override public function setData(data:Object) : void
        {
            if (!data || data is ParamsVO)
                super.setData(data);
            else
            {
                param = data.param;
                text = data.label;
                selected = data.selected;
                enabled = true;
                invalidate();
            }
        }
    }
}
