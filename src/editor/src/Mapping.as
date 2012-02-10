package
{
	import components.AlignComboBox;
	import components.ColorSelector;
	import components.FontComboBox;

	import mx.core.UIComponent;
	import mx.utils.ObjectUtil;

	import spark.components.CheckBox;
	import spark.components.NumericStepper;
	import spark.components.TextInput;

	import utils.ElementKind;
	import utils.ItemKind;

	public class Mapping
	{
		// control: "xml/path/to/element" skipping root element
		public static const ValueMapping: Object = {
			// definition
			c_definition_author: "definition/author",
			c_definition_description: "definition/description",
			c_definition_url: "definition/url",
			c_definition_date: "definition/date",
			c_definition_gameVersion: "definition/gameVersion",
			c_definition_modVersion: "definition/modVersion",

			// battle
			c_battle_showPostmortemTips: "battle/showPostmortemTips",
			c_battle_drawGrid: "battle/drawGrid",
			c_battle_disableMirroredVehicleIcons: "battle/disableMirroredVehicleIcons",

			// rating
			c_rating_showPlayersStatistics: "rating/showPlayersStatistics",
			c_rating_showAtBattleLoading: "rating/showAtBattleLoading",
			c_rating_showAtLargePlayersPanel: "rating/showAtLargePlayersPanel",
			c_rating_colorizeMiddlePlayersPanel: "rating/colorizeMiddlePlayersPanel",
			c_rating_showAtStatisticForm: "rating/showAtStatisticForm"

			// ... behaviors is not required here ...
		};

		// Elements
		[Bindable]
		public static var dpConfig:Array = [
			{key:"Положение и цвет", children:[
				{key:"Видимый", item:utils.ItemKind.CheckBox, params:{selected:false, width:110},
					elements:ElementKind.all, path:"visible"},
				{key:"X", item:utils.ItemKind.NumericStepper, params:{minimum:-999, maximum:999, width:110},
					elements:ElementKind.all, path:"x"},
				{key:"Y", item:utils.ItemKind.NumericStepper, params:{minimum:-999, maximum:999, width:110},
					elements:ElementKind.all, path:"y"},
				{key:"Прозрачность", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.all, path:"alpha"},
				{key:"Градиент прозрачности", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"lalpha"},
				{key:"Цвет", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.color, path:"color"},
				{key:"Градиент цвета", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.healthBar, path:"lcolor"},
			]},
			{key:"Текст", children:[
				{key:"Шаблон", item:utils.ItemKind.TextInput, params:{width:110},
					elements:ElementKind.text, path:"text"},
			]},
			{key:"Шрифт", children:[
				{key:"Название", item:utils.ItemKind.FontComboBox, params:{width:110},
					elements:ElementKind.text, path:"font/name"},
				{key:"Размер", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.text, path:"font/size"},
				{key:"Выравнивание", item:utils.ItemKind.AlignComboBox, params:{selectedIndex:1, width:110},
					elements:ElementKind.text, path:"font/align"},
			]},
			{key:"Тень", children:[
				{key:"Размер", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:999, width:110},
					elements:ElementKind.shadow, path:"shadow/size"},
				{key:"Интенсивность", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:999, width:110},
					elements:ElementKind.shadow, path:"shadow/strength"},
				{key:"Угол", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:359, width:110},
					elements:ElementKind.shadow, path:"shadow/angle"},
				{key:"Расстояние", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:999, width:110},
					elements:ElementKind.shadow, path:"shadow/distance"},
				{key:"Цвет", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.shadow, path:"shadow/color"},
				// FIXIT: А есть ли прозрачность у тени?
				{key:"Прозрачность", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.shadow, path:"shadow/alpha"},
			]},
			{key:"Уровень здоровья", children:[
				{key:"Ширина", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"width"},
				{key:"Высота", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"height"},
				{key:"Цвет границы", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.healthBar, path:"border/color"},
				{key:"Прозрачность границы", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"border/alpha"},
				{key:"Толщина границы", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"border/size"},
				{key:"Цвет здоровья", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.healthBar, path:"fill/color"},
				{key:"Прозрачность здоровья", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"fill/alpha"},
				{key:"Цвет урона", item:utils.ItemKind.ColorSelector, params:{width:110},
					elements:ElementKind.healthBar, path:"damage/color"},
				{key:"Прозрачность урона", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.healthBar, path:"damage/alpha"},
				{key:"Затухание урона (мс)", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:10000, width:110},
					elements:ElementKind.healthBar, path:"damage/fade"},
				{key:"Максимальное здоровье", item:utils.ItemKind.CheckBox, params:{selected:true, width:110},
					elements:ElementKind.currentHealth, path:"showMaxValue"},
			]},
			{key:"Текущий урон", children:[
				{key:"Скорость", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.combatScrollText, path:"peed"},
				{key:"Расстояние", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:999, width:110},
					elements:ElementKind.combatScrollText, path:"maxRange"},
				{key:"Текст повреждений", item:utils.ItemKind.TextInput, params:{width:110},
					elements:ElementKind.combatScrollText, path:"damageMessage"},
				{key:"Текст взрыва боеукладки", item:utils.ItemKind.TextInput, params:{width:110},
					elements:ElementKind.combatScrollText, path:"blowupMessage"},
			]},
			{key:"Класс танка", children:[
				{key:"Смещение по X", item:utils.ItemKind.NumericStepper, params:{minimum:-999, maximum:999, width:110},
					elements:ElementKind.vehicleIcon, path:"scaleX"},
				{key:"Смещение по Y", item:utils.ItemKind.NumericStepper, params:{minimum:-999, maximum:999, width:110},
					elements:ElementKind.vehicleIcon, path:"scaleY"},
				{key:"Масштаб (%)", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:999, width:110},
					elements:ElementKind.vehicleIcon, path:"maxScale"},
			]},
			{key:"Контур танка", children:[
				{key:"Тон (%)", item:utils.ItemKind.NumericStepper, params:{minimum:0, maximum:100, width:110},
					elements:ElementKind.contourIcon, path:"amount"},
			]},
		];

		public static function filterData(elements:uint):Array
		{
			var dp:Array = [];

			for each (var o:Object in dpConfig)
			{
				var children:Array = [];
				for each (var ch:Object in o["children"])
				{
					if ((uint(ch["elements"]) & elements) == elements)
						children.push(ch);
				}
				if (children.length > 0)
					dp.push({key:o["key"], children:children});
			}

			return dp;
		}
	}
}