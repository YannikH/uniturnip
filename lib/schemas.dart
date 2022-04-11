class Schemas {
  static const Map<String, dynamic> demoNested = {
    "type":"object",
    "properties":{
      "newInput1":{
        "enum":[
          "1",
          "2",
          "3"
        ],
        "enumNames": [
          'a',
          'b',
          'c'
        ],
        "title":"New Input 1",
        "type":"string"
      },
      "newInput3":{
        "title":"New Input 3",
        "type":"string"
      },
      "newInput4":{
        "items":{
          "type":"string"
        },
        "title":"New Input 4",
        "type":"array"
      },
      "newInput5":{
        "title":"New Input 5",
        "type":"string"
      },
      "newInput6":{
        "title":"New Input 6",
        "type":"string"
      },
      "newInput7":{
        "title":"New Input 7",
        "type":"object",
        "properties":{
          "newInput1":{
            "title":"New Input 1",
            "type":"boolean"
          },
          "newInput2":{
            "title":"New Input 2",
            "type":"string"
          }
        },
        "dependencies":{

        },
        "required":[

        ]
      },
      "newInput8":{
        "title": "A child and father were visiting an elderly neighbor. They were raking the neighbors leaves, organizing the neighbors garage, putting the trash out, and performing other small jobs around the neighbors house. The child had not really seen the elderly neighbor up close, but on this day the child was going to meet the neighbor up close for the first time. When the child met the neighbor up close he asked the neighbor how old he was, and the father was flabbergasted by his childs question and attempted to apologize to the neighbor, but the neighbor laughed and said that was ok, the child is curious. The elderly neighbor told the child he was 92 years old. The child had a look of unbelief and asked the neighbor, 'Did you start at the number one?'",
        "type": "object",
        /*"properties": {
          "text": {
            "enum": [
              "child",
              "and",
              "father",
              "were",
              "visiting",
              "elderly",
              "neighbor"
            ],
            "title": "",
            "type": "string"
          }
        },
        "dependencies": {
          "text": {
            "oneOf": [
              {
                "properties": {
                  "text": {
                    "enum": [
                      "child"
                    ]
                  },
                  "newInput1": {
                    "title": "child",
                    "type": "boolean",
                    "description": "ребенок"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "and"
                    ]
                  },
                  "newInput2": {
                    "type": "boolean",
                    "description": "и",
                    "title": "and"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "father"
                    ]
                  },
                  "newInput3": {
                    "title": "father",
                    "type": "boolean",
                    "description": "папа"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "were"
                    ]
                  },
                  "newInput4": {
                    "title": "were",
                    "type": "boolean",
                    "description": "были"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "visiting"
                    ]
                  },
                  "newInput5": {
                    "title": "visiting",
                    "type": "boolean",
                    "description": "посещать"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "elderly"
                    ]
                  },
                  "newInput6": {
                    "title": "elderly",
                    "type": "boolean",
                    "description": "пожилой"
                  }
                },
                "required": []
              },
              {
                "properties": {
                  "text": {
                    "enum": [
                      "neighbor"
                    ]
                  },
                  "newInput7": {
                    "title": "neighbor",
                    "type": "boolean",
                    "description": "сосед"
                  }
                },
                "required": []
              }
            ]
          }
        },*/
        "required": []
      }
    },
    "dependencies":{
      "newInput1":{
        "oneOf":[
          {
            "properties":{
              "newInput1":{
                "enum":[
                  "2"
                ]
              },
              "newInput2":{
                "title":"New Input 2",
                "type":"string"
              }
            },
            "required":[

            ]
          }
        ]
      }
    },
    "required":[

    ]
  };
  static const Map<String, dynamic> demoUi = {
    "newInput1":{
      "ui:widget":"radio"
    },
    "newInput2":{
      "ui:widget":"textarea"
    },
    "newInput4":{
      "items":{
        "ui:widget":"password"
      }
    },
    "newInput5":{
      "ui:widget":"password"
    },
    "newInput7":{
      "newInput2":{
        "ui:widget":"textarea"
      },
      "ui:order":[
        "newInput1",
        "newInput2"
      ]
    },
    "newInput8":{
      "ui:widget":"reader",
      "wordsWithTranslation":{
        "child":"ребенок",
        "and":"и",
        "his":"его",
        "father":"отец",
        "were":"были",
        "visiting":"посещение",
        "an":"артикль",
        "elderly":"пожилой",
        "neighbor":"сосед"
      },
      "child":{
        "type":"boolean",
        "title":"child",
        "description":"ребенок"
      },
      "and":{
        "type":"boolean",
        "title":"and",
        "description":"и"
      },
      "father":{
        "type":"boolean",
        "title":"father",
        "description":"отец"
      },
      "were":{
        "type":"boolean",
        "title":"were",
        "description":"были"
      },
      "visiting":{
        "type":"boolean",
        "title":"visiting",
        "description":"посещать"
      },
      "elderly":{
        "type":"boolean",
        "title":"elderly",
        "description":"пожилой"
      },
      "neighbor":{
        "type":"boolean",
        "title":"neighbor",
        "description":"сосед"
      }
    },
    "ui:order":[
      "newInput1",
      "newInput2",
      "newInput3",
      "newInput4",
      "newInput5",
      "newInput6",
      "newInput7",
      "newInput8"
    ]
  };
}
