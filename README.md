# terraform + aws + ansible

Make sure that you have ansible, awscli, and terraform installed. I am using Ubuntu 20.04 via WSL. 

Using the main.tf, run ``terraform init`` to kick it off.
```
# bl @ bl-lt in ~/dev/terraform/ [9:42:16]
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v4.14.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Looks like it is good to go. Go ahead and run ``terraform apply``
```
# bl @ bl-lt in ~/dev/terraform/ [9:42:22]
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_lightsail_instance.bl_lightsail will be created
  + resource "aws_lightsail_instance" "bl_lightsail" {
      + arn                = (known after apply)
      + availability_zone  = "us-west-2a"
      + blueprint_id       = "debian_10"
      + bundle_id          = "medium_2_0"
      + cpu_count          = (known after apply)
      + created_at         = (known after apply)
      + id                 = (known after apply)
      + ipv6_address       = (known after apply)
      + ipv6_addresses     = (known after apply)
      + is_static_ip       = (known after apply)
      + key_pair_name      = "id_ed25519"
      + name               = "bl-us"
      + private_ip_address = (known after apply)
      + public_ip_address  = (known after apply)
      + ram_size           = (known after apply)
      + tags_all           = (known after apply)
      + username           = (known after apply)
    }

  # aws_lightsail_instance_public_ports.bl_lightsail will be created
  + resource "aws_lightsail_instance_public_ports" "bl_lightsail" {
      + id            = (known after apply)
      + instance_name = "bl-us"

      + port_info {
          + cidrs     = (known after apply)
          + from_port = 22
          + protocol  = "tcp"
          + to_port   = 22
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 443
          + protocol  = "tcp"
          + to_port   = 443
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 51820
          + protocol  = "udp"
          + to_port   = 51820
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 5201
          + protocol  = "tcp"
          + to_port   = 5201
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 5201
          + protocol  = "udp"
          + to_port   = 5201
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 53
          + protocol  = "tcp"
          + to_port   = 53
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 53
          + protocol  = "udp"
          + to_port   = 53
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 80
          + protocol  = "tcp"
          + to_port   = 80
        }
      + port_info {
          + cidrs     = (known after apply)
          + from_port = 81
          + protocol  = "tcp"
          + to_port   = 81
        }
    }

  # aws_lightsail_static_ip.bl_lightsail will be created
  + resource "aws_lightsail_static_ip" "bl_lightsail" {
      + arn          = (known after apply)
      + id           = (known after apply)
      + ip_address   = (known after apply)
      + name         = "us-west-2"
      + support_code = (known after apply)
    }

  # aws_lightsail_static_ip_attachment.tbl_lightsail will be created
  + resource "aws_lightsail_static_ip_attachment" "tbl_lightsail" {
      + id             = (known after apply)
      + instance_name  = (known after apply)
      + ip_address     = (known after apply)
      + static_ip_name = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_lightsail_static_ip.bl_lightsail: Creating...
aws_lightsail_instance.bl_lightsail: Creating...
aws_lightsail_static_ip.bl_lightsail: Creation complete after 2s [id=us-west-2]
aws_lightsail_instance.bl_lightsail: Still creating... [10s elapsed]
aws_lightsail_instance.bl_lightsail: Still creating... [20s elapsed]
aws_lightsail_instance.bl_lightsail: Still creating... [30s elapsed]
aws_lightsail_instance.bl_lightsail: Still creating... [40s elapsed]
aws_lightsail_instance.bl_lightsail: Still creating... [50s elapsed]
aws_lightsail_instance.bl_lightsail: Creation complete after 51s [id=bl-us]
aws_lightsail_static_ip_attachment.tbl_lightsail: Creating...
aws_lightsail_instance_public_ports.bl_lightsail: Creating...
aws_lightsail_static_ip_attachment.tbl_lightsail: Creation complete after 2s [id=us-west-2]
aws_lightsail_instance_public_ports.bl_lightsail: Creation complete after 3s [id=bl-us-3589024411]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```

Run ``terraform show`` to validate all is good:

```
# bl @ bl-lt in ~/dev/terraform [9:43:26]
$ terraform show
# aws_lightsail_instance.bl_lightsail:
resource "aws_lightsail_instance" "bl_lightsail" {
    arn                = "arn:aws:lightsail:us-west-2:arninfo"
    availability_zone  = "us-west-2a"
    blueprint_id       = "debian_10"
    bundle_id          = "medium_2_0"
    cpu_count          = 2
    created_at         = "2022-05-14T00:42:37Z"
    id                 = "bl-us"
    ipv6_address       = "ipv6"
    ipv6_addresses     = "ipv6",
    is_static_ip       = false
    key_pair_name      = "id_ed25519"
    name               = "bl-us"
    private_ip_address = "privipv4"
    public_ip_address  = "pubipv4"
    ram_size           = 4
    tags_all           = {}
    username           = "admin"
}
```


Next is the provisioning via Ansible

Ensure your ``$HOME/.ssh/config`` and ``/etc/ansible/hosts`` are configured. 

Examples:
cat /etc/ansible/hosts
```
... 
[lightsail]
aws-us
```
cat $HOME/.ssh/config
```
... 
host aws-us
        hostname blurer.net
        user admin
        identityfile /home/bl/.ssh/id_ed25519
```

 You can monitor the progress via ansible or ssh to the host and run ``sudo tail -f /var/log/apt/term.log``

``ansible_base.yml``
This ansible file does the following:
- Updates the system
- Installs base tools
- Installs docker
- Starts docker service at boot
- Installs docker compose
- Adds new user (bl)
- Pulls ssh keys for user

``ansible_prod.yml``
- Changes ssh user to bl
- Creates a /home/bl/docker/ directory
- Starts PiHole docker container
- Starts NginxProxyManager docker container
- Starts Portainer docker container
- Installs pivpn wireguard
- Creates bl-iphone, bl-ipad, bl-lt wireguard profiles

