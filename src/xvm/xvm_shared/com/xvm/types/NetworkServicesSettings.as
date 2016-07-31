/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types
{
    import com.xvm.*;
    import com.xvm.vo.*;

    public dynamic class NetworkServicesSettings extends VOBase
    {
        public var servicesActive:Boolean;
        public var statBattle:Boolean;
        public var statAwards:Boolean;
        public var statCompany:Boolean;
        public var comments:Boolean;
        public var chance:Boolean;
        public var chanceLive:Boolean;
        public var chanceResults:Boolean;
        public var scale:String = null;
        public var rating:String = null;
        public var topClansCount:Number;
        public var flag:String = null;
        public var xmqp:Boolean;
        public var x_minimap_clicks_color:Number;

        public function NetworkServicesSettings(data:Object)
        {
            super(data);
        }
    }
}
