#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/prizms/blob/master/bin/install/prizms-dependency-repos.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/prizms/blob/master/bin/install/project-user.sh>;
#3>    dcterms:isPartOf <http://purl.org/twc/id/software/prizms>;
#3> .

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
   echo
   echo "usage: `basename $0` [-n]"
   echo
   echo "  Retrieves the dependency code repositories (e.g. csv2rdf4lod-automation, lodspeakr, DataFAQs, vsr)."
   exit
fi

PRIZMS_HOME=$(cd ${0%/*/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

if [ ! -e $PRIZMS_HOME/repos ]; then
   mkdir -p $PRIZMS_HOME/repos
fi

if [ ! -e $PRIZMS_HOME/lodspeakrs ]; then
   mkdir -p $PRIZMS_HOME/lodspeakrs
fi

#3> <http://purl.org/twc/id/software/prizms> 
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/csv2rdf4lod-automation>;
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/DataFAQs>;
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/vsr>;
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/pvcs>;
#3> .
pushd $PRIZMS_HOME/repos &> /dev/null
   for repos in https://github.com/timrdf/csv2rdf4lod-automation.git \
                https://github.com/timrdf/DataFAQs.git \
                https://github.com/timrdf/vsr.git \
                https://github.com/timrdf/pvcs.git; do
      echo
      directory=`basename $repos`
      directory=${directory%.*}
      echo $directory...
      if [ ! -e $directory ]; then
         # http://stackoverflow.com/questions/1209999/using-git-to-get-just-the-latest-revision
         echo git clone --depth=1 $repos
              git clone --depth=1 $repos
      else
         pushd $directory &> /dev/null
            git pull
         popd &> /dev/null
      fi
   done
   #if [[ ! -e semanteco-annotator-webapp.zip ]]; then
   #   #3> <http://purl.org/twc/id/software/prizms> 
   #   #3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/csv2rdf4lod-annotator>;
   #   #3> .
   #   #3> <http://purl.org/twc/id/software/csv2rdf4lod-annotator> 
   #   #3>    rdfs:seeAlso <https://github.com/timrdf/prizms/wiki/csv2rdf4lod-annotator> .
   #   # See https://github.com/timrdf/prizms/wiki/csv2rdf4lod-annotator
   #   echo
   #   echo "curl semanteco-annotator-webapp.zip"
   #   url='https://orion.tw.rpi.edu/jenkins/job/semanteco-prizms-support/lastStableBuild/edu.rpi.tw.escience%24semanteco-annotator-webapp/artifact/*zip*/archive.zip'
   #   #3> <http://purl.org/twc/id/software/prizms> 
   #   #3>    prov:wasDerivedFrom <http://dbpedia.org/resource/CURL>;
   #   #3> .
   #   curl --insecure --progress-bar $url > semanteco-annotator-webapp.zip
   #fi
   #if [[ -e semanteco-annotator-webapp.zip && 
   #    ! -d semanteco-annotator-webapp ]]; then
   #   #3> <http://purl.org/twc/id/software/prizms> 
   #   #3>    prov:wasDerivedFrom <http://dbpedia.org/resource/CURL>;
   #   #3> .
   #   unzip semanteco-annotator-webapp.zip -d semanteco-annotator-webapp
   #fi
   echo
popd &> /dev/null

#3> <http://purl.org/twc/id/software/prizms> 
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/prizms-lodspeakr>;
#3>    prov:wasDerivedFrom <http://purl.org/twc/id/software/csv2rdf4lod-lodspeakr>;
#3> .
#
# https://github.com/timrdf/prizms/issues/12
#
pushd $PRIZMS_HOME/lodspeakrs &> /dev/null
   for repos in https://github.com/timrdf/prizms-lodspeakr.git \
                https://github.com/timrdf/csv2rdf4lod-lodspeakr.git; do
                #https://github.com/jimmccusker/twc-healthdata.git \
      echo
      directory=`basename $repos`
      directory=${directory%.*}
      echo $directory...
      if [ ! -e $directory ]; then
         echo git clone $repos
              git clone $repos
         #echo git init $directory # sparse causes 'origin' conflict with the prizms repository.
         #     git init $directory
         #pushd $directory &> /dev/null
         #   echo git remote add -f origin $repos
         #        git remote add -f origin $repos
         #   git config core.sparsecheckout true
         #   echo lodspeakr >> .git/info/sparse-checkout
         #   git pull origin master
         #popd
      else
         pushd $directory &> /dev/null
            git pull
            #git pull origin master
         popd &> /dev/null
      fi
   done
   echo
popd &> /dev/null
