#vpc variables
variable "source_ranges" {
  type = "list"
  description = "Source ranges for ssh firewall rule"
  default = ["0.0.0.0/0"]
}