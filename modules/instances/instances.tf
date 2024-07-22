resource "google_compute_instance" "kubmaster" {
  name = "${var.name}-master"
  machine_type = var.machinetype1
    # metadata_startup_script = file(var.Pathtoshfile)
  tags = [ var.fierwall_tags["fierwall-http-https"], var.fierwall_tags["fierwall-ssh"], var.fierwall_tags["fierwall-kuber"]  ]
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
  network_interface {
    subnetwork = var.subnet1id1
    access_config {
      // Ephemeral public IP
      }
    
  }
  provisioner "remote-exec" {
    inline = [
      "echo SSH to master successful"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("/home/rootuser/k8s+ter+ans/rsaa")
      host        = google_compute_instance.kubmaster.network_interface.0.access_config.0.nat_ip
    }
  }
 
}

resource "google_compute_instance" "kubworker" {
  name = "${var.name}-worker"
  machine_type = var.machinetype2
  tags = [ var.fierwall_tags["fierwall-http-https"], var.fierwall_tags["fierwall-ssh"], var.fierwall_tags["fierwall-kuber"]  ]
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
  network_interface {
    subnetwork = var.subnet1id1
    access_config {
      // Ephemeral public IP
      }
  
  }
  provisioner "remote-exec" {
    inline = [
      "echo SSH to worker successful"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("/home/rootuser/k8s+ter+ans/rsaa")
      host        = google_compute_instance.kubworker.network_interface.0.access_config.0.nat_ip
    }
  }
}
resource "local_file" "ansible_inventory" {
  content = <<EOF
[kubmaster]
master ansible_host=${google_compute_instance.kubmaster.network_interface.0.access_config.0.nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=/home/rootuser/k8s+ter+ans/rsaa
[kubworker]
worker ansible_host=${google_compute_instance.kubworker.network_interface.0.access_config.0.nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=/home/rootuser/k8s+ter+ans/rsaa
EOF

  filename = "/home/rootuser/k8s+ter+ans/ansible/inventories/inventory"
}

resource "null_resource" "test_ssh_master" {
  depends_on = [google_compute_instance.kubmaster]

  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -i /home/rootuser/k8s+ter+ans/rsaa ${var.ssh_user}@${google_compute_instance.kubmaster.network_interface.0.access_config.0.nat_ip} 'echo SSH to master successful'"
  }
}

resource "null_resource" "test_ssh_worker" {
  depends_on = [google_compute_instance.kubworker]

  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -i /home/rootuser/k8s+ter+ans/rsaa ${var.ssh_user}@${google_compute_instance.kubworker.network_interface.0.access_config.0.nat_ip} 'echo SSH to worker successful'"
  }
}

resource "null_resource" "run_ansible_playbook" {
  depends_on = [google_compute_instance.kubmaster, google_compute_instance.kubworker, local_file.ansible_inventory]

  provisioner "local-exec" {
    command = "ansible-playbook -i /home/rootuser/k8s+ter+ans/ansible/inventories/inventory /home/rootuser/k8s+ter+ans/ansible/playbook.yaml --ssh-common-args='-o StrictHostKeyChecking=no'"
  }
}