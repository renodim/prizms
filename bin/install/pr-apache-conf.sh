#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/prizms/blob/master/bin/install/apache-conf.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/prizms/blob/master/bin/install/prizms-dependency-repos.sh>;
#3>    dcterms:isPartOf <http://purl.org/twc/id/software/prizms>;
#3> .

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
   echo
   echo "usage: `basename $0` [--DocumentRoot]"
   echo
   echo "  Returns the file path of the Apache httpd configuration file on the local system."
   exit
fi

PRIZMS_HOME=$(cd ${0%/*/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

if [[ "$1" == '--DocumentRoot' ]]; then

   conf=`$0`
   if [[ -e "$conf" ]]; then
      root=`grep DocumentRoot $conf | awk '{print $2}'`
      if [[ -d "$root" ]]; then
         echo $root
         exit
      fi
   else
      if [[ -d /etc/httpd ]]; then
         echo '/var/www/html' # CentOS
         exit 1
      elif [[ `which apache2 2> /dev/null` ]]; then
         echo '/var/www'
         exit 1
      fi
   fi

   exit 2
else

   # Ubuntu 10.04.4 LTS
   # /etc/apache2/sites-enabled/000-default: DocumentRoot /var/www
   #
   # Ubuntu 14.04.2 LTS
   # /etc/apache2/sites-enabled/000-default.conf:  DocumentRoot /var/www/html

   for sites in /etc/apache2/sites-available; do
      if [[ -d $sites ]]; then
         for conf in default 000-default 000-default.conf; do
            if [[ -f $sites/$conf ]]; then
               echo $sites/$conf
               exit 0
            fi
         done
      fi
   done

   exit 1
fi
