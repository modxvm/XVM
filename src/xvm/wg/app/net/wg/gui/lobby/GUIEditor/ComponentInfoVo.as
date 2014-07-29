package net.wg.gui.lobby.GUIEditor
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import net.wg.utils.IAssertable;
    
    public class ComponentInfoVo extends Object implements IDisposable
    {
        
        public function ComponentInfoVo(param1:String)
        {
            super();
            this._linkage = param1;
        }
        
        private var _linkage:String = null;
        
        private var _component:DisplayObject = null;
        
        public function isAvailable() : Boolean
        {
            this._component = this.clone();
            return !(this._component == null);
        }
        
        public function clone() : DisplayObject
        {
            var asserter:IAssertable = null;
            var component:DisplayObject = null;
            try
            {
                asserter = App.utils.asserter;
                asserter.enableErrorLogging(false);
                component = App.utils.classFactory.getComponent(this._linkage,Object,{});
                asserter.enableErrorLogging(true);
            }
            catch(e:Error)
            {
                component = null;
            }
            return component;
        }
        
        public function dispose() : void
        {
            if(this._component is IDisposable)
            {
                IDisposable(this._component).dispose();
            }
            this._component = null;
        }
        
        public function get linkage() : String
        {
            return this._linkage;
        }
        
        public function get shortLinkageName() : String
        {
            var _loc1_:Array = this._linkage.split("::");
            return _loc1_[_loc1_.length - 1];
        }
        
        public function get component() : DisplayObject
        {
            return this._component;
        }
    }
}
