package preview
{

import com.greensock.OverwriteManager;
import com.greensock.plugins.*;

import flash.text.TextField;

import preview.*;
import preview.damage.*;

import utils.*;

/*
 * XVM() instance creates corresponding marker
 * each time some player gets in line of sight.
 * Instantiated 14 times at normal round start.
 * Destructed when player get out of sight.
 * Thus may be instantiated ~50 times and more.
 */

public class Xvm extends XvmBase
{
    /**
     * .ctor()
     * @param	proxy Parent proxy class (for placing UI Components)
     */
    function Xvm(proxy:Marker)
    {
        super(); // gfx.core.UIComponent
        _proxy = proxy;

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([AutoAlphaPlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin,
            CacheAsBitmapPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, EndArrayPlugin,
            FrameBackwardPlugin, FrameForwardPlugin, FrameLabelPlugin, FramePlugin, GlowFilterPlugin,
            HexColorsPlugin, QuaternionsPlugin, RemoveTintPlugin, RoundPropsPlugin, ScalePlugin, ScrollRectPlugin,
            SetSizePlugin, ShortRotationPlugin, TintPlugin, TransformMatrixPlugin, VisiblePlugin, VolumePlugin]);
    }

    /**
     * IVehicleMarker implementation
     */

    /**
     * @see IVehicleMarker
     */
    function init(vClass, vIconSource, vType, vLevel, pFullName,
        curHealth, maxHealth, entityName, speaking, hunt, entityType)
    {
        m_playerFullName = pFullName; // alex

        trace("Xvm::init(): " + entityName + ", " + entityType);

        m_defaultIconSource = vIconSource; // ../maps/icons/vehicle/contour/usa-M48A1.png
        m_source = vIconSource;
        m_entityName = entityName; // ally, enemy, squadman, teamKiller
        m_entityType = entityType; // ally, enemy
        m_maxHealth = maxHealth;

        m_vname = vType; // AMX50F155
        m_level = vLevel;
        m_speaking = speaking;

        m_isDead    = curHealth <= 0; // -1 for ammunition storage explosion
        m_curHealth = curHealth >= 0 ? (curHealth) : (0);

        vehicleState = new VehicleState(new VehicleStateProxy(this));

        healthBarComponent = new HealthBarComponent(new HealthBarProxy(this));
        clanIconComponent = new ClanIconComponent(new ClanIconProxy(this));
        contourIconComponent = new ContourIconComponent(new ContourIconProxy(this));
        levelIconComponent = new LevelIconComponent(new LevelIconProxy(this));
        vehicleTypeComponent = new VehicleTypeComponent(new VehicleTypeProxy(this), vClass /*mediumTank*/, hunt);
        damageTextComponent = new DamageTextComponent(new DamageTextProxy(this));

        // Create clan icon and place to mc.
        clanIconComponent.m_clanIcon.source = m_entityType == "enemy" ? new Resources.IMG_clan2() : new Resources.IMG_clan1();

        // Draw marker
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function update()
    {
        trace("Xvm::update()");

        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function setEntityName(value)
    {
        trace("Xvm::setEntityName(" + value + ")");
        if (value == m_entityName)
            return;
        m_entityName = value;
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function updateHealth(newHealth:Number, flag:Number, damageType:String):void
    {
        /*
         * newHealth:
         *  1497, 499, 0 and -1 in case of ammo blow up
         * flag - int:
         * 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
         *
         * damageType - string:
         *  "attack", "fire", "ramming", "world_collision", "death_zone", "drowning", "explosion"
         */

        //Logger.add("Xvm::updateHealth(" + flag + ", " + damageType + ", " + newHealth +")");

        m_isDead = newHealth <= 0;

        var delta: Number = newHealth - m_curHealth;
        m_curHealth = m_isDead ? 0 : newHealth; // fixes "-1"

		update();

        if (delta < 0) // Damage has been done
        {
			// markers{ally{alive{normal
            var vehicleStateCfg:Object = vehicleState.getCurrentConfig();

            //healthBarComponent.updateState(vehicleStateCfg);
            healthBarComponent.showDamage(vehicleStateCfg, newHealth, m_maxHealth, -delta);

            damageTextComponent.showDamage(vehicleStateCfg.damageText, newHealth, -delta, flag, damageType);
        }
    }

    /**
     * @see IVehicleMarker
     */
    function updateState(newState, isImmediate)
    {
        trace("Xvm::updateState(" + newState + ", " + isImmediate + "): " + vehicleState.getCurrentState());

//        if (!initialized)
//            ErrorHandler.setText("updateState: !initialized");

        m_isDead = newState == "dead";

        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function showExInfo(show)
    {
        //trace("Xvm::showExInfo()");
        if (m_showExInfo == show)
            return;
        m_showExInfo = show;

        XVMUpdateStyle();
    }

    /**
    * MAIN
    */

	private var textFields:Array = [];
    function UpdateTextFields(state_cfg:Object):void
    {
		if (!Config.s_config || !Config.s_config.markers)
			return;

		while (textFields.length > 0)
			proxy.removeChild(textFields.pop());
		
		textFields = [];
		var len:Number = state_cfg.textFields.length;
		for (var i:Number = 0; i < len; ++i)
		{
			var cfg:Object = state_cfg.textFields[i];
			if (cfg.visible)
			{
				var tf:TextField = createTextField(cfg);
				tf.htmlText = "<p class='xvm_markerText'>" +
					formatDynamicText(formatStaticText(cfg.format), m_curHealth) + "</p>";
				tf.y += 1; // TODO: why?
				tf.textColor = formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth);
				tf.alpha = formatDynamicAlpha(cfg.alpha, m_curHealth) / 100;
				proxy.addChild(tf);
				tf.visible = true;
				textFields.push(tf);
			}
		}
    }

    function XVMUpdateStyle()
    {
		if (!Config.s_config || !Config.s_config.markers)
			return;
        //trace("XVMUpdateStyle: " + m_playerFullName + m_vname + " " + " scale=" + proxy.marker._xscale);

        var cfg = vehicleState.getCurrentConfig();

        // Vehicle Type Marker
        vehicleTypeComponent.updateState(cfg);

        // Contour Icon
        contourIconComponent.updateState(cfg);

        // Level Icon
        levelIconComponent.updateState(cfg);

        // Action Marker
        //actionMarkerComponent.updateState(cfg);

        // Clan Icon
        clanIconComponent.updateState(cfg);

        // Damage Text
        damageTextComponent.updateState(cfg);

        // Health Bar
        healthBarComponent.updateState(cfg);

        // Update Colors and Values
        UpdateTextFields(cfg);
    }
}

}
