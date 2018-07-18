{
  "type": "object",
  "properties": {
    "secondaryEmails": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "validated": {
            "type": "boolean"
          },
          "email": {
            "type": "string"
          },
          "nextResendDate": {
            "type": "string"
          }
        }
      }
    },
    "validated": {
      "type": "boolean"
    },
    "role": {
      "type": "string"
    },
    "primaryEmail": {
      "type": "string"
    },
    "name": {
      "type": "string"
    },
    "gender": {
      "type": "string"
    },
    "country": {
      "type": "string"
    },
    "city": {
      "type": "string"
    },
    "birthDate": {
      "type": "string"
    },
    "actionTokens": {
      "type": "object",
      "properties": {
        "maximumTokens": {
          "type": "integer"
        },
        "usedTokens": {
          "type": "integer"
        },
        "_id": {
          "type": "string"
        }
      }
    },
    "_id": {
      "type": "string"
    }
  }
}