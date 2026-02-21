## Data Models 
- Entity-Relationship (1990s)
- Relational (1970s) (1NF)
- Network (1965)
- Hierarchical (1965)
- Object-Oriented
- noSQL
- Semistructured (XML) (1990s)

### Hierarchical
- the first data model
- represent an extension of a store / processing system files
- Organize data in tree structure

### Network 
- It is an extension of the hierarchical data model
- organize data in graph structure

### Object-Oriented Model
- Introduce new concepts (class, attribute, method) and relationships between them (e.g. association, aggregation, interface)
- popular for analyze, projection and soft development
- in db it is just "scientific" due to its efficiency

### Relational model 
- in 1970s Ted Codd invents this model and the concept of abstract data
- Relation => the main concept used to describe data
- The schema for a relation has:
  - name for the relation
  - for each field (column) : name and type

### Entity-Relationship Model
- abstract, semantic, high-level model
- closer to the manner in which data is stored than to the user's perspective on the data
- helps in a good initial description of the data
- the design is presented in terms of the DBMSs (Database Management Systems) model 
- main concepts used: entities, attributes, relationships
- **Entity** - an object from the real world, a piece of data described by properties (attributes)
- **Entity set** - the entity with the schema (entity name and list of attributes)
- **Attribute** - has name, domain for values (type), conditions to check correctness
- **Key** - a restriction defined on an entity set; set of attributes with distinct values in the entity set's instances
- **Relationship** - describe a relation between 2 or more entities
- **Relationship schema** - include all relationships with the same structure (name, entity sets used in the relation, descriptive attributes)
- **Schema of the model** - contains the entity sets and the relationship sets
- binary relationships:
  - 1:1 group - GroupLeader
  - 1:n - Group - Student
  - m:n - Students - Courses
