class Schemas {
  static const Map<String, dynamic> test = {
    "label": "Simple",
    "schema": /*{
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {
          "title": "A child and father were visiting an elderly neighbor. They were raking the neighbors leaves, organizing the neighbors garage, putting the trash out, and performing other small jobs around the neighbors house. The child had not really seen the elderly neighbor up close, but on this day the child was going to meet the neighbor up close for the first time. When the child met the neighbor up close he asked the neighbor how old he was, and the father was flabbergasted by his childs question and attempted to apologize to the neighbor, but the neighbor laughed and said that was ok, the child is curious. The elderly neighbor told the child he was 92 years old. The child had a look of unbelief and asked the neighbor, 'Did you start at the number one?'",
          "type": "string",
        },
        "lastName": {"type": "string", "title": "Last name"},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    }*/
    {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "properties": {
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": {
            "type": "object",
            "properties": {
              "word": {
                "default": "Some word",
                "type": "string",
                "readOnly": true
              },
              "translation": {
                "default": "Какое-то слово",
                "type": "string",
                "readOnly": true
              },
              "count": {
                "title": "Кол-во нажатий",
                "default": 0,
                "type": "integer",
                "readOnly": true
              },
              "active": {
                "title": "Активен",
                "type": "boolean"
              }
            }
          }
        }
      }
    },
    "ui": {
      "fixedItemsList": {
        "ui:widget":"reader"
      },
      "lastName": {"ui:emptyValue": "", "ui:autocomplete": "given-name"},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)"
      },
    },
    "formData": {
      "fixedItemsList":  [
        {
          "word": "The",
          "translation": "артикль",
          "count": 0,
          "active": true
        },
        {
          "word": "first",
          "translation": "первый",
          "count": 0,
          "active": true
        },
        {
          "word": "simple",
          "translation": "простой",
          "count": 0,
          "active": true
        },
        {
          "word": "text",
          "translation": "текст",
          "count": 0,
          "active": true
        }
      ],
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };

  static const Map<String, dynamic> simple = {
    "label": "Simple",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {
          "type": "string",
          "title": "First name",
          "default": "Chuck"
        },
        "lastName": {"type": "string", "title": "Last name"},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {
        "ui:autofocus": true,
        "ui:emptyValue": "",
        "ui:autocomplete": "family-name"
      },
      "lastName": {"ui:emptyValue": "", "ui:autocomplete": "given-name"},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)"
      },
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static const Map<String, dynamic> nested = {
    "label": "Nested",
    "schema": {
      "title": "A list of tasks",
      "type": "object",
      "required": ["title"],
      "properties": {
        "title": {"type": "string", "title": "Task list title"},
        "tasks": {
          "type": "array",
          "title": "Tasks",
          "items": {
            "type": "object",
            "required": ["title"],
            "properties": {
              "title": {
                "type": "string",
                "title": "Title",
                "description": "A sample title"
              },
              "details": {
                "type": "string",
                "title": "Task details",
                "description": "Enter the task details"
              },
              "done": {"type": "boolean", "title": "Done?", "default": false}
            }
          }
        }
      }
    },
    "ui": {
      "tasks": {
        "items": {
          "details": {"ui:widget": "textarea"}
        }
      }
    },
    "formData": {
      "title": "My current tasks",
      "tasks": [
        {
          "title": "My first task",
          "details":
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          "done": true
        },
        {
          "title": "My second task",
          "details":
              "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
          "done": false
        }
      ]
    }
  };

  static const Map<String, dynamic> arrays = {
    "label": "Arrays",
    "schema": {
      "definitions": {
        "Thing": {
          "type": "object",
          "properties": {
            "name": {"type": "string", "default": "Default name"}
          }
        }
      },
      "type": "object",
      "properties": {
        "listOfStrings": {
          "type": "array",
          "title": "A list of strings",
          "items": {"type": "string", "default": "bazinga"}
        },
        "multipleChoicesList": {
          "type": "array",
          "title": "A multiple choices list",
          "items": {
            "type": "string",
            "enum": ["foo", "bar", "fuzz", "qux"]
          },
          "uniqueItems": true
        },
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": [
            {
              "title": "A string value",
              "type": "string",
              "default": "lorem ipsum"
            },
            {"title": "a boolean value", "type": "boolean"}
          ],
          "additionalItems": {"title": "Additional item", "type": "number"}
        },
        "minItemsList": {
          "type": "array",
          "title": "A list with a minimal number of items",
          "minItems": 3,
          "items": {"\$ref": "#/definitions/Thing"}
        },
        "defaultsAndMinItems": {
          "type": "array",
          "title": "List and item level defaults",
          "minItems": 5,
          "default": ["carp", "trout", "bream"],
          "items": {"type": "string", "default": "unidentified"}
        },
        "nestedList": {
          "type": "array",
          "title": "Nested list",
          "items": {
            "type": "array",
            "title": "Inner list",
            "items": {"type": "string", "default": "lorem ipsum"}
          }
        },
        "unorderable": {
          "title": "Unorderable items",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "unremovable": {
          "title": "Unremovable items",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "noToolbar": {
          "title": "No add, remove and order buttons",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "fixedNoToolbar": {
          "title": "Fixed array without buttons",
          "type": "array",
          "items": [
            {"title": "A number", "type": "number", "default": 42},
            {"title": "A boolean", "type": "boolean", "default": false}
          ],
          "additionalItems": {
            "title": "A string",
            "type": "string",
            "default": "lorem ipsum"
          }
        }
      }
    },
    "ui": {
      "listOfStrings": {
        "items": {"ui:emptyValue": ""}
      },
      "multipleChoicesList": {"ui:widget": "checkboxes"},
      "fixedItemsList": {
        "items": [
          {"ui:widget": "textarea"},
          {"ui:widget": "select"}
        ],
        "additionalItems": {"ui:widget": "updown"}
      },
      "unorderable": {
        "ui:options": {"orderable": false}
      },
      "unremovable": {
        "ui:options": {"removable": false}
      },
      "noToolbar": {
        "ui:options": {"addable": false, "orderable": false, "removable": false}
      },
      "fixedNoToolbar": {
        "ui:options": {"addable": false, "orderable": false, "removable": false}
      }
    },
    "formData": {
      "listOfStrings": ["foo", "bar"],
      "multipleChoicesList": ["foo", "bar"],
      "fixedItemsList": ["Some text", true, 123],
      "minItemsList": [
        {"name": "Default name"},
        {"name": "Default name"},
        {"name": "Default name"}
      ],
      "defaultsAndMinItems": [
        "carp",
        "trout",
        "bream",
        "unidentified",
        "unidentified"
      ],
      "nestedList": [
        ["lorem", "ipsum"],
        ["dolor"]
      ],
      "unorderable": ["one", "two"],
      "unremovable": ["one", "two"],
      "noToolbar": ["one", "two"],
      "fixedNoToolbar": [42, true, "additional item one", "additional item two"]
    }
  };
  static const Map<String, dynamic> numbers = {
    "label": "Numbers",
    "schema": {
      "type": "object",
      "title": "Number fields & widgets",
      "properties": {
        "number": {"title": "Number", "type": "number"},
        "integer": {"title": "Integer", "type": "integer"},
        "numberEnum": {
          "type": "number",
          "title": "Number enum",
          "enum": [1, 2, 3]
        },
        "numberEnumRadio": {
          "type": "number",
          "title": "Number enum",
          "enum": [1, 2, 3]
        },
        "integerRange": {
          "title": "Integer range",
          "type": "integer",
          "minimum": 42,
          "maximum": 100
        },
        "integerRangeSteps": {
          "title": "Integer range (by 10)",
          "type": "integer",
          "minimum": 50,
          "maximum": 100,
          "multipleOf": 10
        }
      }
    },
    "ui": {
      "integer": {"ui:widget": "updown"},
      "numberEnumRadio": {
        "ui:widget": "radio",
        "ui:options": {"inline": true}
      },
      "integerRange": {"ui:widget": "range"},
      "integerRangeSteps": {"ui:widget": "range"}
    },
    "formData": {
      "number": 3.14,
      "integer": 42,
      "numberEnum": 2,
      "integerRange": 42,
      "integerRangeSteps": 80
    }
  };
  static const Map<String, dynamic> widgets = {
    "label": "Widgets",
    "schema": {
      "title": "Widgets",
      "type": "object",
      "properties": {
        "stringFormats": {
          "type": "object",
          "title": "String formats",
          "properties": {
            "email": {"type": "string", "format": "email"},
            "uri": {"type": "string", "format": "uri"}
          }
        },
        "boolean": {
          "type": "object",
          "title": "Boolean field",
          "properties": {
            "default": {
              "type": "boolean",
              "title": "checkbox (default)",
              "description": "This is the checkbox-description"
            },
            "radio": {
              "type": "boolean",
              "title": "radio buttons",
              "description": "This is the radio-description"
            },
            "select": {
              "type": "boolean",
              "title": "select box",
              "description": "This is the select-description"
            }
          }
        },
        "string": {
          "type": "object",
          "title": "String field",
          "properties": {
            "default": {"type": "string", "title": "text input (default)"},
            "textarea": {"type": "string", "title": "textarea"},
            "placeholder": {"type": "string"},
            "color": {
              "type": "string",
              "title": "color picker",
              "default": "#151ce6"
            }
          }
        },
        "secret": {"type": "string", "default": "I'm a hidden string."},
        "disabled": {
          "type": "string",
          "title": "A disabled field",
          "default": "I am disabled."
        },
        "readonly": {
          "type": "string",
          "title": "A readonly field",
          "default": "I am read-only."
        },
        "readonly2": {
          "type": "string",
          "title": "Another readonly field",
          "default": "I am also read-only.",
          "readOnly": true
        },
        "widgetOptions": {
          "title": "Custom widget with options",
          "type": "string",
          "default": "I am yellow"
        },
        "selectWidgetOptions": {
          "title": "Custom select widget with options",
          "type": "string",
          "enum": ["foo", "bar"],
          "enumNames": ["Foo", "Bar"]
        }
      }
    },
    "ui": {
      "boolean": {
        "radio": {"ui:widget": "radio"},
        "select": {"ui:widget": "select"}
      },
      "string": {
        "textarea": {
          "ui:widget": "textarea",
          "ui:options": {"rows": 5}
        },
        "placeholder": {"ui:placeholder": "This is a placeholder"},
        "color": {"ui:widget": "color"}
      },
      "secret": {"ui:widget": "hidden"},
      "disabled": {"ui:disabled": true},
      "readonly": {"ui:readonly": true},
      "widgetOptions": {
        "ui:options": {"backgroundColor": "yellow"}
      },
      "selectWidgetOptions": {
        "ui:options": {"backgroundColor": "pink"}
      }
    },
    "formData": {
      "stringFormats": {
        "email": "chuck@norris.net",
        "uri": "http://chucknorris.com/"
      },
      "boolean": {"default": true, "radio": true, "select": true},
      "string": {
        "color": "#151ce6",
        "default": "Hello...",
        "textarea": "... World"
      },
      "secret": "I'm a hidden string.",
      "disabled": "I am disabled.",
      "readonly": "I am read-only.",
      "readonly2": "I am also read-only.",
      "widgetOptions": "I am yellow"
    }
  };
  static const Map<String, dynamic> ordering = {
    "label": "Ordering",
    "schema": {
      "title": "A registration form",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "password": {"type": "string", "title": "Password"},
        "lastName": {"type": "string", "title": "Last name"},
        "bio": {"type": "string", "title": "Bio"},
        "firstName": {"type": "string", "title": "First name"},
        "age": {"type": "integer", "title": "Age"}
      }
    },
    "ui": {
      "ui:order": ["firstName", "lastName", "*", "password"],
      "age": {"ui:widget": "updown"},
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password"}
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static const Map<String, dynamic> references = {
    "label": "References",
    "schema": {
      "definitions": {
        "address": {
          "type": "object",
          "properties": {
            "street_address": {"type": "string"},
            "city": {"type": "string"},
            "state": {"type": "string"}
          },
          "required": ["street_address", "city", "state"]
        },
        "node": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "children": {
              "type": "array",
              "items": {"\$ref": "#/definitions/node"}
            }
          }
        }
      },
      "type": "object",
      "properties": {
        "billing_address": {
          "title": "Billing address",
          "\$ref": "#/definitions/address"
        },
        "shipping_address": {
          "title": "Shipping address",
          "\$ref": "#/definitions/address"
        },
        "tree": {"title": "Recursive references", "\$ref": "#/definitions/node"}
      }
    },
    "ui": {
      "ui:order": ["shipping_address", "billing_address", "tree"]
    },
    "formData": {
      "billing_address": {
        "street_address": "21, Jump Street",
        "city": "Babel",
        "state": "Neverland"
      },
      "shipping_address": {
        "street_address": "221B, Baker Street",
        "city": "London",
        "state": "N/A"
      },
      "tree": {
        "name": "root",
        "children": [
          {"name": "leaf"}
        ]
      }
    }
  };

  static const Map<String, dynamic> custom = {
    "label": "Custom",
    "schema": {
      "title": "A localisation form",
      "type": "object",
      "required": ["lat", "lon"],
      "properties": {
        "lat": {"type": "number"},
        "lon": {"type": "number"}
      }
    },
    "ui": {"ui:field": "geo"},
    "formData": {"lat": 0, "lon": 0}
  };
  static const Map<String, dynamic> errors = {
    "label": "Errors",
    "schema": {
      "title": "Contextualized errors",
      "type": "object",
      "properties": {
        "firstName": {
          "type": "string",
          "title": "First name",
          "minLength": 8,
          "pattern": "\\d+"
        },
        "active": {"type": "boolean", "title": "Active"},
        "skills": {
          "type": "array",
          "items": {"type": "string", "minLength": 5}
        },
        "multipleChoicesList": {
          "type": "array",
          "title": "Pick max two items",
          "uniqueItems": true,
          "maxItems": 2,
          "items": {
            "type": "string",
            "enum": ["foo", "bar", "fuzz"]
          }
        }
      }
    },
    "ui": {"":""},
    "formData": {
      "firstName": "Chuck",
      "active": "wrong",
      "skills": ["karate", "budo", "aikido"],
      "multipleChoicesList": ["foo", "bar", "fuzz"]
    }
  };
  static const Map<String, dynamic> examples = {
    "label": "Examples",
    "schema": {
      "title": "Examples",
      "description": "A text field with example values.",
      "type": "object",
      "properties": {
        "browser": {
          "type": "string",
          "title": "Browser",
          "examples": ["Firefox", "Chrome", "Opera", "Vivaldi", "Safari"]
        }
      }
    },
    "ui": {"":""},
    "formData": {
      "firstName": "Chuck",
      "active": "wrong",
      "skills": ["karate", "budo", "aikido"],
      "multipleChoicesList": ["foo", "bar", "fuzz"]
    }
  };
  static const Map<String, dynamic> large = {
    "label": "Large",
    "schema": {
      "definitions": {
        "largeEnum": {
          "type": "string",
          "enum": [
            "option #0",
            "option #1",
            "option #2",
            "option #3",
            "option #4",
            "option #5",
            "option #6",
            "option #7",
            "option #8",
            "option #9",
            "option #10",
            "option #11",
            "option #12",
            "option #13",
            "option #14",
            "option #15",
            "option #16",
            "option #17",
            "option #18",
            "option #19",
            "option #20",
            "option #21",
            "option #22",
            "option #23",
            "option #24",
            "option #25",
            "option #26",
            "option #27",
            "option #28",
            "option #29",
            "option #30",
            "option #31",
            "option #32",
            "option #33",
            "option #34",
            "option #35",
            "option #36",
            "option #37",
            "option #38",
            "option #39",
            "option #40",
            "option #41",
            "option #42",
            "option #43",
            "option #44",
            "option #45",
            "option #46",
            "option #47",
            "option #48",
            "option #49",
            "option #50",
            "option #51",
            "option #52",
            "option #53",
            "option #54",
            "option #55",
            "option #56",
            "option #57",
            "option #58",
            "option #59",
            "option #60",
            "option #61",
            "option #62",
            "option #63",
            "option #64",
            "option #65",
            "option #66",
            "option #67",
            "option #68",
            "option #69",
            "option #70",
            "option #71",
            "option #72",
            "option #73",
            "option #74",
            "option #75",
            "option #76",
            "option #77",
            "option #78",
            "option #79",
            "option #80",
            "option #81",
            "option #82",
            "option #83",
            "option #84",
            "option #85",
            "option #86",
            "option #87",
            "option #88",
            "option #89",
            "option #90",
            "option #91",
            "option #92",
            "option #93",
            "option #94",
            "option #95",
            "option #96",
            "option #97",
            "option #98",
            "option #99"
          ]
        }
      },
      "title": "A rather large form",
      "type": "object",
      "properties": {
        "string": {"type": "string", "title": "Some string"},
        "choice1": {"\$ref": "#/definitions/largeEnum"},
        "choice2": {"\$ref": "#/definitions/largeEnum"},
        "choice3": {"\$ref": "#/definitions/largeEnum"},
        "choice4": {"\$ref": "#/definitions/largeEnum"},
        "choice5": {"\$ref": "#/definitions/largeEnum"},
        "choice6": {"\$ref": "#/definitions/largeEnum"},
        "choice7": {"\$ref": "#/definitions/largeEnum"},
        "choice8": {"\$ref": "#/definitions/largeEnum"},
        "choice9": {"\$ref": "#/definitions/largeEnum"},
        "choice10": {"\$ref": "#/definitions/largeEnum"}
      }
    },
    "ui": {
      "choice1": {"ui:placeholder": "Choose one"}
    },
    "formData": {"":""}
  };
  static const Map<String, dynamic> dateTime = {
    "label": "Date-Time",
    "schema": {
      "title": "Date and time widgets",
      "type": "object",
      "properties": {
        "native": {
          "title": "Native",
          "description":
              "May not work on some browsers, notably Firefox Desktop and IE.",
          "type": "object",
          "properties": {
            "datetime": {"type": "string", "format": "date-time"},
            "date": {"type": "string", "format": "date"}
          }
        },
        "alternative": {
          "title": "Alternative",
          "description": "These work on most platforms.",
          "type": "object",
          "properties": {
            "alt-datetime": {"type": "string", "format": "date-time"},
            "alt-date": {"type": "string", "format": "date"}
          }
        }
      }
    },
    "ui": {
      "alternative": {
        "alt-datetime": {
          "ui:widget": "alt-datetime",
          "ui:options": {
            "yearsRange": [1980, 2030]
          }
        },
        "alt-date": {
          "ui:widget": "alt-date",
          "ui:options": {
            "yearsRange": [1980, 2030]
          }
        }
      }
    },
    "formData": {"native": {"":""}, "alternative": {"":""}}
  };
  static const Map<String, dynamic> validation = {
    "label": "Validation",
    "schema": {
      "title": "Custom validation",
      "description":
          "This form defines custom validation rules checking that the two passwords match.",
      "type": "object",
      "properties": {
        "pass1": {"title": "Password", "type": "string", "minLength": 3},
        "pass2": {"title": "Repeat password", "type": "string", "minLength": 3},
        "age": {"title": "Age", "type": "number", "minimum": 18}
      }
    },
    "ui": {
      "pass1": {"ui:widget": "password"},
      "pass2": {"ui:widget": "password"}
    },
    "formData": {"":""}
  };
  static const Map<String, dynamic> files = {
    "label": "Files",
    "schema": {
      "title": "Files",
      "type": "object",
      "properties": {
        "file": {
          "type": "string",
          "format": "data-url",
          "title": "Single file"
        },
        "files": {
          "type": "array",
          "title": "Multiple files",
          "items": {"type": "string", "format": "data-url"}
        },
        "filesAccept": {
          "type": "string",
          "format": "data-url",
          "title": "Single File with Accept attribute"
        }
      }
    },
    "ui": {
      "filesAccept": {
        "ui:options": {"accept": ".pdf"}
      }
    },
    "formData": {"":""}
  };
  static const Map<String, dynamic> single = {
    "label": "Single",
    "schema": {"title": "A single-field form", "type": "string"},
    "ui": {"":""},
    "formData": "initial value"
  };
  static const Map<String, dynamic> customArray = {
    "label": "Custom Array",
    "schema": {
      "title": "Custom array of strings",
      "type": "array",
      "items": {"type": "string"}
    },
    "ui": {"":""},
    "formData": ["react", "jsonschema", "form"]
  };
  static const Map<String, dynamic> customObject = {
    "label": "Custom Object",
    "schema": {
      "title": "A registration form",
      "description":
          "This is the same as the simple form, but it is rendered as a bootstrap grid. Try shrinking the browser window to see it in action.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {"type": "string", "title": "First name"},
        "lastName": {"type": "string", "title": "Last name"},
        "age": {"type": "integer", "title": "Age"},
        "bio": {"type": "string", "title": "Bio"},
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {"":""},
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static const Map<String, dynamic> alternatives = {
    "label": "Alternatives",
    "schema": {
      "definitions": {
        "Color": {
          "title": "Color",
          "type": "string",
          "anyOf": [
            {
              "type": "string",
              "enum": ["#ff0000"],
              "title": "Red"
            },
            {
              "type": "string",
              "enum": ["#00ff00"],
              "title": "Green"
            },
            {
              "type": "string",
              "enum": ["#0000ff"],
              "title": "Blue"
            }
          ]
        },
        "Toggle": {
          "title": "Toggle",
          "type": "boolean",
          "oneOf": [
            {"title": "Enable", "const": true},
            {"title": "Disable", "const": false}
          ]
        }
      },
      "title": "Image editor",
      "type": "object",
      "required": ["currentColor", "colorMask", "blendMode"],
      "properties": {
        "currentColor": {
          "\$ref": "#/definitions/Color",
          "title": "Brush color"
        },
        "colorMask": {
          "type": "array",
          "uniqueItems": true,
          "items": {"\$ref": "#/definitions/Color"},
          "title": "Color mask"
        },
        "toggleMask": {
          "title": "Apply color mask",
          "\$ref": "#/definitions/Toggle"
        },
        "colorPalette": {
          "type": "array",
          "title": "Color palette",
          "items": {"\$ref": "#/definitions/Color"}
        },
        "blendMode": {
          "title": "Blend mode",
          "type": "string",
          "enum": ["screen", "multiply", "overlay"],
          "enumNames": ["Screen", "Multiply", "Overlay"]
        }
      }
    },
    "ui": {
      "blendMode": {
        "ui:enumDisabled": ["multiply"]
      },
      "toggleMask": {"ui:widget": "radio"}
    },
    "formData": {
      "currentColor": "#00ff00",
      "colorMask": ["#0000ff"],
      "colorPalette": ["#ff0000"],
      "blendMode": "screen"
    }
  };
  static const Map<String, dynamic> propertyDependencies = {
    "label": "Property Dependencies",
    "schema": {
      "title": "Property dependencies",
      "description": "These samples are best viewed without live validation.",
      "type": "object",
      "properties": {
        "unidirectional": {
          "title": "Unidirectional",
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"},
            "billing_address": {"type": "string"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": ["billing_address"]
          }
        },
        "bidirectional": {
          "title": "Bidirectional",
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "description":
              "Dependencies are not bidirectional, you can, of course, define the bidirectional dependencies explicitly.",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"},
            "billing_address": {"type": "string"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": ["billing_address"],
            "billing_address": ["credit_card"]
          }
        }
      }
    },
    "ui": {
      "unidirectional": {
        "credit_card": {
          "ui:help":
              "If you enter anything here then billing_address will become required."
        },
        "billing_address": {
          "ui:help":
              "It’s okay to have a billing address without a credit card number."
        }
      },
      "bidirectional": {
        "credit_card": {
          "ui:help":
              "If you enter anything here then billing_address will become required."
        },
        "billing_address": {
          "ui:help":
              "If you enter anything here then credit_card will become required."
        }
      }
    },
    "formData": {
      "unidirectional": {"name": "Tim"},
      "bidirectional": {"name": "Jill"}
    }
  };
  static const Map<String, dynamic> schemaDependencies = {
    "label": "Schema Dependencies",
    "schema": {
      "title": "Schema dependencies",
      "description": "These samples are best viewed without live validation.",
      "type": "object",
      "properties": {
        "simple": {
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "title": "Simple",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": {
              "properties": {
                "billing_address": {"type": "string"}
              },
              "required": ["billing_address"]
            }
          }
        },
        "conditional": {
          "title": "Conditional",
          "\$ref": "#/definitions/person"
        },
        "arrayOfConditionals": {
          "title": "Array of conditionals",
          "type": "array",
          "items": {"\$ref": "#/definitions/person"}
        },
        "fixedArrayOfConditionals": {
          "title": "Fixed array of conditionals",
          "type": "array",
          "items": [
            {"title": "Primary person", "\$ref": "#/definitions/person"}
          ],
          "additionalItems": {
            "title": "Additional person",
            "\$ref": "#/definitions/person"
          }
        }
      },
      "definitions": {
        "person": {
          "title": "Person",
          "type": "object",
          "properties": {
            "Do you have any pets?": {
              "type": "string",
              "enum": ["No", "Yes: One", "Yes: More than one"],
              "default": "No"
            }
          },
          "required": ["Do you have any pets?"],
          "dependencies": {
            "Do you have any pets?": {
              "oneOf": [
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["No"]
                    }
                  }
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: One"]
                    },
                    "How old is your pet?": {"type": "number"}
                  },
                  "required": ["How old is your pet?"]
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: More than one"]
                    },
                    "Do you want to get rid of any?": {"type": "boolean"}
                  },
                  "required": ["Do you want to get rid of any?"]
                }
              ]
            }
          }
        }
      }
    },
    "ui": {
      "simple": {
        "credit_card": {
          "ui:help":
              "If you enter anything here then billing_address will be dynamically added to the form."
        }
      },
      "conditional": {
        "Do you want to get rid of any?": {"ui:widget": "radio"}
      },
      "arrayOfConditionals": {
        "items": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        }
      },
      "fixedArrayOfConditionals": {
        "items": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        },
        "additionalItems": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        }
      }
    },
    "formData": {
      "simple": {"name": "Randy"},
      "conditional": {"Do you have any pets?": "No"},
      "arrayOfConditionals": [
        {"Do you have any pets?": "Yes: One", "How old is your pet?": 6},
        {
          "Do you have any pets?": "Yes: More than one",
          "Do you want to get rid of any?": false
        }
      ],
      "fixedArrayOfConditionals": [
        {"Do you have any pets?": "No"},
        {"Do you have any pets?": "Yes: One", "How old is your pet?": 6},
        {
          "Do you have any pets?": "Yes: More than one",
          "Do you want to get rid of any?": true
        }
      ]
    }
  };
  static const Map<String, dynamic> additionalProperties = {
    "label": "Additional Properties",
    "schema": {
      "title": "A customizable registration form",
      "description": "A simple form with additional properties example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "additionalProperties": {"type": "string"},
      "properties": {
        "firstName": {"type": "string", "title": "First name"},
        "lastName": {"type": "string", "title": "Last name"}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""}
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "assKickCount": "infinity"
    }
  };
  static const Map<String, dynamic> anyOf = {
    "label": "Any Of",
    "schema": {
      "type": "object",
      "properties": {
        "age": {"type": "integer", "title": "Age"},
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "anyOf": [
              {
                "properties": {
                  "foo": {"type": "string"}
                }
              },
              {
                "properties": {
                  "bar": {"type": "string"}
                }
              }
            ]
          }
        }
      },
      "anyOf": [
        {
          "title": "First method of identification",
          "properties": {
            "firstName": {
              "type": "string",
              "title": "First name",
              "default": "Chuck"
            },
            "lastName": {"type": "string", "title": "Last name"}
          }
        },
        {
          "title": "Second method of identification",
          "properties": {
            "idCode": {"type": "string", "title": "ID code"}
          }
        }
      ]
    },
    "ui": {"":""},
    "formData": {"firstName": "Chuck"}
  };
  static const Map<String, dynamic> oneOf = {
    "label": "One Of",
    "schema": {
      "type": "object",
      "oneOf": [
        {
          "properties": {
            "lorem": {"type": "string"}
          },
          "required": ["lorem"]
        },
        {
          "properties": {
            "ipsum": {"type": "string"}
          },
          "required": ["ipsum"]
        }
      ]
    },
    "ui": {"":""},
    "formData": {"":""}
  };
  static const Map<String, dynamic> allOf = {
    "label": "All Of",
    "schema": {
      "type": "object",
      "allOf": [
        {
          "properties": {
            "lorem": {
              "type": ["string", "boolean"],
              "default": true
            }
          }
        },
        {
          "properties": {
            "lorem": {"type": "boolean"},
            "ipsum": {"type": "string"}
          }
        }
      ]
    },
    "ui": {"":""},
    "formData": {"lorem": true}
  };
  static const Map<String, dynamic> ifThenElse = {
    "label": "If Then Else",
    "schema": {
      "type": "object",
      "properties": {
        "animal": {
          "enum": ["Cat", "Fish"]
        }
      },
      "allOf": [
        {
          "if": {
            "properties": {
              "animal": {"const": "Cat"}
            }
          },
          "then": {
            "properties": {
              "food": {
                "type": "string",
                "enum": ["meat", "grass", "fish"]
              }
            },
            "required": ["food"]
          }
        },
        {
          "if": {
            "properties": {
              "animal": {"const": "Fish"}
            }
          },
          "then": {
            "properties": {
              "food": {
                "type": "string",
                "enum": ["insect", "worms"]
              },
              "water": {
                "type": "string",
                "enum": ["lake", "sea"]
              }
            },
            "required": ["food", "water"]
          }
        },
        {
          "required": ["animal"]
        }
      ]
    },
    "ui": {"":""},
    "formData": {"":""}
  };

  static const Map<String, dynamic> nullFields = {
    "label": "Null Fields",
    "schema": {
      "title": "Null field example",
      "description": "A short form with a null field",
      "type": "object",
      "required": ["firstName"],
      "properties": {
        "helpText": {
          "title": "A null field",
          "description":
              "Null fields like this are great for adding extra information",
          "type": "null"
        },
        "firstName": {
          "type": "string",
          "title": "A regular string field",
          "default": "Chuck"
        }
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""}
    },
    "formData": {"firstName": "Chuck"}
  };
  static const Map<String, dynamic> nullable = {
    "label": "Nuallable",
    "schema": {
      "title": "A registration form (nullable)",
      "description": "A simple form example using nullable types",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {
          "type": "string",
          "title": "First name",
          "default": "Chuck"
        },
        "lastName": {"type": "string", "title": "Last name"},
        "age": {
          "type": ["integer", "null"],
          "title": "Age"
        },
        "bio": {
          "type": ["string", "null"],
          "title": "Bio"
        },
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)",
        "ui:emptyValue": null
      },
      "bio": {
        "ui:widget": "textarea",
        "ui:placeholder":
            "Leaving this field empty will cause formData property to be `null`",
        "ui:emptyValue": null
      },
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": null,
      "password": "noneed"
    }
  };
  static const Map<String, dynamic> errorSchema = {
    "label": "Error Schema",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {
          "type": "string",
          "title": "First name",
          "default": "Chuck"
        },
        "lastName": {"type": "string", "title": "Last name"},
        "age": {"type": "integer", "title": "Age"},
        "bio": {"type": "string", "title": "Bio"},
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)"
      },
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static const Map<String, dynamic> defaults = {
    "label": "Defaults",
    "schema": {
      "title": "Schema default properties",
      "type": "object",
      "properties": {
        "valuesInFormData": {
          "title": "Values in form data",
          "\$ref": "#/definitions/defaultsExample"
        },
        "noValuesInFormData": {
          "title": "No values in form data",
          "\$ref": "#/definitions/defaultsExample"
        }
      },
      "definitions": {
        "defaultsExample": {
          "type": "object",
          "properties": {
            "scalar": {
              "title": "Scalar",
              "type": "string",
              "default": "scalar default"
            },
            "array": {
              "title": "Array",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "nested": {
                    "title": "Nested array",
                    "type": "string",
                    "default": "nested array default"
                  }
                }
              }
            },
            "object": {
              "title": "Object",
              "type": "object",
              "properties": {
                "nested": {
                  "title": "Nested object",
                  "type": "string",
                  "default": "nested object default"
                }
              }
            }
          }
        }
      }
    },
    "ui": {"":""},
    "formData": {
      "valuesInFormData": {
        "scalar": "value",
        "array": [
          {"nested": "nested array value"}
        ],
        "object": {"nested": "nested object value"}
      },
      "noValuesInFormData": {
        "scalar": "scalar default",
        "array": [
          {"nested": "nested array default"},
          {"nested": "nested array default"}
        ],
        "object": {"nested": "nested object default"}
      }
    }
  };

  static List<Map<String, dynamic>> schemas = [
    test,
    simple,
    nested,
    arrays,
    numbers,
    widgets,
    ordering,
    references,
    custom,
    errors,
    examples,
    large,
    dateTime,
    validation,
    files,
    single,
    customArray,
    customObject,
    alternatives,
    propertyDependencies,
    schemaDependencies,
    additionalProperties,
    anyOf,
    oneOf,
    allOf,
    ifThenElse,
    nullFields,
    nullable,
    errorSchema,
    defaults
  ];
}
