/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.crew
{
    import com.xfw.*;
    import net.wg.gui.lobby.components.*;
    import net.wg.gui.lobby.hangar.crew.*;

    public class CrewItemRendererHelper
    {
        public static function init(r:CrewItemRenderer, x:int, y:int):void
        {
            Logger.add("CrewItemRendererHelper::init --begin");
            try
            {
                if (!(r.skills is UI_SmallSkillsList))
                {
                    var ui:UI_SmallSkillsList = null;
                    var len:int = r.numChildren;
                    for (var i:int = len - 1; i >= 0; --i)
                    {
                        var skills:SmallSkillsList = r.getChildAt(i) as SmallSkillsList;
                        if (skills)
                        {
                            if (skills is UI_SmallSkillsList)
                            {
                                ui = skills as UI_SmallSkillsList;
                            }
                            else
                            {
                                r.removeChild(skills);
                                skills.dispose();
                            }
                        }
                    }
                    if (ui)
                    {
                        r.skills = ui;
                    }
                    else
                    {
                        r.skills = new UI_SmallSkillsList();
                        r.skills.x = x;
                        r.skills.y = y;
                        r.addChild(r.skills);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.add("CrewItemRendererHelper::init --exc");
                Logger.err(ex);
            }

            Logger.add("CrewItemRendererHelper::init --end");
        }
    }
}
