package preview
{

//import net.wargaming.controls.UILoaderAlt;
import preview.*;

public class ContourIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function ContourIconProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

/*    public function get initialized():Boolean
    {
        return xvm.proxy.iconLoader != null && xvm.proxy.iconLoader.initialized;
    }

    public function get iconLoader():UILoaderAlt
    {
        return xvm.proxy.iconLoader;
    }*/

    public function get source():String
    {
        return xvm.m_source;
    }
}

}
