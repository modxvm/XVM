package preview
{
    import flash.display.MovieClip;
    import flash.events.Event;
    
    import mx.core.UIComponent;
    
    import preview.*;
    
    import utils.*;

    public class Marker extends UIComponent
    {
        public var xvm:Xvm;
        private var isInitialized:Boolean = false;

        public var vehicleIconAlly:MovieClip;
        public var vehicleIconEnemy:MovieClip;
        public var levelIcon:MovieClip;
        private var actionMarkerHelp:MovieClip;
        private var actionMarkerVictim:MovieClip;
        private var actionMarkerArta:MovieClip;

        public var _zoom:Number = 1;
        private var _extmode:Boolean = false;
        private var _actionMarkerVisible:Boolean = true;

        /*

        private var _cfg: Object;

        private var textFields: Array = [];
*/

        public function Marker()
        {
            // Create marker
            xvm = new Xvm(this);
        }

        public function init(vtype:String, vclass:String, vlevel:Number, vname:String):void
        {
            // draw grid
            graphics.beginFill(0xFFFF00, 0.1);
            graphics.drawRect(-75, 0, 150, 1);
            graphics.endFill();
            graphics.beginFill(0xFFFF00, 0.1);
            graphics.drawRect(0, -75, 1, 150);
            graphics.endFill();

            var entity:String = vtype == "ally" || vtype == "ally_dead" ? "ally" : "enemy";
            xvm.init(vclass, null, vname, vlevel, '___Player___[CLAN]', vtype == "ally_dead" ? 0 : 1, 1, entity, false, false, entity); 

            loadSWF(Resources.markersSWF);
        }

        private var loader:ClassLoader;
        private function loadSWF(swf_class:Class):void
        {
            loader = new ClassLoader();
            loader.addEventListener(ClassLoader.LOAD_ERROR,loadErrorHandler);
            loader.addEventListener(ClassLoader.CLASS_LOADED,classLoadedHandler);
            loader.load(swf_class);
        }

        private function loadErrorHandler(e:Event):void {
            throw new Error("Cannot load the specified file.");
        }

        private function classLoadedHandler(e:Event):void
        {
            vehicleIconAlly = CreateMC("markerAlly");
            vehicleIconEnemy = CreateMC("markerEnemy");
            levelIcon = CreateMC("level");
            actionMarkerHelp = CreateMC("actionHelp");
            actionMarkerVictim = CreateMC("actionVictim");
            actionMarkerArta = CreateMC("actionArta");

            addEventListener(Event.ENTER_FRAME, PostInit);
        }

        private function CreateMC(className: String):MovieClip
        {
            var mc:MovieClip = className != null ? new (loader.getClass(className))() as MovieClip : new MovieClip();
            var dow:DisplayObjectWrapper = new DisplayObjectWrapper(mc);
            dow.content.visible = false;
            addChild(dow);
            return mc;
        }

        private function PostInit(event: Event):void
        {
            removeEventListener(Event.ENTER_FRAME, PostInit);

            vehicleIconAlly.marker.icon.gotoAndStop(xvm.vehicleTypeComponent.getVehicleClass());
            vehicleIconAlly.gotoAndPlay(xvm.m_isDead == false ? "normal" : "immediate_dead");
            vehicleIconAlly.marker.scaleX = vehicleIconAlly.marker.scaleY = _zoom;
            vehicleIconAlly.visible = false;

            vehicleIconEnemy.marker.icon.gotoAndStop(xvm.vehicleTypeComponent.getVehicleClass());
            vehicleIconEnemy.gotoAndPlay(xvm.m_isDead == false ? "normal" : "immediate_dead");
            vehicleIconEnemy.marker.scaleX = vehicleIconEnemy.marker.scaleY = _zoom;
            vehicleIconEnemy.visible = false;

            actionMarkerHelp.stop();
            actionMarkerHelp.visible = false;
            actionMarkerVictim.stop();
            actionMarkerVictim.visible = false;
            actionMarkerArta.stop();
            actionMarkerArta.visible = false;

            levelIcon.gotoAndStop(xvm.m_level);
            levelIcon.visible = false;

            isInitialized = true;

            update();
        }

        public function action():void
        {
            var mc:MovieClip;
            if (xvm.m_entityType == "ally")
                mc = actionMarkerHelp;
            else
                mc = Math.round(Math.random()) == 0 ? actionMarkerVictim : actionMarkerArta;
            actionMarkerHelp.stop();
            actionMarkerHelp.visible = false;
            actionMarkerVictim.stop();
            actionMarkerVictim.visible = false;
            actionMarkerArta.stop();
            actionMarkerArta.visible = false;
            mc.visible = _actionMarkerVisible;
            mc.gotoAndPlay(0);
        }

        public function update():void
        {
            if (!isInitialized)
                return;
            if (!Config.s_config || !Config.s_config.markers)
                return;

            var cfg:Object = Config.s_config.markers;
            cfg = xvm.m_entityType == "ally" ? cfg.ally : cfg.enemy;
            cfg = xvm.m_isDead == false ? cfg.alive : cfg.dead;
            cfg = _extmode ? cfg.extended : cfg.normal;

            var c:Object;
            
            // actionMarker
            c = cfg.actionMarker;
            _actionMarkerVisible = c.visible;
            if (actionMarkerHelp.isPlaying)
                actionMarkerHelp.visible = _actionMarkerVisible;
            if (actionMarkerVictim.isPlaying)
                actionMarkerVictim.visible = _actionMarkerVisible;
            if (actionMarkerArta.isPlaying)
                actionMarkerArta.visible = _actionMarkerVisible;
            actionMarkerHelp.x = actionMarkerVictim.x = actionMarkerArta.x = c.x;
            actionMarkerHelp.y = actionMarkerVictim.y = actionMarkerArta.y = c.y;
            actionMarkerHelp.alpha = actionMarkerVictim.alpha = actionMarkerArta.alpha = c.alpha / 100;

            xvm.update();
        }

        public function hit():void
        {
            var blowup:Boolean = Math.round(Math.random() * 5) == 0;
            var hp:Number = blowup ? -1 : xvm.m_curHealth - Math.min(xvm.m_curHealth, Math.round(Math.random() * 500) + 5);
            if (xvm.m_curHealth <= 0)
                hp = xvm.m_maxHealth;
            xvm.updateHealth(hp, xvm.m_entityType == "ally" ? Defines.FROM_ENEMY : Defines.FROM_ALLY, "attack");
        }

        public function set deadType(value:Boolean):void
        {
			vehicleIconAlly.visible = !value;
			vehicleIconEnemy.visible = value;
            xvm.m_entityType = xvm.m_entityName = value == true ? "enemy" : "ally";
            xvm.clanIconComponent.m_clanIcon.source = value ? new Resources.IMG_clan2() : new Resources.IMG_clan1();
            update();
        }

        public function set extMode(value:Boolean):void
        {
            xvm.showExInfo(value);
            update();
        }

        public function set curHP(value:Number):void
        {
			xvm.m_curHealth = value;
			xvm.m_isDead = value <= 0;
            update();
        }

		public function set maxHP(value:Number):void
		{
			xvm.m_maxHealth = value;
			update();
		}

        public function set zoom(value:Number):void
        {
            this._zoom = value;
        }

        /*
        // Damage Visualization
        private function XVMShowDamage(curHealth:Number, delta:Number):void
        {
            var cfg:Object = Config.s_config.markers;
            cfg = xvm.m_entityType == "ally" ? cfg.ally : cfg.enemy;
            cfg = curHealth > 0 ? cfg.alive : cfg.dead;
            cfg = _extmode ? cfg.extended : cfg.normal;

            cfg = cfg.damageText;

            if (!cfg.visible)
                return;

            var msg:String = (curHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
            var text:String = XVMFormatDynamicText(XVMFormatStaticText(msg), curHealth, delta);

            var damageField: TextField = new TextField();
            damageHolder.addChild(damageField);

            damageField.width = 140;
            damageField.height = 20;

            damageField.text = " " + text + " ";
            damageField.antiAliasType = AntiAliasType.ADVANCED;
            damageField.border = false;
            damageField.embedFonts = cfg.font.name == "$FieldFont";
            damageField.defaultTextFormat = XVMCreateNewTextFormat(cfg.font);
            damageField.text = " " + text + " ";
            damageField.textColor = !isNaN(parseInt(cfg.color)) ? int(cfg.color)
                : Config.s_config.colors.system[xvm.m_entityType + "_alive_" + (s_isColorBlindMode ? "blind" : "normal")];
            damageField.x = -(damageField.width / 2.0);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                damageField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            var st:Number = (new Date()).time;
            var timer:Timer = new Timer(10);
            var timerFunc:Function = function():void {
                var d:Number = (new Date()).time - st;
                if (d > cfg.speed * 1000)
                {
                    damageHolder.removeChild(damageField);
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, timerFunc);
                    timer = null;
                    timerFunc = null;
                    return;
                }
                damageField.y = cfg.maxRange * (cfg.speed * 1000 - d) / (cfg.speed * 1000) - cfg.maxRange;
            };
            timer.addEventListener(TimerEvent.TIMER, timerFunc);
            timer.start();
        }

        // Health Visualization
        private var dmgTimer:Timer = new Timer(10);
        private var dmgTimerFunc:Function = null;
        private function XVMSetupNewHealth(curHealth:Number):void
        {
            dmgTimer.stop();
            if (dmgTimerFunc != null)
            {
                dmgTimer.removeEventListener(TimerEvent.TIMER, dmgTimerFunc);
                dmgTimerFunc = null;
            }

            XVMUpdateHealthBar(curHealth); // colorizing health bar after taking damage

            var delta: Number = curHealth - m_curHealth;
            if (delta >= 0)
            {
                m_curHealth = curHealth;
                xvmHBDamage.graphics.clear();
                return;
            }

            XVMShowDamage(curHealth, -delta);

            m_curHealth = curHealth;

            //Flow bar animation
            var cfg:Object = _cfg.healthBar;
            if (cfg.damage.fade > 0)
            {
                var fade:Number = cfg.damage.fade * 1000;
                var color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.damage.color), curHealth);
                var alpha:Number = XVMFormatDynamicAlpha(cfg.damage.alpha, curHealth) / 100;
                var st:Number = (new Date()).time;
                var drawing: Boolean = false;
                dmgTimerFunc = function():void
                {
                    if (drawing)
                        return;
                    drawing = true;
                    var d:Number = (new Date()).time - st;
                    var w:Number = cfg.width * (-delta / m_maxHealth) * (fade - d) / fade;
                    xvmHBDamage.graphics.clear();
                    if (w <= 0)
                    {
                        dmgTimer.stop();
                        dmgTimer.removeEventListener(TimerEvent.TIMER, dmgTimerFunc);
                        dmgTimerFunc = null;
                        return;
                    }
                    xvmHBDamage.graphics.beginFill(color, alpha);
                    xvmHBDamage.graphics.drawRect(
                        cfg.border.size + cfg.width * (1.0 * curHealth / m_maxHealth) - 1, cfg.border.size,
                        w, cfg.height);
                    xvmHBDamage.graphics.endFill();
                    drawing = false;
                };
                dmgTimer.addEventListener(TimerEvent.TIMER, dmgTimerFunc);
                dmgTimer.start();
            }
        }

        private function XVMCreateNewTextFormat(config_font: Object): TextFormat
        {
            var name:String = config_font.name || "$FieldFont";
            if (name == "$TextFont")
                name = "Tahoma";
            return new TextFormat(
                name,
                config_font.size || 13,
                0x000000,
                config_font.bold,
                config_font.italic,
                false, null, null,
                config_font.align || "center",
                0, 0, 0, 0);
        }

        private function XVMCreateTextField(cfg:Object):TextField
        {
            var textField: TextField = new TextField();
            textField.width = 140;
            textField.height = 30;
            //textField.height = cfg.font.size + 4;

            //textField.gridFitType = GridFitType.SUBPIXEL;
            //textField.border = true;
            //textField.borderColor = 0xFFFFFF;
            textField.defaultTextFormat = XVMCreateNewTextFormat(cfg.font);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            textField.textColor = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.color), m_curHealth);
            textField.alpha = XVMFormatDynamicAlpha(cfg.alpha, m_curHealth) / 100;
            textField.x = cfg.x - (textField.width / 2.0);
            textField.y = cfg.y - (textField.height / 2.0);
            if (cfg.font.name != "$FieldFont")
                textField.y--; // -1 to be equal with ScaleForm renderer

            textField.visible = cfg.visible;

            return textField;
        }*/

    }
}
