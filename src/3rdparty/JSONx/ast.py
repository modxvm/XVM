__author__ = 'Alex'


class JSONxVisitor(object):
    def visit(self, node):
        return node.accept(self)


class Node(object):
    def __eq__(self, other):
        return isinstance(other, Node)

    def __repr__(self):
        strings = [repr(item) for item in self.__dict__.itervalues()]
        return "{}({})".format(self.__class__.__name__, ', '.join(strings))

    def __str__(self):
        return self.__class__.__name__ + '()'

    def accept(self, visitor):
        pass


class NumberNode(Node):
    def __init__(self, value):
        self.value = value

    def accept(self, visitor):
        return self.value

    def __eq__(self, other):
        return super(NumberNode, self).__eq__(other) \
               and self.value == other.value


class StringNode(Node):
    def __init__(self, value):
        self.value = value

    def accept(self, visitor):
        return self.value

    def __eq__(self, other):
        return super(StringNode, self).__eq__(other) \
               and self.value == other.value


class TrueNode(Node):
    def accept(self, visitor):
        return True

    def __eq__(self, other):
        return isinstance(other, TrueNode)


class FalseNode(Node):
    def accept(self, visitor):
        return False

    def __eq__(self, other):
        return isinstance(other, FalseNode)


class NullNode(Node):
    def accept(self, visitor):
        return None

    def __eq__(self, other):
        return isinstance(other, NullNode)


class ReferenceNode(Node):
    def __init__(self, file_path, object_path):
        self.file = file_path
        self.path = object_path

    def accept(self, visitor):
        return {"$ref": {"file": self.file, "path": self.path}}

    def __eq__(self, other):
        return super(ReferenceNode, self).__eq__(other) \
               and (self.file, self.path) == (other.file, other.path)


class ArrayNode(Node):
    def __init__(self, nodes):
        self.children = nodes

    def accept(self, visitor):
        result = []
        for child in self.children:
            result += visitor.visit(child),
        return result

    def __eq__(self, other):
        return super(ArrayNode, self).__eq__(other) \
               and self.children == other.children


class ObjectNode(Node):
    def __init__(self, pairs):
        self.children = pairs

    def accept(self, visitor):
        result = {}
        for child in self.children:
            key, value = visitor.visit(child)
            result[key] = value
        return result

    def __eq__(self, other):
        return super(ObjectNode, self).__eq__(other) \
               and self.children == other.children


class PairNode(Node):
    def __init__(self, key, value):
        self.key = key
        self.value = value

    def accept(self, visitor):
        return visitor.visit(self.key), visitor.visit(self.value)

    def __eq__(self, other):
        return super(PairNode, self).__eq__(other) \
               and (self.key, self.value) == (other.key, other.value)
