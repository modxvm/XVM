package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieSection;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
    import scaleform.gfx.TextFieldEx;
    
    public class JoinClanBattleSection extends JoinSortieSection
    {
        
        public function JoinClanBattleSection()
        {
            super();
            vehiclesInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
            descriptionTF.mouseEnabled = headerTF.mouseEnabled = false;
            TextFieldEx.setVerticalAlign(descriptionTF,TextFieldEx.VALIGN_CENTER);
            TextFieldEx.setVerticalAlign(headerTF,TextFieldEx.VALIGN_CENTER);
        }
        
        public var battleCreator:ClanBattleCreatorView;
        
        override public function setData(param1:IRallyVO) : void
        {
            super.setData(param1);
        }
        
        override protected function updateDescription(param1:IRallyVO) : void
        {
            descriptionTF.htmlText = param1.description;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            vehiclesLabel = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
        }
        
        override protected function onDispose() : void
        {
            this.battleCreator.dispose();
            this.battleCreator = null;
            super.onDispose();
        }
        
        override protected function updateNoRallyScreen(param1:Boolean) : void
        {
            var _loc3_:* = false;
            var _loc2_:* = false;
            if(model)
            {
                _loc2_ = ClanBattleDetailsVO(model).isCreationAvailable;
            }
            _loc3_ = (_loc2_) && (param1);
            this.battleCreator.visible = _loc3_;
            if(_loc3_)
            {
                this.battleCreator.setData(ClanBattleDetailsVO(model));
            }
            super.updateNoRallyScreen(!this.battleCreator.visible && (param1));
        }
        
        override protected function updateTitle(param1:IRallyVO) : void
        {
            headerTF.htmlText = ClanBattleDetailsVO(model).detailsTitle;
        }
    }
}
