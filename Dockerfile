- hosts: all
  become: true

  tasks:
    - name: ensure repository key is installed
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: ensure docker registry is available
      apt_repository: repo='deb https://download.docker.com/linux/ubuntu bionic stable' state=present

    - name: ensure docker and dependencies are installed
      apt: name=docker-ce update_cache=yes

    # Uncomment the following to enable insecure registries with Docker
    #- name: ensure docker can use insecure registries in 10.11.0.0/16
    #  lineinfile: "dest=/etc/default/docker regexp=^DOCKER_OPTS line=DOCKER_OPTS='--insecure-registry 10.11.0.0/16'"

    - service: name=docker state=restarted
