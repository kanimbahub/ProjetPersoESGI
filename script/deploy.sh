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

#if option ---Drop
 elif [ "$1" == "--drop" ];then
    echo ""
    echo "You have chosen the drop option"
    echo ""
    
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
   
    echo -e
    "
        Choose an option 
      Options : 
         --create :  Craete Containers

         --drop :    Drop containers

         --infos :   Infos containers caracteristic (IP, Name, User ..)

         --start :   Starting containers

         --ansible : Deploying ansible

    "
fi
