package net.wg.gui.lobby.store.views.base 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    
    public class ViewUIElementVO extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function ViewUIElementVO(arg1:String, arg2:scaleform.clik.controls.Button)
        {
            var loc1:*=null;
            super();
            if (App.instance) 
            {
                loc1 = App.utils.asserter;
                loc1.assertNotNull(arg1, "name" + net.wg.data.constants.Errors.CANT_NULL);
                loc1.assertNotNull(arg2, "instance" + net.wg.data.constants.Errors.CANT_NULL);
            }
            this._name = arg1;
            this._instance = arg2;
            return;
        }

        public function dispose():void
        {
            this._instance = null;
            this._name = null;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function get instance():scaleform.clik.controls.Button
        {
            return this._instance;
        }

        internal var _name:String=null;

        internal var _instance:scaleform.clik.controls.Button=null;
    }
}
