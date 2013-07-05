/**
 * Over-target markers. All settings moved to separate files.
 * Маркеры над танками. Все настройки вынесены в отдельные файлы.
 */
{
  "markers": {
    // союзник
    "ally": {
	  // союзник/живой
      "alive": {
	    // союзник/живой/нормальный режим (без Alt)
        "normal": ${"markersAliveNormal.xc":"ally"},
		// союзник/живой/расширенный режим (c Alt)
        "extended": ${"markersAliveExtended.xc":"ally"}
      },
	  // союзник/мертвый
      "dead": {
	    // союзник/мертвый/нормальный режим (без Alt)
        "normal": ${"markersDeadNormal.xc":"ally"},
		// союзник/мертвый/расширенный режим (c Alt)
        "extended": ${"markersDeadExtended.xc":"ally"}
      }
    },
	// противник
    "enemy": {
	  // противник/живой
      "alive": {
	    // противник/живой/нормальный режим (без Alt)
        "normal": ${"markersAliveNormal.xc":"enemy"},
		// противник/живой/расширенный режим (c Alt)
        "extended": ${"markersAliveExtended.xc":"enemy"}
      },
	  // противник/мертвый
      "dead": {
	    // противник/мертвый/нормальный режим (без Alt)
        "normal": ${"markersDeadNormal.xc":"enemy"},
		// противник/мертвый/расширенный режим (c Alt)
        "extended": ${"markersDeadExtended.xc":"enemy"}
      }
    }
  }
}