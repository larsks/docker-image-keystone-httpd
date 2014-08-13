This image runs the OpenStack Keystone service as a WSGI application
under Apache.  The admin endpoint URL for the keystone service will be
http://ip.of.container/keystone/admin/v2.0, while the non-admin
endpoint will be http://ip.of.container/keystone/main/v2.0.

The default `admin_token` is `ADMIN`.  So if you simply `docker run
larsks/keystone-httpd`, you can run:

    keystone --os-endpoint http://ip.of.container/keystone/admin/v2.0 \
      --os-service-token ADMIN tenant-create --name admin

