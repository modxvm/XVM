/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types
{
    import com.xvm.vo.*;

    public class NetworkServicesSettings extends VOBase
    {
        public var servicesActive:Boolean;
        public var statBattle:Boolean;
        public var statAwards:Boolean;
        public var comments:Boolean;
        public var scale:String = null;
        public var rating:String = null;
        public var topClansCountWgm:Number;
        public var topClansCountWsh:Number;
        public var flag:String = null;
        public var xmqp:Boolean;
        public var x_minimap_clicks_color:Number;

        public function NetworkServicesSettings(data:Object)
        {
            super(data);
        }
    }
}
