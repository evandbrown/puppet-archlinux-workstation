# == Class: archlinux_workstation::i3
#
# Perform a full installation of [i3](https://wiki.archlinux.org/index.php/i3) via the "i3" package group.
#
# === Actions:
#   - install "i3" package group
#
class archlinux_workstation::i3 (
  $username,
  $userhome,
)
{

  package {'i3':
    ensure => present,
  }

  package {'dmenu':
    ensure => present,
  } 

  package {'feh':
    ensure => present,
  }
  
  archlinux_workstation::aur { 'rofi':
    ensure => present,
  }
  
  file {"${userhome}/.xinitrc":
    ensure => present,
    owner  => "${username}", 
    group  => "${username}",
    mode   => '0755',
    source => 'puppet:///modules/archlinux_workstation/xinitrc',
  } 
  
  
  if $::virtual == 'virtualbox' {
    exec {'exec-vbox-additions':
      user      => "${username}", 
      command   => "sed -i '2i/usr/bin/VBoxClient-all' ${userhome}/.xinitrc",
      path	=> "/usr/bin",
      require	=> File["${userhome}/.xinitrc"],
    }
  }

  


}
