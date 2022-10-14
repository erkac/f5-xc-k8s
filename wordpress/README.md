# Wordpress on F5 XC

## Notes
- when using with regular K8s, I need to create the `namespace` and then create objects in that `namespace`
```shell
k apply -f ./yml/00-namespace.yml
k apply -f ./yml/01-secret.yml -n lk-wordpress
k apply -f ./yml/02-mysql-statefullset.yml -n lk-wordpress
```

## Fixing issues
For some reason the FQDN in Wordpress is not set correctly, the updates below will fix it.

### Mysql
```shell
# Pod terminal
mysql -u wordpress -p wordpress
```

```sql
UPDATE wp_options SET option_value='https://wordpress-demo.xc.f5demo.app' WHERE option_name='home' LIMIT 1;
UPDATE wp_options SET option_value='https://wordpress-demo.xc.f5demo.app' WHERE option_name='siteurl' LIMIT 1;
```

## Delete
```bash
vesctl configuration delete http_loadbalancer lk-wordpress -n lk-wordpress
vesctl configuration delete origin_pool lk-wordpress-pool -n lk-wordpress
```
