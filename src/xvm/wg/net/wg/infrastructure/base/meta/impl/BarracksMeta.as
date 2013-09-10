package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BarracksMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function BarracksMeta()
        {
            super();
            return;
        }

        public function invalidateTanksListS():void
        {
            App.utils.asserter.assertNotNull(this.invalidateTanksList, "invalidateTanksList" + net.wg.data.constants.Errors.CANT_NULL);
            this.invalidateTanksList();
            return;
        }

        public function setFilterS(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void
        {
            App.utils.asserter.assertNotNull(this.setFilter, "setFilter" + net.wg.data.constants.Errors.CANT_NULL);
            this.setFilter(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function onShowRecruitWindowClickS(arg1:Object, arg2:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.onShowRecruitWindowClick, "onShowRecruitWindowClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onShowRecruitWindowClick(arg1, arg2);
            return;
        }

        public function unloadTankmanS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.unloadTankman, "unloadTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.unloadTankman(arg1);
            return;
        }

        public function dismissTankmanS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.dismissTankman, "dismissTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.dismissTankman(arg1);
            return;
        }

        public function buyBerthsS():void
        {
            App.utils.asserter.assertNotNull(this.buyBerths, "buyBerths" + net.wg.data.constants.Errors.CANT_NULL);
            this.buyBerths();
            return;
        }

        public function closeBarracksS():void
        {
            App.utils.asserter.assertNotNull(this.closeBarracks, "closeBarracks" + net.wg.data.constants.Errors.CANT_NULL);
            this.closeBarracks();
            return;
        }

        public function setTankmenFilterS():void
        {
            App.utils.asserter.assertNotNull(this.setTankmenFilter, "setTankmenFilter" + net.wg.data.constants.Errors.CANT_NULL);
            this.setTankmenFilter();
            return;
        }

        public function openPersonalCaseS(arg1:String, arg2:uint):void
        {
            App.utils.asserter.assertNotNull(this.openPersonalCase, "openPersonalCase" + net.wg.data.constants.Errors.CANT_NULL);
            this.openPersonalCase(arg1, arg2);
            return;
        }

        public var invalidateTanksList:Function=null;

        public var setFilter:Function=null;

        public var onShowRecruitWindowClick:Function=null;

        public var unloadTankman:Function=null;

        public var dismissTankman:Function=null;

        public var buyBerths:Function=null;

        public var closeBarracks:Function=null;

        public var setTankmenFilter:Function=null;

        public var openPersonalCase:Function=null;
    }
}
