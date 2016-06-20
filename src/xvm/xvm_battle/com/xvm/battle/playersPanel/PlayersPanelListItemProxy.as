/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;

    public dynamic class PlayersPanelListItemProxy
    {
        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;

        private var cfg:CPlayersPanel;
        private var enabled:Boolean;
        private var owner:PlayersPanelListItem;

        public function PlayersPanelListItemProxy(owner:PlayersPanelListItem)
        {
            this.owner = owner;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);

            DEFAULT_BG_ALPHA = owner.bg.alpha;
            DEFAULT_SELFBG_ALPHA = owner.selfBg.alpha;
            DEFAULT_DEADBG_ALPHA = owner.deadBg.alpha;

            // TODO: is required?
            //if (wrapper.m_names.condenseWhite)
            //    wrapper.m_names.condenseWhite = false;
            //if (wrapper.m_vehicles.condenseWhite)
            //    wrapper.m_vehicles.condenseWhite = false;
            //if (wrapper.m_frags.wordWrap)
            //    wrapper.m_frags.wordWrap = false;

        }

        public function configUI():void
        {
            onConfigLoaded(null);
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                cfg = Config.config.playersPanel;
                enabled = Macros.GlobalBoolean(cfg.enabled, true);

                if (enabled)
                {
                    var alpha:Number = Macros.GlobalNumber(cfg.alpha, 60) / 100.0;
                    owner.bg.alpha = alpha;
                    owner.selfBg.alpha = alpha;
                    owner.deadBg.alpha = alpha;
                }
                else
                {
                    owner.bg.alpha = DEFAULT_BG_ALPHA;
                    owner.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    owner.deadBg.alpha = DEFAULT_DEADBG_ALPHA;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }
    }
}
