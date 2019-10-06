package net.wg.app.iml.base
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IRootAppMainContent;
    import flash.utils.getDefinitionByName;
    import flash.display.DisplayObject;

    public class BaseRootApp extends Sprite implements IDisposable
    {

        private var _main:IRootAppMainContent = null;

        public function BaseRootApp(param1:IRootAppMainContent = null)
        {
            super();
            this.setMainContent(param1);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function getObject(param1:String) : Object
        {
            var _loc2_:Class = Class(getDefinitionByName(param1));
            return new _loc2_();
        }

        protected function setMainContent(param1:IRootAppMainContent) : void
        {
            this.tryDisposeMainContent();
            this._main = param1;
            if(this._main != null)
            {
                addChild(DisplayObject(this._main));
            }
        }

        protected function onDispose() : void
        {
            this.tryDisposeMainContent();
        }

        private function tryDisposeMainContent() : void
        {
            var _loc1_:DisplayObject = null;
            if(this._main != null)
            {
                _loc1_ = DisplayObject(this._main);
                if(_loc1_.parent == this)
                {
                    removeChild(_loc1_);
                }
                this._main.dispose();
                this._main = null;
            }
        }

        public function get main() : IRootAppMainContent
        {
            return this._main;
        }
    }
}
