package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.tutorial.windows.TutorialDialog;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BCNationsWindowMeta extends TutorialDialog
    {

        public var onNationSelected:Function;

        public var onNationShow:Function;

        private var _vectorint:Vector.<int>;

        public function BCNationsWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vectorint)
            {
                this._vectorint.splice(0,this._vectorint.length);
                this._vectorint = null;
            }
            super.onDispose();
        }

        public function onNationSelectedS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.onNationSelected,"onNationSelected" + Errors.CANT_NULL);
            this.onNationSelected(param1);
        }

        public function onNationShowS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.onNationShow,"onNationShow" + Errors.CANT_NULL);
            this.onNationShow(param1);
        }

        public final function as_selectNation(param1:uint, param2:Array) : void
        {
            var _loc3_:Vector.<int> = this._vectorint;
            this._vectorint = new Vector.<int>(0);
            var _loc4_:uint = param2.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                this._vectorint[_loc5_] = param2[_loc5_];
                _loc5_++;
            }
            this.selectNation(param1,this._vectorint);
            if(_loc3_)
            {
                _loc3_.splice(0,_loc3_.length);
            }
        }

        protected function selectNation(param1:uint, param2:Vector.<int>) : void
        {
            var _loc3_:String = "as_selectNation" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
