package 
{
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.text.ime.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    
    public dynamic class ProfileSummaryWindow_UI extends net.wg.gui.lobby.profile.pages.summary.ProfileSummaryWindow
    {
        public function ProfileSummaryWindow_UI()
        {
            super();
            this.__setProp_tfWins_ProfileSummaryWindow_UI_tf();
            this.__setProp_tfAvgDamage_ProfileSummaryWindow_UI_tf();
            this.__setProp_tfHits_ProfileSummaryWindow_UI_tf();
            this.__setProp_tfAvgExperience_ProfileSummaryWindow_UI_tf();
            return;
        }

        internal function __setProp_tfWins_ProfileSummaryWindow_UI_tf():*
        {
            try 
            {
                tfWins["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            tfWins.description = "Total Battles Description";
            tfWins.enabled = true;
            tfWins.enableInitCallback = false;
            tfWins.iconSource = "";
            tfWins.text = "55";
            tfWins.visible = true;
            try 
            {
                tfWins["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function __setProp_tfAvgDamage_ProfileSummaryWindow_UI_tf():*
        {
            try 
            {
                tfAvgDamage["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            tfAvgDamage.description = "Total Battles Description";
            tfAvgDamage.enabled = true;
            tfAvgDamage.enableInitCallback = false;
            tfAvgDamage.iconSource = "";
            tfAvgDamage.text = "55 777";
            tfAvgDamage.visible = true;
            try 
            {
                tfAvgDamage["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function __setProp_tfHits_ProfileSummaryWindow_UI_tf():*
        {
            try 
            {
                tfHits["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            tfHits.description = "Total Battles Description";
            tfHits.enabled = true;
            tfHits.enableInitCallback = false;
            tfHits.iconSource = "";
            tfHits.text = "55 777";
            tfHits.visible = true;
            try 
            {
                tfHits["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function __setProp_tfAvgExperience_ProfileSummaryWindow_UI_tf():*
        {
            try 
            {
                tfAvgExperience["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            tfAvgExperience.description = "Total Battles Description";
            tfAvgExperience.enabled = true;
            tfAvgExperience.enableInitCallback = false;
            tfAvgExperience.iconSource = "";
            tfAvgExperience.text = "55 777";
            tfAvgExperience.visible = true;
            try 
            {
                tfAvgExperience["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}
