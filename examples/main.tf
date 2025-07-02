# Define a local file resource
resource "local_file" "hello_opentofu" {
    content = "Hello from OpenTofu! This file was created at ${timestamp()}"
    filename = "hello_opentofu.txt"
}

# Output the path to the created file
output "file_path" {
    value = local_file.hello_opentofu.filename
    description = "The path to the generated hello file."
}