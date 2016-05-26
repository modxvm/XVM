import xvm_main.python.xvm_scale_data as xvm_scale_data

@xvm.export('xvm.xvm2sup')
def XvmScaleToSup(x=None):
    if x is None or x == '':
        return None
    x = 100 if x == 'XX' else int(x)
    return xvm_scale_data.xvm2sup[max(0, min(100, x-1))]
