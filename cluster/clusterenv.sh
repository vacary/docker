# file paths
CTLDIR="control"
HOSTLIST="$CTLDIR/hostlist.txt"
CONTAINER_ID_LOG="$CTLDIR/container_ids.log"
SSHCONFIG="$CTLDIR/sshconfig"
HOSTFILEPATH="$CTLDIR/hostfile"
KEYNAME="fenics_mpi_key"
REMOTE_KEY_PATH="/tmp"
IMAGENAME="test"

create_cluster () {
    # create the temp directory if it does not exist
    if [ ! -d "$CTLDIR" ]; then
        mkdir "$CTLDIR" 
    fi

    # create a DSA key pair if it does not exist
    if [ ! -s "$CTLDIR/$KEYNAME" ]; then
        ssh-keygen -t rsa -b 4096 -N "" -f "$CTLDIR/$KEYNAME"
    fi
    
    # check if host list exists
    if [ ! -s "$HOSTLIST" ]; then
        echo >&2 "Bad host list file."
        kill -INT $$
    fi

    # spawn all the docker instances
    while read line; do
        # read info from hostlist.txt
        array=($line)
        ncpu=${array[0]}
        host=${array[1]}
        port=${array[2]}
        if [ -z $port ]; then
            echo "Spawn a container on $host... "
            SSHPORT=""
            SCPPORT=""
            port="22"
        else
            echo "Spawn a container on $host:$port..."
            SSHPORT=" -p$port"
            SCPPORT=" -P$port"
        fi
        # send the public key
        scp $SCPPORT $CTLDIR/$KEYNAME.pub $host:$REMOTE_KEY_PATH
        # start container
        id=$(ssh $host $SSHPORT \
                 docker run -d -p 22 \
                 -v $REMOTE_KEY_PATH/$KEYNAME.pub:/home/fenics/.ssh/authorized_keys \
                 $IMAGENAME)
        # save container id
        echo "$host $port $id" >> $CONTAINER_ID_LOG
        # ask for the container ssh port
        r=$(ssh $host $SSHPORT docker port $id 22)
        tmp=(${r//:/ })
        container_port=${tmp[1]}
        # update sshconfig
        echo "Host $host"                >> $SSHCONFIG
        echo "     Port $container_port" >> $SSHCONFIG
        echo "     User fenics"          >> $SSHCONFIG
        echo ""                          >> $SSHCONFIG
        # update hostfile
        echo "$host slots=$ncpu" >> $HOSTFILEPATH
        # finish up
        echo "Done."
        echo ""
    done < $HOSTLIST

    # prepare sshconfig
    echo "Host *" >> $SSHCONFIG
    echo "     StrictHostKeyChecking no" >> $SSHCONFIG
    echo "     IdentityFile $CTLDIR/$KEYNAME" >> $SSHCONFIG
}

cleanup_cluster () {
    # check if host list exists
    if [ ! -s "$CONTAINER_ID_LOG" ]; then
        echo >&2 "No container id file."
        kill -INT $$
    fi

    while read line; do
        # read info from container id log
        array=($line)
        host=${array[0]}
        port=${array[1]}
        id=${array[2]}
        echo "Clean up $host..."
        # remove the public key and containers
        ssh $host -p$port "
           rm $REMOTE_KEY_PATH/$KEYNAME.pub
           docker stop $id
           docker rm $id
        "
        echo "Done."
        echo ""
    done < $CONTAINER_ID_LOG
    
    rm $CONTAINER_ID_LOG
    rm $SSHCONFIG
    rm $HOSTFILEPATH
}

### --- Code snippets to allow multiple docker containers on a host --- ###
## This should not be the start point. Save for later..
# while read line; do
#     # read info from hostlist.txt
#     array=($line)
#     n=${array[0]}
#     host=${array[1]}
#     port=${array[2]}
#     if [ -z $port ]; then
#         echo "Connecting to $host to spawn $n containers..."
#         SSHPORT=""
#         SCPPORT=""
#     else
#         echo "Connecting to $host:$port to spawn $n containers..."
#         SSHPORT=" -p $port"
#         SCPPORT=" -P $port"
#     fi
#     # write to container id log
#     echo $line >> $CONTAINER_ID_LOG
#     # spawn containers
#     for (( i=1; i<=n; i++ ))
#     do
#         printf "   Spawn container #$i... "
#         # send the public key
#         scp $CTLDIR/id_rsa.pub $host:$REMOTE_KEY_PATH $SCPPORT
#         # docker run
#         id=$(ssh $host $SSHPORT \
#                  docker run -d -p 22 \
#                  -v $REMOTE_KEY_PATH:/home/fenics/.ssh/authorized_keys \
#                  $IMAGENAME)
#         echo $id >> $CONTAINER_ID_LOG
#         # ask for the container ssh port
#         r=$(ssh $host $SSHPORT \
#                 docker port $id 22)
#         tmp=(${r//:/ })
#         rport=${arr[1]}
        
#         printf "[done].\n"
#     done
