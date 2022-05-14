# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "bl_lightsail" {
  name              = "bl-us"
  availability_zone = "us-west-2a"
  blueprint_id      = "debian_10"
  bundle_id         = "small_2_0"
  key_pair_name     = "id_ed25519"
}

resource "aws_lightsail_static_ip_attachment" "bl_lightsail" {
  static_ip_name = aws_lightsail_static_ip.bl_lightsail.id
  instance_name  = aws_lightsail_instance.bl_lightsail.id
}

resource "aws_lightsail_static_ip" "bl_lightsail" {
  name = "us-west-2"
}

resource "aws_lightsail_instance_public_ports" "bl_lightsail" {
  instance_name = aws_lightsail_instance.bl_lightsail.name
  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }
  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
  port_info {
    protocol  = "udp"
    from_port = 51820
    to_port   = 51820
  }
  port_info {
    protocol  = "tcp"
    from_port = 5201
    to_port   = 5201
  }
  port_info {
    protocol  = "udp"
    from_port = 5201
    to_port   = 5201
  }
  port_info {
    protocol  = "tcp"
    from_port = 81
    to_port   = 81
  }
  port_info {
    protocol  = "udp"
    from_port = 53
    to_port   = 53
  }
    port_info {
    protocol  = "tcp"
    from_port = 53
    to_port   = 53
  }
}