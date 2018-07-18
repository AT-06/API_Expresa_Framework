import yaml
from core.utils.PropertiesExpresa import PropertiesExpresa
import os
class PropertiesManager:

    __instance = None
    __generic_data = None

    def __new__(cls, *args, **kwargs):
        if PropertiesManager.__instance is None:
            PropertiesManager.__instance = object.__new__(cls)
        return PropertiesManager.__instance

    def __init__(self):
        if PropertiesManager.__generic_data is None:
            PropertiesManager.__generic_data = yaml.load(open(
                os.path.normpath(os.path.join(__file__, '../../../') + '/test/features/config/config.yml')))


    def get_property(self, type, property):
        return PropertiesManager.__generic_data[type][property]


