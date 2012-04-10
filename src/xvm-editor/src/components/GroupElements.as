package components
{
	import Const;

	public class GroupElements extends GroupComponent
	{
		public function GroupElements()
		{
			super();
			width = 135;
			height = 140;
		}

		protected override function get elements():Array
		{
			return [
				{label:"Класс танка", path:"vehicleIcon"},
				{label:"Уровень здоровья", path:"healthBar"},
				{label:"Текущий урон", path:"damageText"},
				{label:"Контур танка", path:"contourIcon"},
				{label:"Уровень танка", path:"levelIcon"},
				{label:"Маркер действия", path:"actionMarker"},
				{label:"Текстовые поля", path:"textFields"}
			];
		}
	}
}
