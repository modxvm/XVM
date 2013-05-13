import com.natecook.Sprintf;
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.GraphicsUtil;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.StatLoader;
import com.xvm.VehicleInfo;
import com.xvm.Utils;
import com.xvm.Helpers.UserDataLoaderHelper;
import wot.WGDataTypes.CarouselDataItem;
import wot.WGDataTypes.UserInfoDataItem;

class wot.UserInfo.ItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.profile.ItemRenderer;
    private var base:net.wargaming.profile.ItemRenderer;

    public function ItemRenderer(wrapper:net.wargaming.profile.ItemRenderer, base:net.wargaming.profile.ItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("UserInfo");

        ItemRendererCtor();
    }

    function setup()
    {
        return this.setupImpl.apply(this, arguments);
    }

    function updateAfterStateChange()
    {
        return this.updateAfterStateChangeImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var teffTextField:TextField;
    
    function ItemRendererCtor()
    {
        teffTextField = Utils.duplicateTextField(wrapper, "teff", wrapper.fights, 0, "center");
        teffTextField._x -= 37;
        //Logger.add("teff=" + teffTextField._x + ", fights=" + wrapper.fights._x);
    }
    
    function setupImpl()
    {
        base.setup();

        updateAfterStateChangeXvm();

        if (!wrapper.data)
            return;

        // "E" Column

        var e = wrapper.data.e;
        if (!e)
        {
            teffTextField.htmlText = "";
            return;
        }

        var color = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, e);
        teffTextField.htmlText =
            "<span class='xvm_teff'>" +
            "<font color='" + color + "'>" + (e < 10 ? e : "X") + "</font>" +
            //" (<font color='" + color + "'>" + data.teff + "</font>)" +
            "</span>";
    }
    
    function updateAfterStateChangeImpl()
    {
        base.updateAfterStateChange();
        
        updateAfterStateChangeXvm();
    }

    function updateAfterStateChangeXvm()
    {
        // Gold text color for premium tanks
        wrapper.textField.textColor = wrapper.data.premium ? Defines.UICOLOR_GOLD : Defines.UICOLOR_DEFAULT;
    }
}
