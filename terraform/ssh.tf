data "local_file" "ssh_key_rocky_pub" {
  filename = var.pub_key_path
}
