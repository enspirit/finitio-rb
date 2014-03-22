### system

system:
  - [ type_def* type ]

type_def:
  - [ type_name type ]

### types

type:
  - any_type
  - builtin_type
  - sub_type
  - union_type
  - set_type
  - seq_type
  - tuple_type
  - relation_type
  - ad_type
  - type_ref

any_type:
  - [ ]

builtin_type:
  - [ ruby_module_name ]

sub_type:
  - [ type, constraint+ ]

union_type:
  - [ type+ ]

set_type:
  - [ type ]

seq_type:
  - [ type ]

tuple_type:
  - [ heading ]

relation_type:
  - [ heading ]

ad_type:
  - [ ruby_module_name_or_nil, contract+ ]

type_ref:
  - [ type_name ]

### heading

heading:
  [ attribute+ ]

attribute:
  [ attribute_name, type, Boolean ]

### constraints

constraint:
  - [ constraint_name, fn ]

### contracts

contract:
  - [ contract_name, type, pair? ]

pair:
  - external_pair
  - inline_pair

inline_pair:
  - [ fn, fn ]

external_pair:
  - [ ruby_module_name ]

### functions/expressions

fn:
  - [ parameters, source ]

parameters:
  - [ parameter_name+ ]

source:
  - [ String ]

### names

attribute_name:
  !ruby/regexp /^[a-z][a-zA-Z0-9_]*$/

ruby_module_name:
  !ruby/regexp /^[a-zA-Z0-9:]+$/

ruby_module_name_or_nil:
  - ruby_module_name
  - ~

contract_name:
  !ruby/regexp /^[a-z][a-z0-9]*$/

constraint_name:
  !ruby/regexp /^[a-z][a-zA-Z_]*$/

parameter_name:
  !ruby/regexp /^[a-z]+$/

type_name:
  !ruby/regexp /^[A-Z][a-zA-Z]+$/
