# options
IMAGENAME="fenicsproject/stable-mpi"

# file paths
CTLDIR="control"
SSHDIR="$CTLDIR/ssh"
SHAREDIR="share"

create_cluster () {
    # check argument
    if [ -z "$1" ]; then
        echo "Usage: create_cluster [host list file]"
        exit 1
    fi

    # create dirs
    mkdir -p "$CTLDIR"
    mkdir -p "$SSHDIR"
    mkdir -p "$SHAREDIR"

    # create a DSA key pair if it does not exist
    if [ ! -s "$SSHDIR/id_rsa" ]; then
        ssh-keygen -t rsa -b 4096 -N "" -f "$SSHDIR/id_rsa"
        cp $SSHDIR/id_rsa.pub $SSHDIR/authorized_keys
    fi
    
    # spawn all the docker instances
    while read line; do
        # get info from hostlist.txt
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
        # start container
        id=$(ssh $host $SSHPORT \
                 docker run -d -p 22 \
                 -v $PWD/$SSHDIR:/home/fenics/.ssh \
                 -v $PWD/$SHAREDIR:/home/fenics/share \
                 -v $PWD/$CTLDIR:/home/fenics/control \
                 $IMAGENAME)
        # save container id
        echo "$host $port $id" >> $CTLDIR/container_list
        # ask for the container ssh port
        r=$(ssh $host $SSHPORT docker port $id 22)
        tmp=(${r//:/ })
        container_port=${tmp[1]}
        # update ssh config
        echo "Host $host"                >> $SSHDIR/config
        echo "     Port $container_port" >> $SSHDIR/config
        echo "     User fenics"          >> $SSHDIR/config
        echo ""                          >> $SSHDIR/config
        # update hostfile
        echo "$host slots=$ncpu" >> $CTLDIR/hostlist
        # say it is done
        echo "Done."
        echo ""
    done < "$1"

    # finalize ssh config
    echo "Host *"                             >> $SSHDIR/config
    echo "     StrictHostKeyChecking no"      >> $SSHDIR/config
}

cleanup_cluster () {
    # check if there is a cluster running
    if [ ! -s "$CTLDIR/container_list" ]; then
        echo "No active cluster"
        exit 1
    fi    
    # remove containers one by one
    while read line; do
        # get info from container list
        array=($line)
        host=${array[0]}
        port=${array[1]}
        id=${array[2]}
        echo "Clean up $host..."
        ssh $host -p$port "docker stop $id && docker rm $id"
        echo "Done."
        echo ""
    done < $CTLDIR/container_list
    # remove control dir
    rm -rf $CTLDIR
}

connect_to_master () {
    # check if there is a cluster running
    if [ ! -s "$CTLDIR/container_list" ]; then
        echo "No active cluster"
        exit 1
    fi    
    # get master ip
    tmp=($(head $CTLDIR/container_list))
    master=${tmp[0]}
    # connect
    ssh -F $CTLDIR/ssh/config -i $CTLDIR/ssh/id_rsa $master
}
    
