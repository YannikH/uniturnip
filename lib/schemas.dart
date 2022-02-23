class Schemas {
  static const Map<String, dynamic> demoNested = {
    "title": "A registration form",
    "description": "A simple form example.",
    "type": "object",
    "required": ["firstName", "lastName"],
    "properties": {
      "firstName": {
        "enum": ["a", "b", "c"],
        "type": "string",
        "title": "First name",
        "default": "Chuck",
        "description": "This is field description"
      },
      "newInput1": {
        "items": {
          "type": "string",
          "title": "lkmk"
        },
        "title": "New Input 1",
        "type": "array"
      },
      "lastName": {"type": "boolean", "title": "Last name"},
      "telephone": {"type": "string", "title": "Telephone", "minLength": 10},
      "obj": {
        "title": "A registration form",
        "description": "A simple form example.",
        "type": "object",
        "required": ["firstName", "lastName"],
        "properties": {
          "first": {
            "enum": ["d", "e", "f"],
            "type": "string",
            "title": "First name",
            "default": "Chuck",
            "description": "This is field description"
          },
          "lastName": {"type": "boolean", "title": "Last name"},
          "telephone": {
            "type": "string",
            "title": "Telephone",
            "minLength": 10
          }
        }
      }
    }
  };
}