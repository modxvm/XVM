package net.wg.gui.lobby.fortifications.cmp.battleResults
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsRendererVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import scaleform.clik.constants.InvalidationType;
    
    public class FortBattleResultsTableRenderer extends TableRenderer
    {
        
        public function FortBattleResultsTableRenderer()
        {
            super();
            isPassive = true;
        }
        
        public var startTimeTF:TextField = null;
        
        public var buildingTF:TextField = null;
        
        public var resultTF:TextField = null;
        
        public var moreBtn:SoundButtonEx = null;
        
        private var model:BattleResultsRendererVO = null;
        
        override public function setData(param1:Object) : void
        {
            if(param1)
            {
                this.model = new BattleResultsRendererVO(param1);
                invalidateData();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.startTimeTF = null;
            this.buildingTF = null;
            this.resultTF = null;
            if(this.model)
            {
                this.model.dispose();
            }
            this.model = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:IUserProps = null;
            super.draw();
            mouseEnabled = mouseChildren = true;
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.model)
                {
                    this.visible = true;
                    this.startTimeTF.htmlText = this.model.startTime;
                    _loc1_ = App.utils.commons.getUserProps(this.model.building,this.model.clanAbbrev);
                    App.utils.commons.formatPlayerName(this.buildingTF,_loc1_);
                    this.resultTF.htmlText = this.model.result;
                }
                else
                {
                    this.startTimeTF.htmlText = "";
                    this.buildingTF.htmlText = "";
                    this.resultTF.htmlText = "";
                    this.visible = false;
                }
            }
        }
    }
}
