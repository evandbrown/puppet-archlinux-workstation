# == Class: archlinux_workstation::userapps::virtualbox
#
# Install and configure VirtualBox and Vagrant.
#
# === Actions:
#   - Install virtualbox, virtualbox-host-modules, virtualbox-guest-iso, virtualbox-ext-oracle
#   - Setup virtualbox modules-load.d file for required kernel modules
#   - Install vagrant
#
class archlinux_workstation::userapps::virtualbox {

  $packages = ['virtualbox',
              'virtualbox-host-modules',
              'virtualbox-host-dkms',
              'virtualbox-guest-iso',
              'vagrant',
              ]

  package {$packages:
    ensure => present,
  }

  file {'/etc/modules-load.d/virtualbox.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "# managed by puppet module ${module_name}\nvboxdrv\nvboxnetadp\nvboxnetflt\nvboxpci",
  }

}
