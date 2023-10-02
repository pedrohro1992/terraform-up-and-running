output "for_directive_index_if" {
  value = <<EOF
  %{~for i, name in var.names~}
    ${name}%{if i < length(var.names) - 1},%{endif}
  %{~endfor~}
    EOF
}

output "for_directive_index_if_else_strip" {
  value = <<EOF
  %{~for i, name in var.names~}
  ${name}%{if i < length(var.names) - 1},%{else}.%{endif}
  %{~endfor~}
  EOF
}
