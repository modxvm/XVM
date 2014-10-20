package net.wg.gui.components.controls
{
    import net.wg.utils.IHelpLayout;
    import flash.geom.Rectangle;
    
    public class CrewOperationBtn extends IconButton
    {
        
        public function CrewOperationBtn()
        {
            super();
        }
        
        private var _helpLayoutX:Number = 0;
        
        private var _helpLayoutW:Number = 0;
        
        public function showHelpLayoutEx(param1:Number, param2:Number) : void
        {
            this._helpLayoutX = param1;
            this._helpLayoutW = param2;
            showHelpLayout();
        }
        
        override protected function getParamsForHelpLayout(param1:String, param2:String) : Object
        {
            var _loc3_:IHelpLayout = App.utils.helpLayout;
            var _loc4_:Rectangle = new Rectangle(this._helpLayoutX,0,this._helpLayoutW,height + 1);
            return _loc3_.getProps(_loc4_,param1,param2);
        }
    }
}
