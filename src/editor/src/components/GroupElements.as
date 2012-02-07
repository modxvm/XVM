package components
{
	import utils.Const;
	
	public class GroupElements extends GroupComponent
	{
		public function GroupElements()
		{
			super();
			width = 135;
			height = 212;
		}

		protected override function get title():String
		{
			return "Элемент маркера";
		}

		protected override function get elements():Array
		{
			return [
				{label:"Класс танка", path:"vehicleIcon"},
				{label:"Имя игрока", path:"playerName"},
				{label:"Название танка", path:"vehicleName"},
				{label:"Уровень здоровья", path:"healthBar"},
				{label:"Текущее здоровье", path:"currentHealth"},
				{label:"Процент здоровья", path:"healthRatio"},
				{label:"Текущий урон", path:"combatScrollText"},
				{label:"Контур танка", path:"contourIcon"},
				{label:"Уровень танка", path:"levelIcon"},
				{label:"Маркер действия", path:"actionMarker"}
			];
		}
		
		public override function setMode(mode:int):void
		{
			this._mode = Const.MODE_SINGLE;
			panel.title = title;
			cbMode.visible = false;
			vs.selectedIndex = 0;
		}
	}
}
