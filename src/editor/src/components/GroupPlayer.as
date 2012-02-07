package components
{
	public class GroupPlayer extends GroupComponent
	{
		public function GroupPlayer()
		{
			super();
			width = 135;
			height = 100;
		}

		protected override function get title():String
		{
			return "Игрок";
		}

		protected override function get elements():Array
		{
			return [
				{label:"Союзник", path:"ally"},
				{label:"Противник", path:"enemy"},
				{label:"Взводный", path:"squad"},
				{label:"Тимкиллер", path:"teamKiller"},
			];
		}
	}
}
