package net.wg.gui.lobby.fortifications.intelligence.impl.cmp
{
    import net.wg.gui.components.controls.TableRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.fortifications.data.IntelligenceRendererVO;
    import net.wg.data.constants.Tooltips;
    import scaleform.clik.constants.InvalidationType;
    
    public class IntelligenceRenderer extends TableRenderer
    {
        
        public function IntelligenceRenderer()
        {
            super();
        }
        
        public var levelIcon:UILoaderAlt;
        
        public var timeTF:TextField;
        
        public var buildingsTF:TextField;
        
        public var availableTF:TextField;
        
        public var clanTag:TextField;
        
        public var bookmarkIcon:Sprite;
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            var _loc2_:IntelligenceRendererVO = IntelligenceRendererVO(data);
            super.handleMouseRollOver(param1);
            App.toolTipMgr.showSpecial(Tooltips.CLAN_INFO,null,_loc2_.clanID);
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            super.handleMouseRollOut(param1);
        }
        
        override protected function draw() : void
        {
            var _loc1_:IntelligenceRendererVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                _loc1_ = data as IntelligenceRendererVO;
                if(_loc1_)
                {
                    this.visible = true;
                    this.levelIcon.source = _loc1_.levelIcon;
                    this.timeTF.htmlText = _loc1_.defenceTime;
                    this.buildingsTF.htmlText = _loc1_.avgBuildingLvl.toString();
                    this.availableTF.htmlText = _loc1_.availability;
                    this.clanTag.htmlText = _loc1_.clanTag;
                    this.bookmarkIcon.visible = _loc1_.isFavorite;
                }
                else
                {
                    this.visible = false;
                }
            }
        }
    }
}
