package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class BuildingAttackIndicator extends MovieClip implements IDisposable
    {
        
        public function BuildingAttackIndicator()
        {
            super();
            addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
        }
        
        private var _ttHeader:String = "";
        
        private var _ttBody:String = "";
        
        public function dispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
        }
        
        public function setTooltipData(param1:String, param2:String) : void
        {
            this._ttHeader = param1;
            this._ttBody = param2;
        }
        
        private function rollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function rollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = new ComplexTooltipHelper().addHeader(this._ttHeader).addBody(this._ttBody).make();
            if(_loc2_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
    }
}
