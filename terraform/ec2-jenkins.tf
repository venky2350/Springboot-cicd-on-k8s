provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0c1a7f89451184c8b"  # Ubuntu 24.04 (example)
  instance_type = "t2.medium"
  key_name      = "your-key"

  tags = {
    Name = "Jenkins-Server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openjdk-17-jdk git maven docker.io",
      "sudo usermod -aG docker ubuntu",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo apt-add-repository 'deb https://pkg.jenkins.io/debian-stable binary/'",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}
