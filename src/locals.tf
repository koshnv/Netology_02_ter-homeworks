locals {
  vm_web_name = "${var.vm_web_name}"
  vm_db_name  = "${var.vm_db_name}"
  develop_db  = "${var.vpc_name}-${var.environment}" # ����� ������������
  full_metadata  = merge(var.metadata, { ssh-keys = var.ssh-keys_pub }) #��� ������������ ������ metadata
}