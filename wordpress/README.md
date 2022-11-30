# Wordpress on F5 XC

## Notes
- when using with regular K8s, I need to create the `namespace` and then create objects in that `namespace`
```shell
k apply -f ./yml/00-namespace.yml
k apply -f ./yml/01-secret.yml -n lk-wordpress
k apply -f ./yml/02-mysql-statefullset.yml -n lk-wordpress
```

- scaling works only via editing `05-wordpress-deployment.yml` -> `replicas: X`

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



## Multisite deployment

### mysql TCP LB



**TCP Load balancer**

![CleanShot 2022-11-29 at 21.52.20](img/README/CleanShot%202022-11-29%20at%2021.52.20.png)

**Origin Pool**

![CleanShot 2022-11-29 at 21.52.52](img/README/CleanShot%202022-11-29%20at%2021.52.52.png)

**Publishing**

![CleanShot 2022-11-29 at 21.50.46](img/README/CleanShot%202022-11-29%20at%2021.50.46.png)

**App Traffic**

![CleanShot 2022-11-30 at 11.32.25](img/README/CleanShot%202022-11-30%20at%2011.32.25.png)
