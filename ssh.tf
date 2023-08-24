resource "tls_private_key" "kpa-keygen-dg" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kpa-key-dg" {
  key_name   = "kpa-key-dg"
  public_key = tls_private_key.kpa-keygen-dg.public_key_openssh
}

resource "local_file" "ssh_private_key" { # NOT USING A 'KEY VAULT' SO NEED TO SPECIFY A LOCAL FILE

  content = tls_private_key.kpa-keygen-dg.private_key_pem

  filename = pathexpand("~/.ssh/kpa-key-dg.pem")

  file_permission = "0700" # Set the file permissions

}