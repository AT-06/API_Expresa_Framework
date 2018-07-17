import yaml
from core.utils.PropertiesExpresa import PropertiesExpresa
class PropertiesManager:

    __instance = None
    __generic_data = None

    def __new__(cls, *args, **kwargs):
        if PropertiesManager.__instance is None:
            PropertiesManager.__instance = object.__new__(cls)
        return PropertiesManager.__instance

    def __init__(self):
        if PropertiesManager.__generic_data is None:
            PropertiesManager.__generic_data = yaml.load(open('../../config/config.yml'))


    def get_property(self, type, property):
        logger = PropertiesExpresa().get_logger()
        logger.debug("get property yml type: %s property: %s"% (type, property))
        return PropertiesManager.__generic_data[type][property]


