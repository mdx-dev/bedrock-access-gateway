# This creates just one tag without a hash.
bake APP:
    docker buildx bake {{APP}}

# This creates two tags, one with the current Git hash and the other without.
bake-hashed APP:
    SUFFIX="-$(git rev-parse --short HEAD)" docker buildx bake {{APP}}
