FROM fedora:20

RUN yum -y install mod_wsgi
RUN yum -y install openstack-keystone
RUN mkdir -p /var/www/cgi-bin/keystone
RUN ln /usr/share/keystone/keystone.wsgi /var/www/cgi-bin/keystone/main
RUN ln /usr/share/keystone/keystone.wsgi /var/www/cgi-bin/keystone/admin

ADD wsgi-keystone.conf /etc/httpd/conf.d/wsgi-keystone.conf
ADD keystone.conf /etc/keystone/keystone.conf

RUN chown -R apache:apache /var/log/keystone
RUN chown -R apache:apache /var/lib/keystone
RUN chown -R apache:apache /etc/keystone

USER apache
RUN keystone-manage db_sync
RUN keystone-manage pki_setup

USER root
CMD /usr/sbin/httpd -DFOREGROUND

