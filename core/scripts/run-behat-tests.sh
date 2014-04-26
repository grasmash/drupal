#! /bin/bash -e
# Utilize this command by running ./run-behat-tests.sh https://your.site.url
# You may append additional arguments or flags accepted by the behat binary.
# E.g., ./run-behat-tests.sh https://your.site.url --tags="~@javascript"

if (( $# < 1 ))
then
  echo "Usage: The first argument must be the base_url of the site to test. Subsequent argument will be passed directly to Behat"
  exit 1
fi

_drupal_root() {
  # Go up until we find index.php
  current_dir=`pwd`;
  while [ ${current_dir} != "/" -a -d "${current_dir}" -a \
          ! -f "${current_dir}/index.php" ] ;
  do
    current_dir=$(dirname "${current_dir}") ;
  done
  if [ "$current_dir" == "/" ] ; then
    exit 1 ;
  else
    echo "$current_dir" ;
  fi
}

# Set base_url to the first argument and then shift argument off of list.
base_url=$1
shift

# Set drupal_root.
drupal_root=`_drupal_root` && \

# Set default Behat parameters. These can be overridden if a custom behat.yml
# file is specified with the -c parameter.
export BEHAT_PARAMS="extensions[Drupal\DrupalExtension\Extension][drupal][drupal_root]=$drupal_root&extensions[Behat\MinkExtension\Extension][base_url]=$base_url"

cd $drupal_root/core
$drupal_root/core/vendor/bin/behat "$@"

