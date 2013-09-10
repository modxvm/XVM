package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class CrewMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function CrewMeta()
        {
            super();
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

        public function unloadAllTankmanS():void
        {
            App.utils.asserter.assertNotNull(this.unloadAllTankman, "unloadAllTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.unloadAllTankman();
            return;
        }

        public function equipTankmanS(arg1:String, arg2:Number):void
        {
            App.utils.asserter.assertNotNull(this.equipTankman, "equipTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.equipTankman(arg1, arg2);
            return;
        }

        public function openPersonalCaseS(arg1:String, arg2:uint):void
        {
            App.utils.asserter.assertNotNull(this.openPersonalCase, "openPersonalCase" + net.wg.data.constants.Errors.CANT_NULL);
            this.openPersonalCase(arg1, arg2);
            return;
        }

        public function updateTankmenS():void
        {
            App.utils.asserter.assertNotNull(this.updateTankmen, "updateTankmen" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateTankmen();
            return;
        }

        public var onShowRecruitWindowClick:Function=null;

        public var unloadTankman:Function=null;

        public var unloadAllTankman:Function=null;

        public var equipTankman:Function=null;

        public var openPersonalCase:Function=null;

        public var updateTankmen:Function=null;
    }
}
