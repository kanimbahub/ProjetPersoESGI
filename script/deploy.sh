#!/bin/bash

#####################################################################
#                                                                   # 
#     Description : déployement de mon environnement docker         #
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

#if no option, display help 
 else
   
     "

      Options : 
        -  --Create :  Craete Containers

        -  --Drop :    Drop containers

        -  --Infos :   Infos containers caracteristic (IP, Name, User ..)

        -  --Start :   Starting containers

        -  --Ansible : Deploying ansible

    "
fi