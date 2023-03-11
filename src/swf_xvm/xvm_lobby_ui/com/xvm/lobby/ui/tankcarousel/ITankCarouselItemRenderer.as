/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.extraFields.*;
    import flash.display.*;
    import net.wg.gui.components.carousels.data.*;
    import scaleform.clik.interfaces.*;

    public interface ITankCarouselItemRenderer extends IUIComponent
    {
        function get substrateHolder():Sprite;
        function set substrateHolder(value:Sprite):void;
        function set bottomHolder(value:Sprite):void;
        function set normalHolder(value:Sprite):void;
        function set topHolder(value:Sprite):void;
        function get extraFields():ExtraFieldsGroup;
        function set extraFields(value:ExtraFieldsGroup):void;
        function get vehicleCarouselVO():VehicleCarouselVO;
    }
}
