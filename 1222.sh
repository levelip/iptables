mkdir /tmp/conf$(date +"%Y%m%d")-backup
cd  /tmp/conf$(date +"%Y%m%d")-backup
tar jcvf conf.tar.bz2 /usr/local/nginx/conf
sh /web/dropbox_uploader.sh upload /tmp/conf$(date +"%Y%m%d")-backup /conf$(date +"%Y%m%d")
rm -rf /tmp/conf$(date +"%Y%m%d")-backup
