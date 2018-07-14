import logging


class PropertiesExpresa:
    __instance = None
    __logger = None

    def __new__(cls, *args, **kwargs):
        if PropertiesExpresa.__instance is None:
            PropertiesExpresa.__instance = object.__new__(cls)
        return PropertiesExpresa.__instance

    def __init__(self):
        logging.basicConfig(level=logging.DEBUG)
        self.__logger = logging.getLogger(__name__)
        handler = logging.FileHandler('../../log.log')
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        self.__logger.addHandler(handler)

    def get_logger(self):
        return self.__logger




