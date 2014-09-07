package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.ParamsMeta;
    import net.wg.infrastructure.base.meta.IParamsMeta;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import net.wg.gui.components.controls.WgScrollingList;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.hangar.data.HangarParamsVO;
    import net.wg.gui.lobby.hangar.data.HangarParamVO;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.utils.IHelpLayout;
    import net.wg.data.constants.Directions;
    import scaleform.clik.data.DataProvider;
    
    public class Params extends ParamsMeta implements IParamsMeta, IHelpLayoutComponent
    {
        
        public function Params()
        {
            super();
            this.paramsListeners = new ParamsListener();
        }
        
        public var list:WgScrollingList;
        
        private var paramsListeners:ParamsListener = null;
        
        private var _helpLayout:DisplayObject;
        
        override protected function setValues(param1:HangarParamsVO) : void
        {
            var _loc2_:Number = 28;
            this.list.height = _loc2_ * param1.params.length;
            this.list.visible = Boolean(param1.params.length);
            this.list.dataProvider = this.setupDataProvider(param1.params);
        }
        
        public function as_highlightParams(param1:String) : void
        {
            var _loc4_:HangarParamVO = null;
            var _loc2_:IDataProvider = this.list.dataProvider;
            var _loc3_:uint = _loc2_.length;
            for each(_loc4_ in _loc2_)
            {
                _loc4_.selected = this.paramsListeners.getParams(param1).indexOf(_loc4_.text) > -1;
            }
            this.list.invalidateData();
        }
        
        public function showHelpLayout() : void
        {
            var _loc4_:* = NaN;
            var _loc5_:TankParam = null;
            var _loc1_:Number = 0;
            if((this.list) && this.list.dataProvider.length > 0)
            {
                _loc4_ = 0;
                while(_loc4_ < this.list.dataProvider.length)
                {
                    _loc5_ = this.list.getRendererAt(_loc4_) as TankParam;
                    _loc1_ = Math.max(_loc1_,_loc5_.tfField.width + _loc5_.paramField.textWidth);
                    _loc4_++;
                }
                _loc1_ = _loc1_ + 15;
            }
            else
            {
                _loc1_ = _width;
            }
            var _loc2_:IHelpLayout = App.utils.helpLayout;
            var _loc3_:Object = _loc2_.getProps(_loc1_ ^ 0,_height,Directions.LEFT,LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS,_width - _loc1_ ^ 0,0,_loc2_.defConnectorLength);
            this._helpLayout = _loc2_.create(root,_loc3_,this);
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            _loc1_.destroy(this._helpLayout);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = false;
            mouseEnabled = false;
        }
        
        override protected function onDispose() : void
        {
            this.list.dispose();
            this.list = null;
            this.paramsListeners.dispose();
            this.paramsListeners = null;
            if(this._helpLayout)
            {
                this.closeHelpLayout();
                this._helpLayout = null;
            }
            super.onDispose();
        }
        
        private function setupDataProvider(param1:Array) : IDataProvider
        {
            return new DataProvider(param1);
        }
    }
}
