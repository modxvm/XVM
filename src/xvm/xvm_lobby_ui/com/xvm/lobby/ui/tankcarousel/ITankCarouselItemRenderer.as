/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.extraFields.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;

    public /*dynamic*/ interface ITankCarouselItemRenderer extends IUIComponent
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
