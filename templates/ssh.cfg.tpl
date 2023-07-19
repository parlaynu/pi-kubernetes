# the controller
Host ${controller.name}
  Hostname ${controller.ip_address}
  User ${controller.username}
  IdentityFile ${controller.ssh_keyfile}
  IdentitiesOnly yes


# additional controllers
%{ for key, value in secondary ~}
Host ${key}
  Hostname ${value.ip_address}
  User ${value.username}
  IdentityFile ${value.ssh_keyfile}
  IdentitiesOnly yes
%{ endfor ~}


# the workers
%{ for key, value in workers ~}
Host ${key}
  Hostname ${value.ip_address}
  User ${value.username}
  IdentityFile ${value.ssh_keyfile}
  IdentitiesOnly yes
%{ endfor ~}


