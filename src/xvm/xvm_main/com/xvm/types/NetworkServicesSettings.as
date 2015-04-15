/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types
{
    import com.xvm.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;

    public dynamic class NetworkServicesSettings extends DAAPIDataClass
    {
        public var servicesActive:Boolean;
        public var statBattle:Boolean;
        public var statAwards:Boolean;
        public var statCompany:Boolean;
        public var comments:Boolean;
        public var chance:Boolean;
        public var chanceLive:Boolean;
        public var chanceResults:Boolean;
        public var scale:String = Values.EMPTY_STR;
        public var rating:String = Values.EMPTY_STR;
        public var topClansCount:Number;
        public var flag:String = Values.EMPTY_STR;

        public function NetworkServicesSettings(data:Object)
        {
            super(data);
        }
    }
}
