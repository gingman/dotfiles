deploy_prod() {
  rvm use system && cap prod1 deploy:setup -s milestone="$@" && cap prod1 deploy -s milestone="$@"
}

deploy_staging() {
  rvm use system && cap staging deploy:setup -s milestone="$@" && cap staging deploy -s milestone="$@"
}
