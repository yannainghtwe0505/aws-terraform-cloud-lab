# Terraform Loops

## count

Creates multiple instances using numeric indexes.

Example:

```hcl
count = 3
```

Resources:

```text
resource[0]
resource[1]
resource[2]
```

## for_each

Creates resources using stable keys.

Example:

```hcl
for_each = toset(["web", "api"])
```

Resources:

```text
resource["web"]
resource["api"]
```

## for expression

Transforms a collection.

Example:

```hcl
[
  for env in local.environments : upper(env)
]
```

## Filtering

A for expression can use `if`.

Example:

```hcl
[
  for port in local.ports : port
  if port > 100
]
```

## Rule of thumb

```text
count = N copies
for_each = named items
for = transform/filter values
```