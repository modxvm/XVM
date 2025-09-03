__author__ = 'Alex'


class JSONxException(Exception):
    def __init__(self, message, error_position, *args):
        super(JSONxException, self).__init__(message, *args)
        self.error_position = error_position


class LexerException(JSONxException):
    def __init__(self, message, error_position):
        super(LexerException, self).__init__(message, error_position)
        self.error_position = error_position


class ParserException(JSONxException):
    def __init__(self, message, error_position):
        super(ParserException, self).__init__(message, error_position)
