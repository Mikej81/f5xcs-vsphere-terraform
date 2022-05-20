output "completion_time" {
  description = "Outputs the time of script completion.  Just for auditing purposes."
  value       = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}
