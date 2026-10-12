variable "application" {
  description = "Application configuration"

  type = object({
    name          = string
    port          = number
    instance_type = string
    tags          = optional(map(string), {})
  })

  validation {
    condition = (
      var.application.port >= 1 &&
      var.application.port <= 65535
    )

    error_message = "Application port must be between 1 and 65535."
  }

  validation {
    condition     = trimspace(var.application.name) != ""
    error_message = "Application name must not be empty."
  }
}
