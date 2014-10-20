/**
 * XVM Config
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types
{
    import com.xvm.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class NetworkServicesSettings extends DAAPIDataClass
    {
        public var servicesActive:Boolean;
        public var statBattle:Boolean;
        public var statAwards:Boolean;
        public var statCompany:Boolean;
        public var comments:Boolean;
        public var chance:Boolean;
        public var chanceLive:Boolean;

        public function NetworkServicesSettings(data:Object)
        {
            super(data);
        }
    }
}
