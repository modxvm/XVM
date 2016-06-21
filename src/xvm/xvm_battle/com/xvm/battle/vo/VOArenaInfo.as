package com.xvm.battle.vo
{
    import com.xvm.vo.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public class VOArenaInfo extends VOBase
    {
        public var allyTeamName : String;
        public var battleTypeFrameLabel : String;
        public var battleTypeLocaleStr : String;
        public var enemyTeamName : String;
        public var mapIcon : String;
        public var mapName : String;
        public var winText : String;
        public var questTipsAdditionalCondition : String;
        public var questTipsMainCondition : String;
        public var questTipsTitle : String;

        public function VOArenaInfo(data:IDAAPIDataClass)
        {
            var d:DAAPIArenaInfoVO = DAAPIArenaInfoVO(data);
            allyTeamName = d.allyTeamName;
            battleTypeFrameLabel = d.battleTypeFrameLabel;
            battleTypeLocaleStr = d.battleTypeLocaleStr;
            enemyTeamName = d.enemyTeamName;
            mapIcon = d.mapIcon;
            mapName = d.mapName;
            winText = d.winText;
            questTipsAdditionalCondition = d.getQuestTipsAdditionalCondition();
            questTipsMainCondition = d.getQuestTipsMainCondition();
            questTipsTitle = d.getQuestTipsTitle();
        }
    }
}
