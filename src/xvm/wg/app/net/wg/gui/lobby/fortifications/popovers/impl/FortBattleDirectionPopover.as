package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.meta.impl.FortBattleDirectionPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortBattleDirectionPopoverMeta;
    import net.wg.gui.components.controls.SortableTable;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.BattleDirectionPopoverVO;
    import net.wg.gui.lobby.fortifications.events.JoinFortBattleEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.utilData.TwoDimensionalPadding;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class FortBattleDirectionPopover extends FortBattleDirectionPopoverMeta implements IFortBattleDirectionPopoverMeta
    {
        
        public function FortBattleDirectionPopover()
        {
            super();
        }
        
        public var table:SortableTable;
        
        public var directionTitleTF:TextField;
        
        public var nextBattlesTF:TextField;
        
        private var data:BattleDirectionPopoverVO = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.table.addEventListener(JoinFortBattleEvent.JOIN_FORT_BATTLE,this.handleJoinRequest,true);
        }
        
        override protected function setData(param1:BattleDirectionPopoverVO) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void
        {
            this.table.removeEventListener(JoinFortBattleEvent.JOIN_FORT_BATTLE,this.handleJoinRequest,true);
            this.table.dispose();
            this.table = null;
            this.directionTitleTF = null;
            this.nextBattlesTF = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                this.directionTitleTF.htmlText = this.data.title;
                this.nextBattlesTF.htmlText = this.data.nextBattles;
                this.table.listDP = new DataProvider(this.data.battlesList);
            }
        }
        
        override protected function getKeyPointPadding() : TwoDimensionalPadding
        {
            var _loc1_:DisplayObject = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
            var _loc2_:Number = _loc1_.width / 2;
            var _loc3_:Number = _loc1_.height / 2;
            return new TwoDimensionalPadding(new Point(-_loc2_,-_loc1_.height),new Point(0,-_loc3_),new Point(-_loc2_,0),new Point(-_loc1_.width,-_loc3_));
        }
        
        private function handleJoinRequest(param1:JoinFortBattleEvent) : void
        {
            requestToJoinS(param1.fortBattleID);
        }
    }
}
