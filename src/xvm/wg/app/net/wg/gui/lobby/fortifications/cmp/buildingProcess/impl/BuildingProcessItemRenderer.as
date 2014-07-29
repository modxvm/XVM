package net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessListItemVO;
    import net.wg.data.constants.SoundTypes;
    
    public class BuildingProcessItemRenderer extends TableRenderer
    {
        
        public function BuildingProcessItemRenderer()
        {
            super();
            soundType = SoundTypes.FORT_PROCESS_RENDERER;
            doubleClickEnabled = true;
        }
        
        public var smallBuildingsIcon:MovieClip = null;
        
        public var buildingName:TextField = null;
        
        public var shortDescr:TextField = null;
        
        public var statusLbl:TextField = null;
        
        private var _model:BuildingProcessListItemVO = null;
        
        override public function setData(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            super.setData(param1);
            this._model = param1 as BuildingProcessListItemVO;
            this.smallBuildingsIcon.gotoAndStop(this._model.buildingID);
            this.buildingName.htmlText = this._model.buildingName;
            this.shortDescr.htmlText = this._model.shortDescr;
            this.statusLbl.htmlText = this._model.statusLbl;
        }
        
        public function get model() : BuildingProcessListItemVO
        {
            return this._model;
        }
        
        override protected function onDispose() : void
        {
            this.smallBuildingsIcon = null;
            this.buildingName = null;
            this.shortDescr = null;
            this.statusLbl = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
    }
}
