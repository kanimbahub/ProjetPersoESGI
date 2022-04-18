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
       idmax=`docker ps -a --format '{{ .Names}}' | awk -F "-" -v user="$USER" '$0 ~ user"-alpine" {print $3}' | sort -r |head -1`
    # Redifinition of Max ID
      min=$(($idmax + 1))
      max=$(($idmax + $nb_machine)) 

    # Creating container
      echo "Beginning to create the container(s).."
   for i in $(seq $min $max);do
        docker run -tid --name $USER-alpine-$i alpine:latest
      echo "Container $USER-alpine-$i creates"
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
       docker rm -f $(docker ps -a | grep $USER-alpine | awk '{print $1}')
      echo "End of deletion."
    
#if option ---Infos
elif [ "$1" == "--infos" ];then
      echo ""
      echo "You have chosen the infos option"
      echo ""

#if option ---Start
elif [ "$1" == "--start" ];then
      echo ""
      echo "You have chosen the start option"
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
