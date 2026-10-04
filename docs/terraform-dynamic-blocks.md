# Terraform Dynamic Blocks

## for_each

Creates multiple resource instances.

## dynamic

Generates repeated nested blocks inside one resource.

## Object

A structured value with named attributes.

## for expression

Transforms or filters collections.

## Common pattern

```text
list(object)
    ↓
for expression
    ↓
map
    ↓
for_each
```

## Important

Dynamic blocks should be used when nested blocks are driven by variable configuration.

Do not use dynamic blocks unnecessarily when a few explicit blocks are clearer.