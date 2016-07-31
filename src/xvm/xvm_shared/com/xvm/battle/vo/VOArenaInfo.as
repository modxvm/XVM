/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
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

        public function VOArenaInfo(data:Object)
        {
            allyTeamName = data.allyTeamName;
            battleTypeFrameLabel = data.battleTypeFrameLabel;
            battleTypeLocaleStr = data.battleTypeLocaleStr;
            enemyTeamName = data.enemyTeamName;
            mapIcon = data.mapIcon;
            mapName = data.mapName;
            winText = data.winText;
            if (data.getQuestTipsAdditionalCondition != null)
            {
                questTipsAdditionalCondition = data.getQuestTipsAdditionalCondition();
            }
            if (data.getQuestTipsMainCondition != null)
            {
                questTipsMainCondition = data.getQuestTipsMainCondition();
            }
            if (data.getQuestTipsTitle != null)
            {
                questTipsTitle = data.getQuestTipsTitle();
            }
        }
    }
}
