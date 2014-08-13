FROM fedora:20

RUN yum -y install mod_wsgi
RUN yum -y install openstack-keystone
RUN mkdir -p /var/www/cgi-bin/keystone
RUN ln /usr/share/keystone/keystone.wsgi /var/www/cgi-bin/keystone/main
RUN ln /usr/share/keystone/keystone.wsgi /var/www/cgi-bin/keystone/admin
RUN usermod -G keystone apache
RUN chmod g+rwx /var/log/keystone
RUN chmod g+s /var/log/keystone

ADD wsgi-keystone.conf /etc/httpd/conf.d/wsgi-keystone.conf
ADD keystone.conf /etc/keystone/keystone.conf

RUN chgrp keystone /etc/keystone/keystone.conf
RUN chmod g+rwx /var/lib/keystone

USER keystone
RUN keystone-manage db_sync
USER root
RUN chgrp keystone /var/lib/keystone/keystone.db
RUN chmod g+rw /var/lib/keystone/keystone.db
RUN chgrp keystone /var/log/keystone/keystone.log
RUN chmod g+rw /var/log/keystone/keystone.log

CMD /usr/sbin/httpd -DFOREGROUND

