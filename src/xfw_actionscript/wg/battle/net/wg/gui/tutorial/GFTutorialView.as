package net.wg.gui.tutorial
{
    import net.wg.infrastructure.base.meta.impl.GFTutorialViewMeta;
    import net.wg.infrastructure.base.meta.IGFTutorialViewMeta;
    import flash.display.DisplayObjectContainer;
    import net.wg.data.constants.Values;

    public class GFTutorialView extends GFTutorialViewMeta implements IGFTutorialViewMeta
    {

        private static const INVALID_COMPONENT:String = "You must call as_createHintAreaInComponent with " + "valid component name before as_removeHintArea";

        private static const VIEW_DOESNT_EXISTS:String = "View doen\'t contain component with name = ";

        private var _componentName:String = "";

        public function GFTutorialView()
        {
            super();
        }

        public function as_createHintAreaInComponent(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int) : void
        {
            this._componentName = param1;
            var _loc7_:DisplayObjectContainer = this.getGFComponent(this._componentName);
            if(_loc7_)
            {
                App.tutorialMgr.addHintZoneForGFComponent(_loc7_,param2,param3,param4,param5,param6);
            }
            else
            {
                this.raiseInvalidComponent();
            }
        }

        public function as_removeHintArea(param1:String) : void
        {
            var _loc2_:DisplayObjectContainer = this.getGFComponent(this._componentName);
            if(_loc2_)
            {
                App.tutorialMgr.removeHintZoneForGFComponent(_loc2_,param1);
            }
            else
            {
                this.raiseInvalidComponent();
            }
        }

        private function raiseInvalidComponent() : void
        {
            if(this._componentName == Values.EMPTY_STR)
            {
                DebugUtils.LOG_WARNING(INVALID_COMPONENT);
            }
            else
            {
                DebugUtils.LOG_ERROR(VIEW_DOESNT_EXISTS + this._componentName);
            }
        }

        private function getGFComponent(param1:String) : DisplayObjectContainer
        {
            return this[param1];
        }
    }
}
