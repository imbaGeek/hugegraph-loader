// Define schema
schema.propertyKey("name").asText().ifNotExist().create();
schema.propertyKey("age").asInt().ifNotExist().create();
schema.propertyKey("set").asText().valueSet().ifNotExist().create();

schema.vertexLabel("person").properties("name", "age", "set").primaryKeys("name").nullableKeys("age", "set").ifNotExist().create();
