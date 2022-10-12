# Natulus S3

## S3 Setup

Request access keys and store them with their endpoints.

The `access-east` file:
```bash
ACCESS_KEY_ID=
SECRET_ACCESS_KEY=
ENDPOINT_URL=https://s3-east.nrp-nautilus.io
```

The `access-west` file:
```bash
ACCESS_KEY_ID=
SECRET_ACCESS_KEY=
ENDPOINT_URL=https://s3-west.nrp-nautilus.io
```

Sample FUSE mount (east)
```bash
s3fs test1 /data -o passwd_file=.s3fs -o url=https://s3-east.nrp-nautilus.io -o use_path_request_style
```

Password file `.s3fs`
```
. ./access-east
echo "$ACCESS_KEY_ID:$SECRET_ACCESS_KEY" > .s3fs
```

## S3cmd

```cmd
python3 -m pip install s3cmd
```

Config file `.s3cfg` for `s3cmd`

For $ZONE in east west ; do
```bash
ZONE=east
. ./access-$ZONE
cat > s3cfg-$ZONE <<EOF
[default]
access_key = $ACCESS_KEY_ID
secret_key = $SECRET_ACCESS_KEY
host_base = $ENDPOINT_URL
host_bucket = $ENDPOINT_URL
use_https = True
EOF
```

Copy secrets to pod:
```
kubectl cp s3cfg-east home:/home/$USER
kubectl cp s3cfg-west home:/home/$USER
```

East `s3cmd --config=s3cfg-east ls`
West `s3cmd --config=s3cfg-west ls`
