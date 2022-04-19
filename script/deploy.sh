#!/bin/bash

#####################################################################
#                                                                   # 
#     Description : déployement de mon environnement Docker         #
#                                                                   #
#                                                                   #
#                                                                   #
#                                                                   #
#####################################################################

#if option ---Create 
 if [ "$1" == "--create" ];then
      echo ""
      echo "You have chosen the create option"
      echo ""

    # Definition of the number of machines
      nb_machine=1
      [ "$2" != "" ] && nb_machine=$2

    # Setting Min and Max  
      min=1
      max=0
    # Recovery of Max ID  
       idmax=`docker ps -a --format '{{ .Names}}' | awk -F "-" -v user="$USER" '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`
    # Redifinition of Max ID
      min=$(($idmax + 1))
      max=$(($idmax + $nb_machine)) 

    # Creating container
      echo "Beginning to create the container(s).."
   for i in $(seq $min $max);do
    #    docker run -tid --name $USER-alpine-$i alpine:latest
        docker run -tid --cap-add NET_ADMIN --cap-add SYS_ADMIN --publish-all=true -v /srv/data:/srv/html -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name $USER-debian-$i -h $USER-debian-$i debian-systemd
	docker exec -ti $USER-debian-$i /bin/sh -c "useradd -m -p sa3tHJ3/KuYvI $USER"
	docker exec -ti $USER-debian-$i /bin/sh -c "mkdir  ${HOME}/.ssh && chmod 700 ${HOME}/.ssh && chown $USER:$USER $HOME/.ssh"
        docker cp $HOME/.ssh/id_rsa.pub $USER-debian-$i:$HOME/.ssh/authorized_keys
        docker exec -ti $USER-debian-$i /bin/sh -c "chmod 600 ${HOME}/.ssh/authorized_keys && chown $USER:$USER $HOME/.ssh/authorized_keys"
	docker exec -ti $USER-debian-$i /bin/sh -c "echo '$USER   ALL=(ALL) NOPASSWD: ALL'>>/etc/sudoers"
        docker exec -ti $USER-debian-$i /bin/sh -c "service ssh start"
      echo "Container $USER-debian-$i creates"
   done

  
#    # Setting Min and Max
#    min=1
#    max=0
#    # Recovery of Max ID
#      idmax=' docker ps -a --format '{{ .Names}}' | awk -F "-" -v user="$USER" '$0 ~ user"-alpine" {print $3}' | sort -r | head -1'  
#    # Redefinition of Max ID
#    min=$(($idmax + 1))
#    max=$(($idmax + $nb_machine))
#
#    # Createing container
#       echo "Beginning to create the container(s).."
#    for i in $(seq $min $max);do
#        docker run -tid --name $USER-alpine-$i alpine:latest
#       echo "Container $USER-alpine-$i Creates"
#    done


    ## Creating containers
    #  echo "Beginning to create the container(s)..."
    #for i in $(seq 1 $nb_machine);do
    #   docker run -tid --name $USER-alpine-$i alpine:latest
    #  echo "Container $USER-alpine-$i creates"
    #done
      #echo "You have created ${nb_machine} machines"


#if option ---Drop
 elif [ "$1" == "--drop" ];then
        echo ""
        echo "You have chosen the drop option"
        echo ""
        echo "Delete container(s)."
         docker rm -f $(docker ps -a | grep $USER-debian | awk '{print $1}')
        echo "End of deletion."
    
#if option ---Infos
elif [ "$1" == "--infos" ];then
        echo ""
        echo "You have chosen the infos option"
        echo ""
        echo "Information of containers"
     for container in $(docker ps -a | grep $USER-debian | awk '{print $1}');do
         docker inspect -f' => {{.Name}} - {{.NetworkSettings.IPAddress }} - {{.State.Status}}' $container
     done
        echo ""

#if option ---Start
elif [ "$1" == "--start" ];then
        echo ""
        echo "You have chosen the start option"
        echo ""
         docker start $(docker ps -a | grep $USER-debian | awk '{print $1}')
        echo ""

#if option ---Ansible
elif [ "$1" == "--ansible" ];then
        echo ""
        echo "You have chosen the ansible option"
        echo ""

#if no option, display help 
 else
   
        echo 
         "
          Choose an option  
         --create :  Craete Containers

         --drop :    Drop containers

         --infos :   Infos containers caracteristic (IP, Name, User ..)

         --start :   Starting containers

         --ansible : Deploying ansible
        "
fi
