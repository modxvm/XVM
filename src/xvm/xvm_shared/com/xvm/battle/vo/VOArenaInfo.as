/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xvm.vo.*;

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

        public function VOArenaInfo(data:Object/*net.wg.data.VO.daapi.DAAPIArenaInfoVO*/)
        {
            allyTeamName = data.allyTeamName;
            battleTypeFrameLabel = data.battleTypeFrameLabel;
            battleTypeLocaleStr = data.battleTypeLocaleStr;
            enemyTeamName = data.enemyTeamName;
            mapIcon = data.mapIcon;
            mapName = data.mapName;
            winText = data.winText;
            if (data.questTipsVO)
            {
                questTipsTitle = data.getQuestTipsTitle();
                questTipsMainCondition = data.getQuestTipsMainCondition();
                questTipsAdditionalCondition = data.getQuestTipsAdditionalCondition();
            }
        }
    }
}
