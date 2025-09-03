__author__ = 'Alex'

from loader import JSONxLoaderException


def load(file_path, log_func=None):
    import loader
    config_loader = loader.JSONxLoader(file_path, log_func)
    return config_loader.load()
