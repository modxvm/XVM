import time
from xvm_main.python.logger import *


@xvm.export('xvm.formatDate', deterministic=False)
def xvm_formatDate(formatDate):
    import locale
    t = time.strftime(formatDate).decode(locale.getdefaultlocale()[1])
    return '{}'.format(t)

